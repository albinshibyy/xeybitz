#!/bin/bash

while true; do
    # Clear the screen for each new menu and output
    clear

    # Display the menu
    echo "Choose an option:"
    echo "1. Display system uptime"
    echo "2. Display boot time"
    echo "3. Show boot logs"
    echo "4. Display system info"
    echo "5. Exit"
    echo "6. Display disk usage"
    echo "7. Display memory usage"
    echo "8. List running processes"
    echo "9. Show network interfaces"
    echo "10. Show system load"
    echo "11. Check disk health"
    echo "12. Show battery status (laptops)"
    echo "13. Show recent system logs"
    echo "14. Check available updates"
    echo "15. Show Sensor Infos"
    echo "16. Show disk I/O statistics"

    # Prompt user for input
    read -p "Enter your choice (1-16): " choice

    # Perform action based on choice using if-else
    if [ "$choice" -eq 1 ]; then
        # Option 1: Display system uptime
        echo "System Uptime: $(uptime -p)"
    elif [ "$choice" -eq 2 ]; then
        # Option 2: Display boot time
        echo "Boot Time: $(systemd-analyze)"
    elif [ "$choice" -eq 3 ]; then
        # Option 3: Show boot logs
        echo "Boot Logs:"
        dmesg | grep -i 'boot'
    elif [ "$choice" -eq 4 ]; then
        # Option 4: Display system info
        echo "System Info: "
        uname -a
    elif [[ "$choice" -eq 5 || "$choice" == "exit" || "$choice" == "no" ]]; then
            # Option 5: Exit the program (handling multiple inputs: 5, exit, or no)
            echo "Exiting..."
            break
    elif [ "$choice" -eq 6 ]; then
        # Option 6: Display disk usage
        echo "Disk Usage:"
        df -h
    elif [ "$choice" -eq 7 ]; then
        # Option 7: Display memory usage
        echo "Memory Usage:"
        free -h
    elif [ "$choice" -eq 8 ]; then
        # Option 8: List running processes
        echo "Running Processes:"
        ps aux --sort=-%cpu | head -10
    elif [ "$choice" -eq 9 ]; then
        # Option 9: Show network interfaces
        echo "Network Interfaces:"
        ip addr show
    elif [ "$choice" -eq 10 ]; then
        # Option 10: Show system load
        echo "System Load:"
        uptime
    elif [ "$choice" -eq 11 ]; then
        # Option 11: Check disk health
        echo "Disk Health (SMART Status):"
        sudo smartctl -a /dev/sda | grep 'SMART Health'
    elif [ "$choice" -eq 12 ]; then
        # Option 12: Show battery status
        echo "Battery Status:"
        upower -i $(upower -e | grep 'battery') | grep -E "state|to\ full|percentage"
    elif [ "$choice" -eq 13 ]; then
        # Option 13: Show recent system logs
        echo "Recent System Logs:"
        journalctl -n 20 --no-pager
    elif [ "$choice" -eq 14 ]; then
        # Option 14: Check available updates
        echo "Checking for available updates..."
        if command -v apt > /dev/null; then
            sudo apt update && sudo apt list --upgradable
        elif command -v pacman > /dev/null; then
            sudo pacman -Sy --needed
        fi
    elif [ "$choice" -eq 15 ]; then
        # Option 15: Show CPU temperature
        echo "Sensor Info:"
        sensors
    elif [ "$choice" -eq 16 ]; then
        # Option 16: Show disk I/O statistics
        echo "Disk I/O Statistics:"
        iostat -dx 1 10
    else
        # Invalid choice
        echo "Invalid choice. Please try again."
    fi

    # Wait for user to press a key before continuing
    read -n 1 -s -r -p "Press any key to continue..."
done
