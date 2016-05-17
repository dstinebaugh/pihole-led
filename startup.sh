#!/bin/bash
###########
### Provides an easy way to run my pihole-led.sh script on boot in it's own screen session.
### https://github.com/dstinebaugh/pihole-led
### Built for my script however you can modify as needed of course.
### Don't forget to change the Settings block below to match your locations!
### BLINKLOC should be the folder that has pihole-led.sh in it
### HISTORY is the number of scrollback lines in the screen session. Unless you have uncommented the echo line in the
###  pihole script, there's not really any need for a scrollback so I've lowered it to keep memory use down on the pi.
###########
### Version:        0.1
### Author:         Daniel Stinebaugh
### Attribution:    http://www.stinebaugh.info/pihole-led-startup-script/
### Date:           04/20/2016
### License:        Copyleft. Enjoy!
###########

#### Settings
# Linux user to run as
USERNAME='daniel'
# folder holding the pihole-led.sh file
BLINKLOC='/home/daniel/'
# script name to run
INVOCATION="pihole-led.sh"
# history log of screen session keeping it small to save resources.
HISTORY=10
### End Settings


ME=`whoami`
 as_user() {
   if [ $ME == $USERNAME ] ; then
     bash -c "$1"
   else
     su - $USERNAME -c "$1"
   fi
 }


if pgrep -u $USERNAME -f $INVOCATION > /dev/null
then
        echo "pihole-led is already running!"
        echo " Check your screen sessions."
        exit 420
else
        echo "Starting pihole-led.sh in a new screen session..."
        cd $BLINKLOC
        as_user "cd $BLINKLOC && screen -h $HISTORY -dmS blink $BLINKLOC$INVOCATION"
        sleep 5
        if pgrep -u $USERNAME -f $INVOCATION > /dev/null
        then
                logger -s "pihole-led.sh is now running."
        else
                logger -s "[ALERT] Couldn't Validate pihole-led.sh Started Properly!"
        fi
fi
echo "Startup Script complete."

exit 0
