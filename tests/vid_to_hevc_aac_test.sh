#!/bin/bash
set -euo pipefail

repo_root=$(cd "$(dirname "$0")/.." && pwd)
script="$repo_root/scripts/vid_to_hevc_aac.sh"
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

mkdir "$temp_dir/bin"
touch "$temp_dir/input.mts"

cat > "$temp_dir/bin/ffprobe" <<'EOF'
#!/bin/bash
case "$*" in
  *stream=codec_name*)
    if [[ "$*" == *"v:0"* ]]; then
      echo h264
    else
      echo "${MOCK_AUDIO_CODEC:-ac3}"
    fi
    ;;
  *stream=channels*) echo "${MOCK_AUDIO_CHANNELS:-6}" ;;
  *stream=channel_layout*) echo "${MOCK_AUDIO_LAYOUT:-5.1(side)}" ;;
esac
EOF

cat > "$temp_dir/bin/ffmpeg" <<'EOF'
#!/bin/bash
printf '%s\n' "$@" > "$FFMPEG_ARGUMENTS"
touch "${!#}"
EOF

chmod +x "$temp_dir/bin/ffprobe" "$temp_dir/bin/ffmpeg"

assert_contains() {
  if ! grep -Fqx -- "$1" "$temp_dir/ffmpeg-arguments"; then
    echo "Expected ffmpeg argument '$1' was not present" >&2
    exit 1
  fi
}

assert_not_contains() {
  if grep -Fqx -- "$1" "$temp_dir/ffmpeg-arguments"; then
    echo "Unexpected ffmpeg argument '$1' was present" >&2
    exit 1
  fi
}

run_converter() {
  PATH="$temp_dir/bin:$PATH" FFMPEG_ARGUMENTS="$temp_dir/ffmpeg-arguments" \
    "$script" "$temp_dir/input.mts" "$temp_dir/output.mp4" >/dev/null
}

# AC-3 5.1(side) must be converted to standard 5.1 AAC instead of AAC PCE.
run_converter
assert_contains -channel_layout
assert_contains 5.1
assert_contains aac

# Standard AAC is already Apple-compatible and should be copied.
MOCK_AUDIO_CODEC=aac MOCK_AUDIO_LAYOUT=5.1 run_converter
assert_contains copy
assert_not_contains -channel_layout

echo "vid_to_hevc_aac tests passed"
