#!/bin/bash
# Convert all images in the current directory to webp
# Usage: all_to_webp.sh [-o output_dir] [magick_args...]
# -o output_dir  write webp files to output_dir (default: same dir as source)
# Extra arguments are forwarded to the magick command
set -e

if ! command -v magick &>/dev/null; then
  echo "$(tput setaf 3)Error: Please install magick"
  exit 1
fi

output_dir=""
while getopts "o:" opt; do
  case $opt in
    o) output_dir="$OPTARG" ;;
    *) echo "Usage: $0 [-o output_dir] [magick_args...]"; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

[ -n "$output_dir" ] && mkdir -p "$output_dir"

MAX_JOBS=4

# Collect files that need conversion (skip if webp exists with matching mtime)
declare -a inputs outputs
while IFS= read -r f; do
  if [ -n "$output_dir" ]; then
    out="${output_dir}/$(basename "${f%.*}").webp"
  else
    out="${f%.*}.webp"
  fi
  if [ ! -f "$out" ] || [ "$f" -nt "$out" ] || [ "$f" -ot "$out" ]; then
    inputs+=("$f")
    outputs+=("$out")
  fi
done < <(find . -maxdepth 1 -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \))

if [ "${#inputs[@]}" -eq 0 ]; then
  echo "No image files need conversion (all webp files are up to date)."
  exit 0
fi

echo "The following ${#inputs[@]} files will be converted to WebP${*:+ with arguments $*}:"
for i in "${!inputs[@]}"; do
  echo "  ${inputs[$i]} -> ${outputs[$i]}"
done
[ -n "$output_dir" ] && echo "Output directory: $output_dir"

read -rp "Proceed with conversion? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT

  for i in "${!inputs[@]}"; do
    # Wait if at max concurrent jobs
    while [ "$(jobs -r | wc -l)" -ge "$MAX_JOBS" ]; do
      sleep 0.1
    done

    (
      if magick "${inputs[$i]}" "$@" "${outputs[$i]}"; then
        touch -r "${inputs[$i]}" "${outputs[$i]}"
        echo "Converted: ${inputs[$i]} -> ${outputs[$i]}"
        touch "$tmpdir/ok.$i"
      else
        echo "Failed: ${inputs[$i]} -> ${outputs[$i]}"
        touch "$tmpdir/fail.$i"
      fi
    ) &
  done
  wait

  converted=$(find "$tmpdir" -name 'ok.*' | wc -l | tr -d ' ')
  failed=$(find "$tmpdir" -name 'fail.*' | wc -l | tr -d ' ')
  echo "Complete. Successfully converted: $converted file(s)"
  [ "$failed" -gt 0 ] && echo "Failed: $failed file(s)"
else
  echo "Aborted."
fi
