# pihole-led
## Realtime LED alerts when an ad is blocked when using pi-hole.

pihole-led.sh will parse /var/log/pihole.log for the string "/etc/pihole/gravity.list" and if found it will set gpio header pin 11 (wiringpi pin 0) to high (on) briefly then turn it back off making it blink once for each entry found in near realtime.

*Requires ([wiringPi](http://wiringpi.com/)) to be installed*
*wiringPi for the odroid here: https://github.com/hardkernel/wiringPi*

Comment out the echo line in the loop if you don't want textual updates to the terminal.

I personally just run it in a screen session, but you could probably run this as a cron @reboot job or the likes.

Attribution and more info: http://www.stinebaugh.info/get-led-alerts-for-each-blocked-ad-using-pi-hole/
