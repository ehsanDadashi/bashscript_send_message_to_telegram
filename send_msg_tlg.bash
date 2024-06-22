#!/bin/bash

#current date variable to log data
current_date=$(date '+%Y-%m-%d %H:%M:%S')
echo "$current_date ********************************* start send message ***********************************" >> /home/bash/sndmsg.log

# Define the function for URL encoding
# it is not nessary to encode message but if you want to send special charectar it is recommended to encode date first and then send it to telegram
urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote('''$1'''))"
}

# your bot token and bot id from @botfather
BOT_TOKEN="your bot token from telegram @botfather"
CHAT_ID="your chatid from telegram @botfather"

# input some message to send to telegram
echo 'please type your message:'
read -r MESSAGE

# URL encode the message for safe transmission in URL
ENCODED_MESSAGE=$(urlencode "$MESSAGE")

# Send the message using curl
log=$(curl -sS -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$ENCODED_MESSAGE")

#log out put of above command
echo "$current_date result: $log " >> /home/bash/sndmsg.log
