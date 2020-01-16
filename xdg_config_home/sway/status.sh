wifi=$(iw dev wlp61s0 link | rg -o 'SSID: \w+' | cut -d' ' -f2)
wifi_signal=$(iwconfig wlp61s0 | rg -o '\d+/\d+')
wifi_signal=$(awk "BEGIN { print int(100 * $wifi_signal) }")

batnow=$(cat /sys/class/power_supply/BAT0/energy_now)
batmax=$(cat /sys/class/power_supply/BAT0/energy_full)
batdischarge=$(cat /sys/class/power_supply/BAT0/energy_full)
batpct=$(awk "BEGIN { print int(100 * ${batnow} / ${batmax}) }")

if [[ $(cat /sys/class/power_supply/AC/online) -eq 1 ]]; then
	if [[ ${batpct} -eq '100' ]]; then
        battery="full"
	else
        battery="${batpct}% (charging)"
	fi
else
    battery="${batpct}%"
fi

echo "W ${wifi} ${wifi_signal}% | B ${battery} | $(date +'%Y-%m-%d %H:%M' ) "
