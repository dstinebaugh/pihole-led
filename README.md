# pihole-led
## Realtime LED alerts when an ad is blocked when using pi-hole.

pihole-led.sh will parse /var/log/pihole.log for the string "/etc/pihole/gravity.list" and if found it will set gpio header pin 11 (wiringpi pin 0) to high (on) briefly then turn it back off making it blink once for each entry found in near realtime.

*Requires ([wiringPi](http://wiringpi.com/)) to be installed*

*wiringPi for the odroid here: https://github.com/hardkernel/wiringPi*

Comment out the echo line 25 in the loop if you don't want textual updates to the terminal.

I have now also included a startup script to launch the pihole-led.sh script on boot. Just edit the values in the Setting block and include it's location to your /etc/rc.local file.

The startup script will launch a new screen session named "blink" so the screen package is also required to be installed. (It's in your repos most likely) 

Attribution and more info: http://www.stinebaugh.info/get-led-alerts-for-each-blocked-ad-using-pi-hole/
