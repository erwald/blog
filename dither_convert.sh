#!/bin/bash

dry_run=false
convert_all=false
inputs=()

dither() {
    magick "$1" -resize "${3}x" -gamma 1.5 -attenuate "$4" +noise gaussian -monochrome \
        +level-colors "black,white" "$2"
}

while [[ $# -gt 0 ]]; do
    case $1 in
    --dry-run)
        dry_run=true
        shift
        ;;
    --convert-all)
        convert_all=true
        shift
        ;;
    -*)
        echo "unknown option: $1"
        exit 1
        ;;
    *)
        inputs+=("$1")
        shift
        ;;
    esac
done

if [ ${#inputs[@]} -gt 0 ]; then
    for img in "${inputs[@]}"; do
        if [ ! -f "$img" ]; then
            echo "skipping (not a file): $img"
            continue
        fi
        filename=$(basename "$img")
        base="${filename%.*}"
        if [[ "$base" == *_dithered ]]; then
            echo "skipping (already dithered): $img"
            continue
        fi
        dest="$(dirname "$img")/${base}_dithered.png"

        if [ "$dry_run" = true ]; then
            echo "would convert: $img to $dest"
        else
            dither "$img" "$dest" 660 1.2
            echo "converted: $img to $dest"
        fi
    done
    exit 0
fi

for img in img_original/hero/*; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    dest="img/hero/${filename%.*}.png"
    dest_substack="img/hero/${filename%.*}_substack.png"
    dest_thumbnail="img/hero/${filename%.*}_thumbnail.png"

    if [ "$convert_all" = true ] || [ ! -f "$dest" ]; then
        if [ "$dry_run" = true ]; then
            echo "would convert: $img to $dest"
        else
            mkdir -p img/hero
            dither "$img" "$dest" 660 1.2
            dither "$img" "$dest_substack" 730 1.2
            dither "$img" "$dest_thumbnail" 300 0.6
            echo "converted: $img to $dest and $dest_substack and $dest_thumbnail"
        fi
    fi
done

for img in img_original/*; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    dest="img/$filename"

    if [ ! -f "$dest" ]; then
        if [ "$dry_run" = true ]; then
            echo "would copy: $img to $dest"
        else
            cp "$img" "$dest"
            echo "copied: $img to $dest"
        fi
    fi
done
