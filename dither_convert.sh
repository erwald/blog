#!/bin/bash

dry_run=false
convert_all=false

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
    *)
        echo "unknown option: $1"
        exit 1
        ;;
    esac
done

for img in img_original/hero/*; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    dest="img/hero/${filename%.*}.png"
    dest_thumbnail="img/hero/${filename%.*}_thumbnail.png"

    if [ "$convert_all" = true ] || [ ! -f "$dest" ]; then
        if [ "$dry_run" = true ]; then
            echo "would convert: $img to $dest"
        else
            mkdir -p img/hero
            magick "$img" -resize 660x -gamma 1.5 -attenuate 1.2 +noise gaussian -monochrome \
                +level-colors "black,white" "$dest"
            magick "$img" -resize 300x -gamma 1.5 -attenuate 0.6 +noise gaussian -monochrome \
                +level-colors "black,white" "$dest_thumbnail"
            echo "converted: $img to $dest and $dest_thumbnail"
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
