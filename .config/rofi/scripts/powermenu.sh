#!/usr/bin/env bash

# CMDs
uptime_info=$(uptime -p | sed -e 's/up //g')
host=$(hostnamectl hostname)

# Options
options=("Lock" "Suspend" "Logout" "Reboot" "Shutdown" "Hibernate")

# Execute Command
run_cmd() {
    case $1 in
        "Lock")
            hyprlock
            ;;
        "Suspend")
            systemctl suspend
            ;;
        "Logout")
            hyprctl dispatch exit 0
            ;;
        "Reboot")
            systemctl reboot
            ;;
        "Shutdown")
            systemctl poweroff
            ;;
        "Hibernate")
            systemctl hibernate
            ;;
        *)
            echo "choose: $1"
            ;;
    esac
}

# Display rofi menu and capture selection
chosen_option=$(printf "%s\n" "${options[@]}" | \
	rofi -dmenu -i -p "$USER@$host" -mesg "Uptime: $uptime_info" \
	-kb-select-1 "l" \
	-kb-select-2 "u" \
	-kb-select-3 "e" \
	-kb-select-4 "r" \
	-kb-select-5 "s" \
	-kb-select-6 "h" \
	-theme ~/.config/rofi/powermenu.rasi)

# Execute selected command
if [[ -n "$chosen_option" ]]; then
    run_cmd "$chosen_option"
fi