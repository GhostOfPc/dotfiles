  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  freq=$(awk '/^[c]pu MHz/ {print}' /proc/cpuinfo | awk 'NR==1 {print int($4),$2}')
  echo -e "🖥️ $freq($cpu%)"


