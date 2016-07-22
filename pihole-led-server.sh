#!/bin/bash
#
# pihole-led-server :: Listens for value being sent by pihole-led.sh on specified port. Default: 31415
# USAGE: pihole-led-server.sh [port number]

[[ `which nc` ]] || { echo "Netcat not installed." >&2; exit 1; }

#setup gpio pin
pin=0
gpio mode $pin out
gpio write $pin 0
port=${1:-31415}

localLed() {
  gpio write $pin 1
  sleep ${ledDur:-.2}
  gpio write $pin 0
# echo "another ad bites the dust!"
  sleep 0.1
}

echo "Listing on ${port}.." >&2
nc -nkl ${port} | while read INPUT; do
  localLed &
done
