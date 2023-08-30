#!/bin/bash

# Read LINE Notify token from .env file
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

# Check if LINE_TOKEN is set
if [ -z "$LINE_TOKEN" ]; then
  echo "Error: LINE_TOKEN is not set. Make sure it's defined in the .env file."
  exit 1
fi

# Check if a message parameter is provided
if [ -z "$1" ]; then
  echo "Error: Please provide a message parameter."
  exit 1
fi

# Set the message and image parameters
MESSAGE="$1"
IMAGE_PATH="$2"

# Prepare cURL command
CURL_CMD="curl -X POST \
  https://notify-api.line.me/api/notify \
  -H 'Authorization: Bearer $LINE_TOKEN' \
  -F 'message=$MESSAGE'"

# Add image parameter if provided
if [ -n "$IMAGE_PATH" ]; then
  CURL_CMD="$CURL_CMD -F 'imageFile=@$IMAGE_PATH'"
fi

# Execute cURL command
echo $(eval "$CURL_CMD")
