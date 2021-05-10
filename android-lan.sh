#!/data/data/com.termux/files/usr/bin/bash
[[ -n $2 ]] && echo 'No spaces! / Без Пробелов!' && exit 1
if [[ -f ~/switch-lan-play/build/src/lan-play ]]; then
    [[ -z $1 ]] && echo -n 'Server / Сервер:' && read server || server="$1"
    [[ -z $server ]] && echo 'Server cant be blank! / Адрес Сервера не может быть пустым!' && exit 1
    sudo ~/switch-lan-play/build/src/lan-play --relay-server-addr $server
    exit
fi
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
