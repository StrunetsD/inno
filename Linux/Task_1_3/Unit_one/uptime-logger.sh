#!/bin/bash
while true; do

    load=$(uptime | sed 's/,/./g' | awk -F 'load average: ' '{print $2}' | awk '{print $1}' | sed 's/\.$//')

    if (( $(echo "$load > 1" | bc -l) )); then
        echo "$(date) $(uptime)" >> /var/log/overload
    else
        echo "$(date) $(uptime)" >> /var/log/uptime.log
    fi
    sleep 15
done