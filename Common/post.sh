#!/usr/bin/env bash

# Copyright 2024

tgp() {
    curl -sX POST https://api.telegram.org/bot"$TOKEN"/sendPhoto -d photo=$PHOTO -d chat_id="$CHAT_CH" -d parse_mode=Markdown -d disable_web_page_preview=true -d text="$1" &>/dev/null -d caption="$ROMNAME | $ANDROID | $TYPE | $DEVICENAME
Build Date: $DATE
Author: $MAINTAINER

🔹[Download/Changelog/Screenshots]($DOWNLOAD)
🔹[Support Group]($SUPPORT)

Notes:
• Clean flash 
• $GAPPS build.
• SELinux Enforcing
• Report bugs with logs else you will be ignored.
• There's nothing special about my build, you can skip if you don't like, or you can taste it.

Credits:
@neophytexyz for help

buy me a coffee [here]()"
}

# Send Build Info
sendinfo() {
    tgp 
}

sendinfo
