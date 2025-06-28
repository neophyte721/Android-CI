#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
