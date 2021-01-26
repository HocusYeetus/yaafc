#!/bin/bash

FILE_PWM=$(echo /sys/class/drm/card0/device/hwmon/hwmon?/pwm1)
FILE_MODE=$(echo /sys/class/drm/card0/device/hwmon/hwmon?/pwm1_enable)
FILE_TEMP=$(echo /sys/class/drm/card0/device/hwmon/hwmon?/temp2_input)

REFRESH=3

function set_mode() {
    echo "setting fan mode to $1"
    echo $1 >$FILE_MODE
}

if [ $# -ne 2 ]; then
    echo "needs temp_min and temp_max"
    exit 1
fi

set_mode 1

# make the equation
# Ax + B
# values are multiplied by 100 to keep 2 decimals
A=$((100 * 255 / ($2 - $1)))
B=$((100 * $1 * 255 / ($2 - $1)))

# result is divided by 100 to compensate for that
# (A * 85 - B)/100

# clamps to 10 or 255 PWM
# prints temp and pwm for debug ;_;
function calc_pwm() {
    TEMP=$(cat $FILE_TEMP)
    TEMP=$((TEMP / 1000))
    PWM=$(((A * TEMP - B) / 100))
    if [ $PWM -lt 10 ]; then
        PWM=10
    elif [ $PWM -gt 255 ]; then
        PWM=255
    fi
    echo "$TEMP C : $PWM"
    set_pwm $PWM
}

# change pwm value if different from previous value
function set_pwm() {
    OLD_PWM=$(cat $FILE_PWM)
    echo "old: $OLD_PWM"
    if [ $1 -ne $OLD_PWM ]; then
        echo $1 >$FILE_PWM
    fi
}

# change back to auto upon exit
function reset_on_exit() {
    echo ""
    echo "Setting mode to auto"
    set_mode 2
    exit 0
}

trap "reset_on_exit" SIGINT SIGTERM

while true; do
    sleep $REFRESH
    clear
    calc_pwm
done
