#!/bin/bash
[[ -n $2 ]] && echo 'Пробелы запрещены!' && exit 1
[[ -f ~/switch-lan-play/src/build/lanplay ]] && sudo ~/switch-lan-play/src/build/lanplay --relay-server-addr $1 && exit
apt update
apt upgrade -y
apt install libpcap -y
apt install libuv -y
pkg install cmake -y
pkg install tsu -y
pkg install git -y
git clone https://github.com/spacemeowx2/switch-lan-play.git
cd switch-lan-play
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
