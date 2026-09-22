#!/bin/bash

SELECTION="$(printf "Suspend\nReboot\nReboot to UEFI\nHard reboot\nShutdown" | bemenu -n -l 30 --fn 'JetBrainsMono Nerd Font 10' --scrollbar always --counter alway -p "Power Menu: ")"

case $SELECTION in
    *"Suspend")
        systemctl suspend;;
    *"Reboot")
        systemctl reboot;;
    *"Reboot to UEFI")
        systemctl reboot --firmware-setup;;
    *"Hard reboot")
        pkexec "echo b > /proc/sysrq-trigger";;
    *"Shutdown")
        systemctl poweroff;;
esac
