#!/bin/bash
# Minecraft Bedrock Server Control Script

# Exit immediately if a command exits with a non-zero status
set -e

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly SERVER_DIR="$SCRIPT_DIR/server"
readonly SESSION_NAME="minecraft"

# Start the Minecraft server
start_server() {
  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "tmux session ($SESSION_NAME) not found. Creating a new session and starting the Minecraft server..."
    tmux new-session -d -s "$SESSION_NAME"
    tmux send-keys -t "$SESSION_NAME" "cd \"$SERVER_DIR\" && LD_LIBRARY_PATH=. ./bedrock_server" C-m
    echo "Server started."
  else
    echo "Server is already running."
    exit 1
  fi
}

# Stop the Minecraft server
stop_server() {
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Stopping the Minecraft server..."
    tmux send-keys -t "$SESSION_NAME" "stop" C-m
    tmux kill-session -t "$SESSION_NAME"
    echo "Server stopped."
  else
    echo "Server is not running."
    exit 1
  fi
}

# Send message to the Minecraft server
send_message() {
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Sending message to the Minecraft server..."
    tmux send-keys -t "$SESSION_NAME" "say $1" C-m
    echo "Message sent: $1"
  else
    echo "Server is not running. Cannot send message."
    exit 1
  fi
}

# Attach to the Minecraft server console
attach_server() {
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux attach -t "$SESSION_NAME"
  else
    echo "Server is not running."
    exit 1
  fi
}


# Display usage information
show_help() {
  echo "Usage: $0 {start|stop|help}"
}

# Handle script arguments
case "$1" in
  start)
    start_server
    ;;
  stop)
    stop_server
    ;;
  restart)
    stop_server
    start_server
    ;;
  msg)
    send_message "$2"
    ;;
  attach)
    tmux attach -t "$SESSION_NAME"
    ;;
  help)
    show_help
    ;;
  *)
    show_help
    exit 1
    ;;
esac
