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
### Attribution:	http://stinebaugh.info
### Date: 			03/19/2016
### License: 		Copyleft. Enjoy!
###########
pin=0
gpio mode $pin out
# Defaults the pin to low when starting
gpio write $pin 0
tailf /var/log/pihole.log | while read INPUT
do
   if [[ "$INPUT" == *"/etc/pihole/gravity.list"* ]]; then
       gpio write $pin 1
       sleep 0.2
       gpio write $pin 0
       echo "another ad bites the dust!"
       sleep 0.1
    fi
done
