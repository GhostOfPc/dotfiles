#!/usr/bin/env bash

sites=(H_Quran Jf Gg YT Gmail DDG B2000 ANB LN Ambito Info Clrn Ml Ghub PTx Phb FO Cb AW hqp ep Pd Amzn ebay Ali Wiki AwesomeWM Studio Whb)
urls=("http://quran.ksu.edu.sa/index.php?l=ar" "http://localhost:8096" "https://www.google.com" "https://www.youtube.com" "https://mail.google.com" "https://duckduckgo.com" "https://www.bariloche2000.com/" "https://www.anbariloche.com.ar/" "https://www.lanacion.com.ar/" "https://www.ambito.com/" "https://www.infobae.com/" "https://www.clarin.com/" "https://www.mercadolibre.com.ar" "https://github.com/" "https://www.porntrex.com/categories/lesbian/" "https://www.pornhub.com/" "https://www.freeones.com/" "https://chaturbate.com/female-cams/" "https://wiki.archlinux.org/" "https://hqporner.com/category/lesbian" "https://www.eporner.com/" "https://www.porndig.com/" "https://www.amazon.com/" "https://www.ebay.com/" "https://www.aliexpress.com/" "https://en.wikipedia.org/wiki/Main_Page" "https://awesomewm.org/doc/api/" "https://studio.youtube.com/channel/UCcTA9vmwpyPKpI0Hxjb8B6w", "https://whoreshub.com")

menu=$(printf '%s\n' "${sites[@]}" | dmenu -i -l 3 -g 10 -p "Open: ")

for i in "${!sites[@]}"; do
  if [ ! -z "$menu" ] && [[ "${sites[$i]}" = $menu ]]; then
      $BROWSER "${urls[i]}"
  fi
done
