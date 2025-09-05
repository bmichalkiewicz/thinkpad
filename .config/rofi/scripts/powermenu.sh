#!/usr/bin/env bash

# CMDs
uptime_info=$(uptime -p | sed -e 's/up //g')
host=$(hostnamectl hostname)

# Options with Icons and Text
options=("Lock" "Suspend" "Logout" "Reboot" "Shutdown" "Hibernate")
icons=("" "" "󰿅" "󱄌" "" "󰒲")

# Generate options with icons
options_with_icons=()
for ((i = 0; i < ${#options[@]}; i++)); do
    options_with_icons+=("${icons[$i]} ${options[$i]}")
done

# Execute Command
run_cmd() {
    case $1 in
        "")
            hyprlock
            ;;
        "")
            systemctl suspend
            ;;
        "󰿅")
            hyprctl dispatch exit 0
            ;;
        "󱄌")
            systemctl reboot
            ;;
        "")
            systemctl poweroff
            ;;
        "󰒲")
            systemctl hibernate
            ;;
        *)
            echo "choose: $1"
            ;;
    esac
}

# Display rofi menu and capture selection
chosen_option=$(printf "%s\n" "${options_with_icons[@]}" | \
	rofi -dmenu -i -p " $USER@$host" -mesg " Uptime: $uptime_info" \
	-kb-select-1 "l" \
	-kb-select-2 "u" \
	-kb-select-3 "e" \
	-kb-select-4 "r" \
	-kb-select-5 "s" \
	-kb-select-6 "h" \
	-theme ~/.config/rofi/powermenu.rasi)

# Execute selected command
if [[ -n "$chosen_option" ]]; then
    # Extract just the icon (first character before the space)
    icon=$(echo "$chosen_option" | sed 's/ .*//')
    run_cmd "$icon"
fi