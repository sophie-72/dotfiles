#!/bin/bash

# Store the previous state of connected devices
previous_devices=()

# Function to send notifications
send_notification() {
    local action=$1
    local device_name=$2
    notify-send "Bluetooth Device $action" "$device_name has been $action."
}

# Infinite loop to monitor Bluetooth devices
while true; do
    # Get the list of currently connected devices and store them in an array
    IFS=$'\n' read -r -d '' -a current_devices < <(bluetoothctl devices Connected | grep "Device" | awk '{print $2}' | xargs -I {} bluetoothctl info {} | grep "Alias" | cut -d ' ' -f 2- && printf '\0')

    # Compare current devices with previous devices
    if [ "${#current_devices[@]}" -ne "${#previous_devices[@]}" ]; then
        # Check for new connections
        for device in "${current_devices[@]}"; do
            if [[ ! " ${previous_devices[*]} " =~ " $device " ]]; then
                send_notification "Connected" "$device"
            fi
        done

        # Check for disconnections
        for device in "${previous_devices[@]}"; do
            if [[ ! " ${current_devices[*]} " =~ " $device " ]]; then
                send_notification "Disconnected" "$device"
            fi
        done

        # Update the previous devices list
        previous_devices=("${current_devices[@]}")
    fi

    # Wait for a short period before checking again
    sleep 2
done

