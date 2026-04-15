#!/usr/bin/env bash
set -euo pipefail

# Replaces:  %#= current_user.uid
# With:      %#= current_user.uid
# in all files under the current directory (recursively).

root="${1:-.}"

LC_ALL=C find "$root" -type f -name '*.html.erb' -print0 |
  xargs -0 grep -Il -- '%#= current_user.uid' |
  while IFS= read -r file; do
    # macOS/BSD sed needs -i '' ; GNU sed uses -i
    if sed --version >/dev/null 2>&1; then
      sed -i 's/%#= current_user\.uid/%= current_user.uid/g' "$file"
    else
      sed -i '' 's/%#= current_user\.uid/%= current_user.uid/g' "$file"
    fi
  done
