#!/bin/bash

ns_source() {
    magick "$1" -alpha off -channel R \
        -fx '0.212656*pow(min(max(u.r,0),1),1/1.5) +
             0.715158*pow(min(max(u.g,0),1),1/1.5) +
             0.072186*pow(min(max(u.b,0),1),1/1.5)' \
        -channel R -separate +channel -set colorspace Gray \
        -depth 32 -define quantum:format=floating-point "$2"
}

ns_mean() {
    # area averaging avoids computing unrelated full-image statistics.
    magick "$1" -scale '1x1!' -precision 17 -format '%[fx:u.r]' info:
}

ns_gaussian_kernel() {
    awk -v sigma="$1" -v axis="$2" 'BEGIN {
        radius = int(4*sigma + 0.5)
        n = 2*radius + 1
        sum = 0
        for (i = -radius; i <= radius; i++) {
            weights[i] = exp(-i*i/(2*sigma*sigma))
            sum += weights[i]
        }
        if (axis == "x") printf "%dx1+%d+0:", n, radius
        else printf "1x%d+0+%d:", n, radius
        for (i = -radius; i <= radius; i++) {
            printf "%s%.17g", (i == -radius ? " " : ","), weights[i]/sum
        }
    }'
}

ns_box_kernel() {
    awk -v n="$1" -v axis="$2" 'BEGIN {
        radius = int(n/2)
        if (axis == "x") printf "%dx1+%d+0:", n, radius
        else printf "1x%d+0+%d:", n, radius
        for (i = 0; i < n; i++) printf "%s%.17g", (i == 0 ? " " : ","), 1/n
    }'
}

ns_convolve() {
    local input=$1 output=$2 kernel=$3 size=$4 horizontal vertical
    horizontal=$("$kernel" "$size" x) || return
    vertical=$("$kernel" "$size" y) || return
    # mirror boundaries reflect edge pixels; float miff preserves precision.
    magick "$input" -virtual-pixel mirror \
        -morphology Convolve "$vertical" -morphology Convolve "$horizontal" \
        -depth 32 -define quantum:format=floating-point "$output"
}

ns_gaussian() {
    ns_convolve "$1" "$2" ns_gaussian_kernel "$3"
}

ns_box_mean() {
    ns_convolve "$1" "$2" ns_box_kernel "${3:-25}"
}

ns_expression() {
    local output=$1 expression=$2
    shift 2
    magick "$@" -fx "$expression" \
        -depth 32 -define quantum:format=floating-point "$output"
}

ns_moments() {
    local input=$1 mean_output=$2 sd_output=$3 size=${4:-25} horizontal vertical
    horizontal=$(ns_box_kernel "$size" x) || return
    vertical=$(ns_box_kernel "$size" y) || return
    magick "$input" -virtual-pixel mirror \
        \( +clone -morphology Convolve "$vertical" -morphology Convolve "$horizontal" \
        -depth 32 -define quantum:format=floating-point -write "$mean_output" \) \
        \( -clone 0 -fx 'u*u' -morphology Convolve "$vertical" \
        -morphology Convolve "$horizontal" \) \
        -delete 0 -fx 'sqrt(max(u[1]-u[0]*u[0],0))' \
        -depth 32 -define quantum:format=floating-point "$sd_output"
}

# use four-neighbour connectivity and treat pixels outside the mask as false.
nc_dilate() {
    if [ "$3" -eq 0 ]; then
        magick "$1" "$2"
    else
        magick "$1" -virtual-pixel black -morphology "Dilate:$3" Diamond:1 "$2"
    fi
}

# select foreground labels directly; area-threshold also fills background holes.
nc_core() (
    nc_tmp=$(mktemp -d "${TMPDIR:-/tmp}/dither-core.XXXXXXXX") || exit 1
    trap 'rm -rf "$nc_tmp"' EXIT
    magick "$1" -colorspace Gray -threshold 50% -depth 8 \
        -define connected-components:verbose=true -connected-components 4 \
        -format 'QuantumRange: %[fx:quantumrange]\n' info: \
        > "$nc_tmp/components.txt" || exit 1
    nc_colors=$(awk '
        $1 == "QuantumRange:" { quantum = $2 }
        $1 ~ /^[0-9]+:$/ && $4 >= 400 && $5 == "gray(255)" {
            sub(/:$/, "", $1)
            ids[++n] = $1
        }
        END {
            if (!quantum) exit 1
            for (i = 1; i <= n; i++) printf "gray(%.17g%%)\n", 100*ids[i]/quantum
        }
    ' "$nc_tmp/components.txt") || exit 1
    # quarter-label fuzz tolerates rounding without matching adjacent ids.
    # re-label in memory to avoid truncating ids at the source bit depth.
    nc_fuzz=$(awk '$1 == "QuantumRange:" {printf "%.17g%%", 25/$2}' \
        "$nc_tmp/components.txt") || exit 1
    nc_args=("$1" -colorspace Gray -threshold 50% -depth 8
        -connected-components 4 -fuzz "$nc_fuzz" -fill white)
    while IFS= read -r nc_color; do
        if [ -n "$nc_color" ]; then
            nc_args+=(-opaque "$nc_color")
        fi
    done <<< "$nc_colors"
    magick "${nc_args[@]}" -fill black +opaque white \
        -virtual-pixel black -morphology Erode:3 Diamond:1 "$2"
)

ds_select() {
    ns_source source.png source_raw.miff
    ns_gaussian source_raw.miff source.miff 1.4
    ns_moments source.miff source_mean.miff source_sd.miff
    ns_expression informative.miff 'u>0.012' source_sd.miff
    local informative normalizer pixels method measures measure
    informative=$(ns_mean informative.miff)
    pixels=$(magick identify -format '%[fx:w*h]' source.png)
    normalizer=$(awk -v a="$informative" -v n="$pixels" '
        BEGIN {printf "%.17g", (a > 1/n ? a : 1/n)}')
    ns_gaussian current.png baseline.miff 4
    ds_structure baseline.miff base
    ns_expression lost.miff '(u<0.025 || u>0.975) && v>0.025' baseline.miff source_sd.miff
    ns_expression visible.miff 'u>0.04 && v>0.45 && u[2]>0' \
        base_amp.miff base_correlation.miff informative.miff
    ns_expression black.miff 'u<0.025' baseline.miff
    nc_core black.miff core.miff
    : > metrics.tsv
    for method in soft4 soft8 adaptive_contrast adaptive_smooth; do
        ns_gaussian "$method.png" candidate.miff 4
        ds_structure candidate.miff candidate
        ns_expression change.miff 'abs(u-v)' candidate.miff baseline.miff
        ns_expression recovery.miff 'u>0 && v>u[2]+0.015 && u[3]>0.45 && u[4]>0.02' \
            lost.miff candidate_sd.miff base_sd.miff candidate_correlation.miff change.miff
        nc_dilate recovery.miff allowance.miff 4
        ns_expression damage.miff 'u>0 && v==0 && u[2]>0.08' \
            core.miff allowance.miff candidate.miff
        ns_expression flat.miff 'u==0 ? max(v-0.02,0) : 0' informative.miff change.miff
        ns_expression collapse.miff \
            'u>0 ? min(1,max(0,(0.025-v)/0.025))*min(1,max(0,(u[2]-0.04)/0.05)) : 0' \
            visible.miff candidate_amp.miff base_amp.miff
        measures=$(
            for measure in recovery flat collapse damage change; do
                ns_mean "$measure.miff" || exit $?
                printf ' '
            done
        )
        printf '%s %s\n' "$method" "$measures" | awk -v n="$normalizer" '{
            whole = 100*$2
            info = whole/n
            flat = 100*$3/n
            collapse = 100*$4/n
            core = 100*$5/n
            score = info - flat - collapse - 0.25*core
            printf "%s %.17g %.17g %.17g %.17g %.17g %.17g %.17g\n",
                $1, whole, info, flat, collapse, core, $6, score
        }' >> metrics.tsv
    done
    # prefer the least change among candidates scoring at least 85% of best.
    ds_selected=$(awk '
        $2 >= 0.5 && $3 >= 5 && $8 > 0 {
            name[++n] = $1
            change[n] = $7
            score[n] = $8
            if ($8 > best) best = $8
        }
        END {
            chosen = "current"
            for (i = 1; i <= n; i++) {
                if (score[i] >= 0.85*best &&
                    (chosen == "current" || change[i] < smallest ||
                     (change[i] == smallest && (score[i] > chosen_score ||
                      (score[i] == chosen_score && name[i] < chosen))))) {
                    chosen = name[i]
                    smallest = change[i]
                    chosen_score = score[i]
                }
            }
            print chosen
        }' metrics.tsv)
}

ds_structure() {
    local input=$1 prefix=$2
    ns_moments "$input" "${prefix}_mean.miff" "${prefix}_sd.miff"
    ns_expression product.miff 'u*v' source.miff "$input"
    ns_box_mean product.miff product_mean.miff
    ns_expression "${prefix}_amp.miff" '(u-v*u[2])/max(u[3],0.000001)' \
        product_mean.miff source_mean.miff "${prefix}_mean.miff" source_sd.miff
    ns_expression "${prefix}_correlation.miff" 'u/max(v,0.000001)' \
        "${prefix}_amp.miff" "${prefix}_sd.miff"
}

ds_tones() {
    # clip only the analysis histogram; renders retain source precision.
    magick "$1" -resize 660x -gamma 1.5 -grayscale Rec709Luma -clamp -depth 8 gray:- |
        od -An -v -tu1 | awk '
        {
            for (i = 1; i <= NF; i++) {
                hist[$i]++
                n++
            }
        }
        END {
            if (!n) exit 1
            for (i = 0; i < 256; i++) {
                cumulative += hist[i]
                if (!low_found && cumulative >= 0.05*n) {
                    low = i
                    low_found = 1
                }
                if (cumulative >= 0.95*n) {
                    high = i
                    break
                }
            }
            fraction = ((high-low)/255 - 0.35)/(0.80-0.35)
            fraction = fraction < 0 ? 0 : (fraction > 1 ? 1 : fraction)
            strength = sprintf("%.4f", 4+8*fraction) + 0
            blend = sprintf("%.5f", (strength-4)/8) + 0
            printf "%.6g %.8g,%.8g,%.8g,0\n",
                strength, 3.2*blend, -4.8*blend, 1+1.6*blend
        }' > tone.txt
    read -r ds_strength ds_polynomial < tone.txt
}

ds_render() {
    local source=$1 target=$2 width=$3 attenuation=$4 method=$5
    local tone=(-gamma 1.5)
    case "$method" in
        current) ;;
        soft4) tone+=(+sigmoidal-contrast '4x50%') ;;
        soft8) tone+=(+sigmoidal-contrast '8x50%') ;;
        adaptive_contrast) tone+=(+sigmoidal-contrast "${ds_strength}x50%") ;;
        adaptive_smooth)
            tone+=(+sigmoidal-contrast '4x50%')
            [[ "$ds_polynomial" == '0,-0,1,0' || "$ds_polynomial" == '0,0,1,0' ]] ||
                tone+=(-function Polynomial "$ds_polynomial")
            ;;
        *)
            echo "unknown treatment: $method" >&2
            return 1
            ;;
    esac
    magick "$source" -resize "${width}x" "${tone[@]}" -seed 42 \
        -attenuate "$attenuation" +noise gaussian -monochrome \
        +level-colors black,white "PNG:$target"
}

ds_absolute() {
    local directory
    directory=$(cd -- "$(dirname -- "$1")" && pwd -P) || return
    printf '%s/%s\n' "$directory" "$(basename -- "$1")"
}

# call as a simple command; using if/|| disables errexit inside this subshell.
dither() (
    set -e
    set -o pipefail
    export LC_ALL=C
    local source scratch method dest stage width attenuation mode dimensions opaque
    local ds_strength ds_polynomial ds_selected creation_mask
    local destinations=() widths=() attenuations=() stages=()
    source=$(ds_absolute "$1")
    shift
    while (($#)); do
        destinations+=("$(ds_absolute "$1")")
        widths+=("$2")
        attenuations+=("$3")
        shift 3
    done
    command -v magick > /dev/null || {
        echo 'ImageMagick is required.' >&2
        exit 1
    }
    [[ $(magick -version) == *HDRI* ]] || {
        echo 'Automatic selection requires an HDRI build of ImageMagick.' >&2
        exit 1
    }
    scratch=$(mktemp -d "${TMPDIR:-/tmp}/dither-select.XXXXXXXX")
    trap '
        rm -rf -- "$scratch"
        for stage in "${stages[@]}"; do rm -f -- "$stage"; done
    ' EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM
    cd -- "$scratch"
    [[ $(magick identify -ping -format '%n\n' "$source") == 1 ]] || {
        echo 'Automatic selection requires a single-frame source.' >&2
        exit 1
    }
    magick "$source" -resize 660x -depth 8 source.png
    opaque=$(magick identify -format '%[opaque]' source.png)
    [[ "$opaque" == True ]] || {
        echo 'Automatic selection requires an opaque source.' >&2
        exit 1
    }
    ds_tones "$source"
    for method in current soft4 soft8 adaptive_contrast adaptive_smooth; do
        ds_render "$source" "$method.png" 660 1.2 "$method"
    done
    ds_select
    creation_mask=$(umask)
    local i
    for ((i = 0; i < ${#destinations[@]}; i++)); do
        dest=${destinations[i]}
        width=${widths[i]}
        attenuation=${attenuations[i]}
        [[ ! -d "$dest" && ! "$dest" -ef "$source" ]] || {
            echo "Invalid destination: $dest" >&2
            exit 1
        }
        stage=$(mktemp "$(dirname -- "$dest")/.dither-stage.XXXXXXXX")
        stages+=("$stage")
        if [[ "$width" == 660 && "$attenuation" == 1.2 ]]; then
            cp -- "$ds_selected.png" "$stage"
        else
            ds_render "$source" "$stage" "$width" "$attenuation" "$ds_selected"
        fi
        dimensions=$(magick identify -format '%w %h' "$stage")
        [[ ${dimensions%% *} == "$width" && ${dimensions#* } -gt 0 ]] || exit 1
        if [[ -e "$dest" ]]; then
            mode=$(stat -f '%Lp' "$dest" 2> /dev/null) || mode=$(stat -c '%a' "$dest")
        else
            printf -v mode '%o' "$((0666 & ~(8#$creation_mask)))"
        fi
        chmod "$mode" "$stage"
    done
    # finish every render before replacing any existing output.
    for ((i = 0; i < ${#destinations[@]}; i++)); do
        mv -f -- "${stages[i]}" "${destinations[i]}"
    done
    printf 'selected automatically: %s (seed 42)\n' "$ds_selected"
)

main() {
    local dry_run=false convert_all=false
    local img filename base dest dest_substack dest_thumbnail status
    local inputs=()
    while (($#)); do
        case "$1" in
            --dry-run) dry_run=true ;;
            --convert-all) convert_all=true ;;
            -*)
                echo "unknown option: $1" >&2
                return 1
                ;;
            *) inputs+=("$1") ;;
        esac
        shift
    done
    if ((${#inputs[@]})); then
        for img in "${inputs[@]}"; do
            if [[ ! -f "$img" ]]; then
                echo "skipping (not a file): $img"
                continue
            fi
            filename=$(basename -- "$img")
            base=${filename%.*}
            if [[ "$base" == *_dithered ]]; then
                echo "skipping (already dithered): $img"
                continue
            fi
            dest="$(dirname -- "$img")/${base}_dithered.png"
            if [[ "$dry_run" == true ]]; then
                echo "would convert: $img to $dest"
            else
                dither "$img" "$dest" 660 1.2
                status=$?
                ((status == 0)) || return "$status"
                echo "converted: $img to $dest"
            fi
        done
        return 0
    fi
    for img in img_original/hero/*; do
        [[ -f "$img" ]] || continue
        filename=$(basename -- "$img")
        dest="img/hero/${filename%.*}.png"
        dest_substack="img/hero/${filename%.*}_substack.png"
        dest_thumbnail="img/hero/${filename%.*}_thumbnail.png"
        if [[ "$convert_all" == true || ! -f "$dest" ]]; then
            if [[ "$dry_run" == true ]]; then
                echo "would convert: $img to $dest"
            else
                mkdir -p img/hero || return
                dither "$img" "$dest" 660 1.2 \
                    "$dest_substack" 730 1.2 "$dest_thumbnail" 300 0.6
                status=$?
                ((status == 0)) || return "$status"
                echo "converted: $img to $dest and $dest_substack and $dest_thumbnail"
            fi
        fi
    done
    for img in img_original/*; do
        [[ -f "$img" ]] || continue
        filename=$(basename -- "$img")
        dest="img/$filename"
        if [[ ! -f "$dest" ]]; then
            if [[ "$dry_run" == true ]]; then
                echo "would copy: $img to $dest"
            else
                cp -- "$img" "$dest" || return
                echo "copied: $img to $dest"
            fi
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
