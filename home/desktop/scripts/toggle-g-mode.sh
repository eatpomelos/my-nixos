#!/usr/bin/env bash

STATE_FILE=/etc/nixos/home/desktop/scripts/.spk-gmode-state

g_mode_on()
{
    sudo bash -c "echo \"\_SB.AMWW.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}\" > /proc/acpi/call";
    sudo bash -c "echo \"\_SB.AMWW.WMAX 0 0x25 {1, 0x01, 0x00, 0x00}\" > /proc/acpi/call";

    # notify-send "turn on G-Mode";
    echo "on" > "$STATE_FILE";
}

g_mode_off()
{
    sudo bash -c "echo \"\_SB.AMWW.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}\" > /proc/acpi/call";
    sudo bash -c "echo \"\_SB.AMWW.WMAX 0 0x25 {1, 0x00, 0x00, 0x00}\" > /proc/acpi/call";
    
    # notify-send "turn off G-Mode";
    echo "off" > "$STATE_FILE";
}

# 切换gmode开关
toggle_g_mode()
{
    if [ -f "$STATE_FILE" ]; then
        state=$(cat "$STATE_FILE")

        if [ "$state" == "on" ]; then
            g_mode_off
        else
            g_mode_on
        fi
    else
        g_mode_on
    fi
}

# 设置切换gmode
toggle_g_mode
