#!/bin/bash

# this breaks the script, because it relies on curl, which ends in error
#set -e

host="$1"
port="$2"
shift 2
cmd="$@"

# while true is not great, in case the logic breaking the script didn't work
while true; do
  # Execute the curl command and capture the output
  command="curl -sS $host:$port 2>&1"
  response=$(eval "$command")

  # Check if the output contains "Connection refused", don't start container until it does not
  if [[ $response == *"Connection refused"* ]]; then
    >&2 echo "Connection refused. Retrying..."
    sleep 5  # Adjust the sleep duration as needed
  else
    >&2 echo "Connection successful!"
    break
  fi
done

>&2 echo "MySQL is up - executing command"
exec $cmd
