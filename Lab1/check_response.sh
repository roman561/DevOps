#!/bin/bash
URL="https://www.google.com/"
LOG_FILE="response_log.txt"

echo "Running the script..."

wget --spider -S "$URL" 2>&1 | awk 'BEGIN { RS="\n  "; FS=": " } $1 ~ /^  HTTP\// {print $2}' | awk '{print $1}' > temp.txt
response_code=$(cat temp.txt)

echo "Response code: $response_code"
if [[ $response_code != 2* ]] && [[ $response_code != 3* ]]; then
    echo "$(date) - Response code: $response_code" >> $LOG_FILE
    echo "Warning! Response code not 2xx or 3xx!"
fi

echo "Script execution complete."

# cleanup temporary file
rm temp.txt