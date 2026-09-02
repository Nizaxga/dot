#!/bin/bash

# for arch linux code-server
# Request sudo upfront and keep it alive during execution
sudo -v
while true; do
  sudo -n true
  sleep 60
done 2>/dev/null &
SUDO_REFRESH_PID=$!

trap 'kill $SUDO_REFRESH_PID' EXIT

SERVICE_NAME="code-server@$USER"

function check_status {
  systemctl is-active --quiet "$SERVICE_NAME"
}

function enable_plugin {
  sudo systemctl start "$SERVICE_NAME"
}

function disable_plugin {
  sudo systemctl stop "$SERVICE_NAME"
}

# Interactive menu
echo "code-server service"
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
    disable_plugin && echo "code-server has been stopped."
  else
    echo "code-server is not currently running."
  fi
  ;;
2)
  if ! check_status; then
    enable_plugin && echo "code-server has been started."
  else
    echo "code-server is already running."
  fi
  ;;
3)
  if check_status; then
    echo "code-server is running."
  else
    echo "code-server is not running."
  fi
  ;;
4)
  echo "Goodbye."
  exit 0
  ;;
*)
  echo "❌ Invalid option."
  exit 1
  ;;
esac
