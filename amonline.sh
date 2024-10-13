#!/bin/bash

while true
do
    # Get the current date and time
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Set default values for the status
    internet_status="offline"
    wifi_status="down"

    # Check if we're connected to the internet by pinging Google's DNS server
    if ping -c 1 8.8.8.8 &> /dev/null
    then
        internet_status="online"
    fi

    # Check if WiFi is up (using iwconfig)
    wifi_check=$(iwconfig 2>&1 | grep -i "ESSID")

    if [[ "$wifi_check" != *"off/any"* && -n "$wifi_check" ]]; then
        wifi_status="up"
    fi

    # Alternatively, if you're using NetworkManager (nmcli), uncomment this:
    # wifi_check=$(nmcli -t -f WIFI g)
    # if [[ "$wifi_check" == "enabled" ]]; then
    #     wifi_status="up"
    # fi

    # Output the status as a CSV one-liner with the date
    echo "$timestamp,$(hostname),$internet_status,$wifi_status"
    sleep 1
done
