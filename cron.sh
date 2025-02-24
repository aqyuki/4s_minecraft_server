#!/bin/bash
# This script is used to run the cron job

# Exit immediately if a command exits with a non-zero status
set -e

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Global utility functions
function printl() {
  echo "[$(date)] $1"
}

# Send webhook
function send_webhook_notice() {
  curl -X POST "$WEBHOO_URL" \
    -H 'Content-Type: application/json' \
    -d "$(jq --arg title "Notice" \
             --arg description "$(date -d '5 minutes' +'%Y-%m-%d %H:%M:%S')より､サーバーの再起動とバックアップを行います｡" \
             '.embeds[0].title = $title | .embeds[0].description = $description' \
             "$SCRIPT_DIR"/asset/message.json)"
}

function send_webhook_stop() {
  curl -X POST "$WEBHOO_URL" \
    -H 'Content-Type: application/json' \
    -d "$(jq --arg title "Server stop" \
             --arg description "サーバーが停止しました｡" \
             '.embeds[0].title = $title | .embeds[0].description = $description' \
             "$SCRIPT_DIR"/asset/message.json)"
}

function send_webhook_start() {
  curl -X POST "$WEBHOO_URL" \
    -H 'Content-Type: application/json' \
    -d "$(jq --arg title "Server start" \
             --arg description "サーバーが再起動しました｡" \
             '.embeds[0].title = $title | .embeds[0].description = $description' \
             "$SCRIPT_DIR"/asset/message.json)"
}

function send_backup_result() {
  curl -X POST "$WEBHOO_URL" \
    -H 'Content-Type: application/json' \
    -d "$(jq --arg title "Backup complete" \
             --arg description "バックアップが完了しました｡" \
             '.embeds[0].title = $title | .embeds[0].description = $description' \
             "$SCRIPT_DIR"/asset/message.json)"
}

# Main script execution
$SCRIPT_DIR/mc.sh msg "§9[Server]§r $(date -d "5 minutes" +"%Y-%m-%d %H:%M")より､サーバーの再起動とバックアップを開始します｡"
send_webhook_notice
sleep 5m

printl "Stopping server"
if $SCRIPT_DIR/mc.sh stop > /dev/null; then
  printl "Server stopped successfully"
  send_webhook_stop
else
  printl "Failed to stop server. Exiting backup script." >&2
  exit 1
fi

printl "Starting backup process"
if $SCRIPT_DIR/backup.sh; then
  printl "Backup completed successfully."
  send_backup_result
else
  printl "Backup failed. Exiting." >&2
  exit 1
fi

printl "Backup completed successfully. Restarting server"
if $SCRIPT_DIR/mc.sh start; then
  printl "Server restarted successfully"
  send_webhook_start
else
  printl "Failed to restart server. Check server logs." >&2
  exit 1
fi
