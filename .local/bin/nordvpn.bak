#!/bin/sh

actions=(Login Logout Connect Disconnect)
coms=("nordvpn login" "nordvpn logout" "nordvpn connect Brazil" "nordvpn disconnect")

selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "Action: ")

for i in "${!actions[@]}"; do
  if [ ! -z "$selected" ] && [[ "${actions[$i]}" = $selected ]]; then
      ${coms[i]}
  fi
done
