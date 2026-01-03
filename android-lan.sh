#!/data/data/com.termux/files/usr/bin/bash

case $@ in
	stable) version=1
		;;
	latest) version=2
		;;
        remove) rm -rf ~/switch-lan-play
                rm -f  ~/switchlan
                exit 0
                ;;
	help|-h|--help)echo "usage: 
		build/update lan-play:       ./switchlan stable OR ./switchlan latest
		connect to servers:          ./switchlan <server's ip>:<port>
                delete lan-play:             ./switchlan remove"
		exit 0
		;;
esac

if [[ -f ~/switch-lan-play/build/src/lan-play ]] && [[ -z $version ]]; then
    [[ -z $1 ]] && echo -n 'Server / Сервер:' && read server || server="$1"
    [[ -z $server ]] && echo 'Server cant be blank! / Адрес Сервера не может быть пустым!' && exit 1
    echo -n 'pmtu (leave blank for default / можно оставить пустым): ' && read pmtu_value
    [[ $pmtu_value ]] && pmtu_argument="--pmtu $pmtu_value"

    sudo ~/switch-lan-play/build/src/lan-play $pmtu_argument --relay-server-addr $server
    exit 0
fi

[[ -z $version ]] && clear && echo -e "1 - stable / стабильная\n2 - latest / свежая\n" && read -n1 -p"Enter number / Введите цифру:" version && clear
[[ $version != '1' ]] && [[ $version != '2' ]] && echo "Error: wrong version / неправильная версия" && exit 1


apt update
apt upgrade -y
apt install build-essential cmake binutils tsu git libpcap libuv -y

case $version in
	1)stable_tag=$(curl -s https://api.github.com/repos/spacemeowx2/switch-lan-play/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
	  git clone --depth 1 --branch $stable_tag https://github.com/spacemeowx2/switch-lan-play.git
        ;;
	2)if [[ -d ~/switch-lan-play ]]; then
              cd ~/switch-lan-play
              git pull https://github.com/spacemeowx2/switch-lan-play.git
              cd ..
          else
              git clone https://github.com/spacemeowx2/switch-lan-play.git
          fi
	;;
	*)echo "Error: wrong version"
	  exit 1
	;;
esac

cd switch-lan-play || (echo 'Error cloning repo!' && exit 1)
rm -rf ./build; mkdir ./build; cd ./build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_POLICY_VERSION_MINIMUM=3.5 .. || (echo "Error configuring lan-play" && exit 1)
make || (echo "Error building lan-play" && exit 1)
clear
echo -e "\nDone!/Готово!\nNow you can launch app with './switchlan'\nТеперь можно запустить программу: './switchlan'"
