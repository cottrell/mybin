#!/bin/bash
# Improved internet monitoring script
# Logs timestamp, hostname, internet_status, wifi_status, packet_loss, min_rtt, avg_rtt, max_rtt

TARGET="8.8.8.8"
COUNT=3
TIMEOUT=2

while true
do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    hostname=$(hostname)
    wifi_status="wifidown" # Ethernet is active, wifi is ignored per user
    
    # Ping with RTT data
    ping_out=$(ping -c $COUNT -W $TIMEOUT $TARGET 2>&1)
    
    if [ $? -eq 0 ]; then
        internet_status="online"
        loss=$(echo "$ping_out" | grep -oP '\d+(?=% packet loss)')
        rtts=$(echo "$ping_out" | grep 'rtt' | cut -d'=' -f2 | tr -d ' ms')
        min_rtt=$(echo $rtts | cut -d'/' -f1)
        avg_rtt=$(echo $rtts | cut -d'/' -f2)
        max_rtt=$(echo $rtts | cut -d'/' -f3)
    else
        internet_status="offline"
        loss=100
        min_rtt="NaN"
        avg_rtt="NaN"
        max_rtt="NaN"
    fi

    echo "$timestamp,$hostname,$internet_status,$wifi_status,$loss,$min_rtt,$avg_rtt,$max_rtt"
    sleep 5
done
