#!/bin/bash

ins_pkg=$(pacman -Qq | wc -l)
upd_pkg=$(checkupdates | wc -l)


echo "📦 $upd_pkg ($ins_pkg)"
