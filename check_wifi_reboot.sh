#!/bin/bash

# Configurable parameters
WIFI_CHECK_INTERVAL=60  # Time between Wi-Fi checks (in seconds)
WIFI_FAIL_THRESHOLD=5   # Number of consecutive failures before reboot (in minutes)
LOG_FILE="/var/log/check_wifi.log"

# Internal variables
FAIL_COUNT=0

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

check_wifi() {
    # Replace 'wlan0' with your Wi-Fi interface if needed
    local interface="wlan0"
    if ! /sbin/iw dev "$interface" link | grep -q "Connected"; then
        return 1
    fi
    return 0
}

while true; do
    if check_wifi; then
        log "Wi-Fi is online."
        FAIL_COUNT=0
    else
        FAIL_COUNT=$((FAIL_COUNT + 1))
        log "Wi-Fi is offline. Fail count: $FAIL_COUNT"
    fi

    if (( FAIL_COUNT >= WIFI_FAIL_THRESHOLD )); then
        log "Wi-Fi offline for too long. Rebooting..."
        sudo reboot
        sleep 5  # Ensure the system reboots; this shouldn't be reached if reboot works
    fi

    sleep $WIFI_CHECK_INTERVAL
done

