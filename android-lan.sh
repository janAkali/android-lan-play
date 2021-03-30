#!/bin/bash
apt update
apt install libpcap-dev -y
apt install libuv-dev -y
pkg install cmake -y
pkg install tsu -y
pkg install git -y
git clone https://github.com/spacemeowx2/switch-lan-play.git
cd switch-lan-play
mkdir build
cd build
cmake ..
make
cd
git clone https://gitlab.com/st42/termux-sudo.git
pkg install ncurses-utils -y
cd termux-sudo
cat sudo > /data/data/com.termux/files/usr/bin/sudo
chmod 700 /data/data/com.termux/files/usr/bin/sudo
cd
wget http://switch.retrogamer.tech/switch
wget http://switch.retrogamer.tech/ps4
chmod 755 switch
chmod 755 ps4
