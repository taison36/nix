#!/bin/sh
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

ctx_size_fmt=""
if [ -n "$ctx_size" ]; then
  ctx_size_fmt=$(echo "$ctx_size" | awk '{ if ($1 >= 1000) printf "%.0fk", $1/1000; else print $1 }')
fi

if [ -n "$used_pct" ] && [ -n "$total_input" ] && [ -n "$total_output" ] && [ -n "$ctx_size" ]; then
  total_tokens=$((total_input + total_output))
  printf "\033[1m%s\033[0m  ctx: %.0f%% (%s / %s tokens)" \
    "$model" \
    "$used_pct" \
    "$(echo "$total_tokens" | awk '{ if ($1 >= 1000) printf "%.1fk", $1/1000; else print $1 }')" \
    "$ctx_size_fmt"
elif [ -n "$model" ] && [ -n "$ctx_size_fmt" ]; then
  printf "\033[1m%s\033[0m  ctx: %s tokens" "$model" "$ctx_size_fmt"
elif [ -n "$model" ]; then
  printf "\033[1m%s\033[0m" "$model"
fi
