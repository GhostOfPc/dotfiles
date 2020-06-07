#!/bin/bash
if
	pgrep spotifyd
then
	kill -9 $(pgrep spotifyd)
fi
spotifyd
spt
