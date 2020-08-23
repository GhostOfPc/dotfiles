#!/bin/sh

up_t=$(awk '{print int($1)}' < /proc/uptime)
up_d=$(($up_t / (3600 * 24)))
up_h=$(($up_t % (3600 * 24) / 3600))
up_m=$((($up_t % (3600 * 24) % 3600) / 60))
echo ⏳$up_d"d:"$up_h"h:"$up_m"m"
