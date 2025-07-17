#!/bin/sh

DEFAULT_DURATION="1h"
DEFAULT_BACKGROUND_PATH="$HOME/Pictures/backgrounds"

DURATION="$DEFAULT_DURATION"
BACKGROUND_PATH="$DEFAULT_BACKGROUND_PATH"

usage() {
  echo "Usage: $0 [-d <duration>] [-p <path>]"
  echo "  -d <duration>  Duration between background changes (e.g., 1h, 30m, 5s). Default: $DEFAULT_DURATION"
  echo "  -p <path>      Path to the directory containing background images. Default: $DEFAULT_BACKGROUND_PATH"
  exit 1
}

while getopts "d:p:h" opt; do
  case "$opt" in
    d)
      DURATION="$OPTARG"
      ;;
    p)
      BACKGROUND_PATH="$OPTARG"
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

SWAYBG_PID=""

cleanup() {
  if [ -n "$SWAYBG_PID" ]; then
    kill "$SWAYBG_PID" 2>/dev/null
  fi
  exit 0
}

trap cleanup INT TERM

while true; do
  if [ -n "$SWAYBG_PID" ]; then
    kill "$SWAYBG_PID" 2>/dev/null
  fi
  swaybg -i "$(find "$BACKGROUND_PATH" -type f | shuf | head -1)" &
  SWAYBG_PID=$!
  sleep "$DURATION"
done
