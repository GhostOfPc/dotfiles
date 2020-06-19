#!/bin/sh

sites=(Gg YT DDG B2000 ANB LN Ambito Info Clrn Ml Gml Ghub PTx Phb FO Cb AW hqp ep Pd Amzn ebay Ali Wp)
urls=("https://www.google.com" "https://www.youtube.com" "https://duckduckgo.com" "https://www.bariloche2000.com/" "https://www.anbariloche.com.ar/" "https://www.lanacion.com.ar/" "https://www.ambito.com/" "https://www.infobae.com/" "https://www.clarin.com/" "https://www.mercadolibre.com.ar" "https://mail.google.com/mail/" "https://github.com/" "https://www.porntrex.com/" "https://www.pornhub.com/" "https://www.freeones.com/" "https://chaturbate.com/" "https://wiki.archlinux.org/" "https://hqporner.com/" "https://www.eporner.com/" "https://www.porndig.com/" "https://www.amazon.com/" "https://www.ebay.com/" "https://www.aliexpress.com/" "https://en.wikipedia.org/wiki/Main_Page")

menu=$(printf '%s\n' "${sites[@]}" | dmenu -i -p "Open: ")

for i in "${!sites[@]}"; do
  if [ ! -z "$menu" ] && [[ "${sites[$i]}" = $menu ]]; then
      $BROWSER "${urls[i]}"
  fi
done
