#!/data/data/com.termux/files/usr/bin/bash

if [[ -f ~/switch-lan-play/build/src/lan-play ]]; then
    [[ -z $1 ]] && echo -n 'Server / Сервер:' && read server || server="$1"
    [[ -z $server ]] && echo 'Server cant be blank! / Адрес Сервера не может быть пустым!' && exit 1
    sudo ~/switch-lan-play/build/src/lan-play --relay-server-addr $server
    exit 0
fi

case $@ in
	stable) version=1
		;;
	latest) version=2
		;;
	help|-h|--help)echo "usage: 
		1. build: switchlan [stable|latest]
		2. connect: switchlan [server:port]"
		exit 0
		;;
esac

[[ -z $version ]] && clear && echo -e "1 - stable / стабильная\n2 - latest / свежая\n" && read -n1 -p"Enter number / Введите цифру:" version && clear

apt update
apt upgrade -y
apt install libpcap -y
apt install libuv -y
pkg install cmake -y
pkg install tsu -y
pkg install git -y

case $version in
	1)stable_tag=$(curl -s https://api.github.com/repos/spacemeowx2/switch-lan-play/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
	  git clone --depth 1 --branch $stable_tag https://github.com/spacemeowx2/switch-lan-play.git
		;;
	2)git clone https://github.com/spacemeowx2/switch-lan-play.git
		;;
	*)echo "Error: wrong version"
	  exit 1
		;;
esac

cd switch-lan-play
mkdir build; cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
