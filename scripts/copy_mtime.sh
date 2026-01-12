if [[ $# -ne 2 ]]; then
  echo "Usage: $0 input_file output_file"
  exit 1
fi

input_file=$1
output_file=$2
# Set the modification time of the new file to be the same as the original
touch -t $(stat -f "%SB" -t "%Y%m%d%H%M.%S" "$input_file") "$output_file"
