#!/bin/sh
# ~/.config/sway/status.sh

while true; do
    # 1. Network Status (Displays Connected ESSID or 'Disconnected')
    WLAN_IFACE=$(ip route | grep default | awk '{print $5}')
    if [ -n "$WLAN_IFACE" ]; then
        WIFI_NAME=$(iwgetid -r "$WLAN_IFACE" 2>/dev/null || echo "Connected")
        NET_STAT="net: $WIFI_NAME"
    else
        NET_STAT="net: down"
    fi

    # 2. Audio Volume Status
    VOL_STAT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{
        if ($3 == "[MUTED]") print "vol: mute";
        else print "vol: " $2 * 100 "%"
    }')
    [ -z "$VOL_STAT" ] && VOL_STAT="vol: --"

    # 3. Battery Capacity & Status (Skips block if desktop machine lacks battery)
    if [ -d /sys/class/power_supply/BAT0 ]; then
        BAT_PERC=$(cat /sys/class/power_supply/BAT0/capacity)
        BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)
        if [ "$BAT_STATUS" = "Charging" ]; then
            BAT_STAT="bat: +${BAT_PERC}%"
        else
            BAT_STAT="bat: ${BAT_PERC}%"
        fi
    else
        BAT_STAT=""
    fi

    # 4. RAM Usage
    RAM_STAT=$(free -h | awk '/^Mem:/ {print "ram: " $3 "/" $2}')

    # 5. Formatted Date and Time
    DATE_TIME=$(date "+%a %b %d  %I:%M %p")

    # Combine metrics using an elegant text separator
    OUTPUT="$NET_STAT   │   $VOL_STAT   │   $RAM_STAT"
    if [ -n "$BAT_STAT" ]; then
        OUTPUT="$OUTPUT   │   $BAT_STAT"
    fi
    OUTPUT="$OUTPUT   │   $DATE_TIME "

    echo "$OUTPUT"
    sleep 2
done
