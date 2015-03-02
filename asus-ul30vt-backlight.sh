#!/bin/sh

# Directory where backlight exists
# strangely, for the ul30vt (dual video cards) 
# even if the nvidia card is in use, backlight
# control only works through the intel_backlight
KEYS_DIR=/sys/class/backlight/intel_backlight

test -d $KEYS_DIR || exit 0

MIN=0
MAX=$(cat $KEYS_DIR/max_brightness)
VAL=$(cat $KEYS_DIR/brightness)
STEP=$((MAX / 8)) #the visual indicator in xubuntu seems to have 8 steps

if [ "$1" = down ]; then
	VAL=$((VAL-STEP))
else
	VAL=$((VAL+STEP))
fi

if [ "$VAL" -lt $MIN ]; then
	VAL=$MIN
elif [ "$VAL" -gt $MAX ]; then
	VAL=$MAX
fi

echo $VAL > $KEYS_DIR/brightness
