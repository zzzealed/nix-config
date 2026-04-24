#!/usr/bin/env bash

active=()

while IFS= read -r iface; do
  if systemctl is-active --quiet "wg-quick-${iface}.service"; then
    active+=("${iface}: active")
  fi
done < <(systemctl list-unit-files 'wg-quick-*.service' --no-legend \
  | awk '{print $1}' \
  | sed 's/wg-quick-\(.*\)\.service/\1/')

if (( ${#active[@]} > 0 )); then
  printf '%s\n' "${active[@]}"
fi
