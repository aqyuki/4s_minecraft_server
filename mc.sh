#!/bin/bash
# Minecraft Bedrock Server Control Script

# Exit immediately if a command exits with a non-zero status
set -e

# Global variables
readonly SCRIPT_DIR="$(cd "$(/usr/bin/dirname "$0")" && /usr/bin/pwd)"
readonly SERVER_DIR="$SCRIPT_DIR/server"
readonly SESSION_NAME="minecraft"

# Start the Minecraft server
start_server() {
  if ! /usr/bin/tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    /usr/bin/echo "tmux session ($SESSION_NAME) not found. Creating a new session and starting the Minecraft server..."
    /usr/bin/tmux new-session -d -s "$SESSION_NAME"
    /usr/bin/tmux send-keys -t "$SESSION_NAME" "cd \"$SERVER_DIR\" && LD_LIBRARY_PATH=. ./bedrock_server" C-m
    /usr/bin/echo "Server started."
  else
    /usr/bin/echo "Server is already running."
    exit 1
  fi
}

# Stop the Minecraft server
stop_server() {
  if /usr/bin/tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    /usr/bin/echo "Stopping the Minecraft server..."
    /usr/bin/tmux send-keys -t "$SESSION_NAME" "stop" C-m
    /usr/bin/tmux kill-session -t "$SESSION_NAME"
    /usr/bin/echo "Server stopped."
  else
    /usr/bin/echo "Server is not running."
    exit 1
  fi
}

# Send message to the Minecraft server
send_message() {
  if /usr/bin/tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    /usr/bin/echo "Sending message to the Minecraft server..."
    /usr/bin/tmux send-keys -t "$SESSION_NAME" "say $1" C-m
    /usr/bin/echo "Message sent: $1"
  else
    /usr/bin/echo "Server is not running. Cannot send message."
    exit 1
  fi
}

# Attach to the Minecraft server console
attach_server() {
  if /usr/bin/tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    /usr/bin/tmux attach -t "$SESSION_NAME"
  else
    /usr/bin/echo "Server is not running."
    exit 1
  fi
}


# Display usage information
show_help() {
  /usr/bin/echo "Usage: $0 {start|stop|help|restart|msg|attach}"
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
