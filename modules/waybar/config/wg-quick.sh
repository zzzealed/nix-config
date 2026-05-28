#!/usr/bin/env bash

active=()

while IFS= read -r iface; do
  if systemctl is-active --quiet "wireguard-${iface}.service"; then
    active+=("${iface}: active")
  fi
done < <(systemctl list-unit-files 'wireguard-*.service' --no-legend \
  | awk '{print $1}' \
  | sed 's/wireguard-\(.*\)\.service/\1/')

if (( ${#active[@]} > 0 )); then
  printf '%s\n' "${active[@]}"
fi
