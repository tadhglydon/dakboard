#!/bin/sh

# Enable and disable HDMI output on the Raspberry Pi

is_off ()
{
        vcgencmd display_power | grep "display_power=0" >/dev/null
}

case $1 in
        off)
                vcgencmd display_power 0
        ;;
        on)
                if is_off
                then
                        vcgencmd display_power 1
                        curr_vt=`fgconsole`
                        if [ "$curr_vt" = "1" ]
                        then
                                chvt 2
                                chvt 1
                        else
                                chvt 1
                                chvt "$curr_vt"
                        fi
                fi
        ;;
        status)
                if is_off
                then
                        echo off
                else
                        echo on
                fi
        ;;
        *)
                echo "Usage: $0 on|off|status" >&2
                exit 2
        ;;
esac

exit 0

