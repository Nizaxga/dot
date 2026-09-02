#!/usr/bin/env bash

# Request sudo upfront and keep it alive during execution
sudo -v
while true; do
    sudo -n true
    sleep 60
done 2>/dev/null &
SUDO_REFRESH_PID=$!

trap 'kill $SUDO_REFRESH_PID' EXIT

PLUGIN_BASE='/opt/cisco/secureclient/bin/plugins'

# Function definitions
function check_status {
    [[ -f $PLUGIN_BASE/libacumbrellaapi.dylib ]] && [[ -f $PLUGIN_BASE/libacumbrellactrl.dylib ]]
}

function verify_plugin_disabled {
    [[ -f $PLUGIN_BASE/disabled/libacumbrellaapi.dylib ]] && [[ -f $PLUGIN_BASE/disabled/libacumbrellactrl.dylib ]]
}

function disable_plugin {
    sudo mkdir -p "$PLUGIN_BASE/disabled"
    sudo mv -f "$PLUGIN_BASE/libacumbrellaapi.dylib" "$PLUGIN_BASE/libacumbrellactrl.dylib" "$PLUGIN_BASE/disabled"
}

function enable_plugin {
    sudo mv -f "$PLUGIN_BASE/disabled/libacumbrellaapi.dylib" "$PLUGIN_BASE/disabled/libacumbrellactrl.dylib" "$PLUGIN_BASE/"
}

# Interactive menu
echo "Cisco Umbrella Roaming Security Module"
echo "--------------------------------------"
echo "1) Disable"
echo "2) Enable"
echo "3) Check Status"
echo "4) Exit"
echo ""

read -rp "Choose an option (1-4): " choice

case "$choice" in
1)
    if check_status; then
        disable_plugin && echo "✅ Umbrella Roaming Security has been DISABLED."
    else
        echo "⚠️ Umbrella appears to already be disabled or not running."
    fi
    ;;
2)
    if verify_plugin_disabled; then
        enable_plugin && echo "✅ Umbrella Roaming Security has been ENABLED."
    else
        echo "⚠️ Could not find disabled files. Make sure it was disabled using this script."
    fi
    ;;
3)
    if check_status; then
        echo "📶 Umbrella Roaming Security Module is currently: ENABLED"
    elif verify_plugin_disabled; then
        echo "⛔ Umbrella Roaming Security Module is currently: DISABLED"
    else
        echo "❓ Unable to determine status."
    fi
    ;;
4)
    echo "Goodbye 😺"
    exit 0
    ;;
*)
    echo "❌ Invalid option."
    exit 1
    ;;
esac
