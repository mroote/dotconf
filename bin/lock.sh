#!/usr/bin/env bash

#depends on: imagemagick, i3lock, scrot

LOCK_ICON=$HOME/.config/screen-lock.png
LOCK_TEXT=$(fortune -s literature)
LOCK_TEXT_TMP=/tmp/locktext.png
LOCK_TMP=/tmp/lock.png

scrot $LOCK_TMP
convert $LOCK_TMP -scale 10% -scale 1000% -fill black -colorize 20% $LOCK_TMP

if [[ -f $LOCK_ICON ]]; then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $LOCK_ICON | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)

    SR=$(xrandr --query | grep ' connected' | sed 's/primary //g' |  cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
        TEXT_PX=$(($SROX))
        TEXT_PY=$(($PY + 200))
        # Create text banner with correct dimensions
        convert -size $(echo $SRX)x80 xc:grey -font Liberation-Sans -pointsize 18 -fill black -gravity center -annotate +0+0 "$LOCK_TEXT" $LOCK_TEXT_TMP
        convert $LOCK_TEXT_TMP -alpha set -channel A -evaluate set 50% $LOCK_TEXT_TMP
        # Create lock screen images
        convert $LOCK_TMP $LOCK_TEXT_TMP -geometry +$TEXT_PX+$TEXT_PY -composite $LOCK_TMP
        convert $LOCK_TMP $LOCK_ICON -geometry +$PX+$PY -composite -matte $LOCK_TMP
    done
fi

# lock screen with tmp image
i3lock -e -n -i $LOCK_TMP
