# pihole-led
Realtime LED alerts when an ad is blocked when using pi-hole
pihole-led.sh will parse /var/log/pihole.log for the string "/etc/pihole/gravity.list" and if found it will set header pin 11 on the odroid c1+ high for a half second.
Requires wiringPi to be installed from here: https://github.com/hardkernel/wiringPi
Attribution: http://www.stinebaugh.info/get-led-alerts-for-each-blocked-ad-using-pi-hole/
