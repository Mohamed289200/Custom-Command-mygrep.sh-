#!/bin/bash

# Function to print usage
usage() {
  echo "Usage: $0 [-n] [-v] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match (print non-matching lines)"
  echo "  --help Show this help message"
}

# Check if no arguments
if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi

# Initialize flags
show_line_numbers=false
invert_match=false

# Parse options
while [[ "$1" == -* ]]; do
  case "$1" in
    -n) show_line_numbers=true ;;
    -v) invert_match=true ;;
    --help) usage; exit 0 ;;
    -*) # Handle combined options like -vn, -nv
      for ((i=1; i<${#1}; i++)); do
        opt="${1:i:1}"
        case "$opt" in
          n) show_line_numbers=true ;;
          v) invert_match=true ;;
          *) echo "Unknown option: -$opt"; usage; exit 1 ;;
        esac
      done
      ;;
  esac
  shift
done

# Now, first non-option argument is search string
search_string="$1"
shift

# Next argument should be the filename
filename="$1"

# Validate inputs
if [[ -z "$search_string" ]]; then
  echo "Error: Missing search string."
  usage
  exit 1
fi

if [[ -z "$filename" ]]; then
  echo "Error: Missing filename."
  usage
  exit 1
fi

if [[ ! -f "$filename" ]]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

# Now perform the search
line_number=0
while IFS= read -r line; do
  ((line_number++))
  # Match check (case-insensitive)
  if echo "$line" | grep -iq -- "$search_string"; then
    matched=true
  else
    matched=false
  fi

  # Handle invert match
  if $invert_match; then
    matched=$(! $matched && echo true || echo false)
  fi

  # Print if matches condition
  if $matched; then
    # Highlight matched word (case-insensitive replacement)
    highlighted_line=$(echo "$line" | sed -E "s/($search_string)/\x1B[1;33m\1\x1B[0m/Ig")
    
    if $show_line_numbers; then
      echo "${line_number}:$highlighted_line"
    else
      echo "$highlighted_line"
    fi
  fi
done < "$filename"
