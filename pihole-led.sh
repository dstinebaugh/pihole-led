#!/bin/bash
###########
### This pihole-led script is built for the odroid c1+ using wiringPi here:
### https://github.com/hardkernel/wiringPi
### Built for pihole log's however you can modify as needed of course.
### I use header pin 9 for the ground and pin 11 for gpio.
### header 11 is equal to export gpio=88 or wiringPi pin=0 as used below.
###########
### Version: 		0.1
### Author: 		Daniel Stinebaugh
### Attribution:	http://www.stinebaugh.info/get-led-alerts-for-each-blocked-ad-using-pi-hole/
### Date: 			03/19/2016
### License: 		Copyleft. Enjoy!
###########

# Settings: off==0, on==1
localLed=0
remoteLed=1
#remoteIp=127.0.0.1
#remotePort=31415
#ledDur=.2 # LED lit duration in seconds

#FIXME: we should check if localLed=1 before initilizing local GPIO pin
#setup gpio pin
pin=0
gpio mode $pin out
gpio write $pin 0

localLed() {
  gpio write $pin 1
  sleep ${ledDur:-.2}
  gpio write $pin 0
# echo "another ad bites the dust!"
  sleep 0.1
}

remoteLed() {
  #[[ `which nc` ]] || { echo "ERROR - netcat (/bin/nc) not found." >&2; return 1; } 
  ## Send $ledDur (default: .2) to remote HOST:PORT (default: 127.0.0.1:31415) via netcat
  #echo "sending signal to LED @ ${remoteIp:-127.0.0.1}:${remotePort:-31415}"
  echo "${ledDur:-.2}" | nc ${remoteIp:-127.0.0.1} ${remotePort:-31415}
}

tailf -n0 /var/log/pihole.log | while read INPUT
do
  if [[ "$INPUT" == *"/etc/pihole/gravity.list"* ]]; then
    [[ "$localLed" == "1" ]] && localLed &
    [[ "$remoteLed" == "1" ]] && remoteLed &
    wait
  fi
done
