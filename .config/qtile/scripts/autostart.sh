#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

nitrogen --restore &
picom --experimental-backends &
dunt &
lxsession &
