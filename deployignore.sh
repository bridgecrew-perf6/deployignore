#!/bin/bash

patterns=()
patternsToExclude=()

while IFS= read -r line; do
  if [[ -z $line ]] || [[ $line =~ ^\# ]]; then
    continue
  elif [[ $line =~ ^\! ]]; then
    patternsToExclude+=($line)
  else
    patterns+=($line)
  fi
done < ".deployignore"

for pattern in "${patterns[@]}"; do
  find . -wholename "./$pattern" ${patternsToExclude[@]/"!"/"! -wholename ./"} 2>/dev/null -exec rm -rf "{}" \; || true
done