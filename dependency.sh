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

echo "=============================================================================="
echo "Update More Package & Install Dependecy"
echo "=============================================================================="

sudo apt-get update
sudo apt-get install -y build-essential clang bc bison libssl-dev libfl-dev libncurses5-dev libzstd-dev libtinfo5 gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib
sudo apt-get install -y curl git ftp lftp wget libarchive-tools ccache python2 python2-dev python3 libc6-dev lib32ncurses-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils
sudo apt-get install -y zip unzip tar gzip bzip2 rar unrar cpio xsltproc bc lib32readline-dev lib32z1-dev liblz4-tool libncurses-dev libsdl1.2-dev build-essential libgtk-3-dev libglu1-mesa-dev freeglut3-dev libxml2 lzop pngcrush schedtool squashfs-tools
sudo apt-get install -y tmate imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libncurses6 python3 tar
sudo apt-get purge needrestart 
sudo apt install openssh-server 
sudo systemctl enable --now ssh
          
