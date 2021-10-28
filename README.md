## How to setup Switch LAN-Play on Android phone/tablet

REQUIRES ROOT and Android 7.0+

#### Actions in Android:
1. Install a latest Termux from f-droid - "https://f-droid.org/en/packages/com.termux/"
2. Launch Termux app, you'll see a black terminal window.
3. Next, enter these 3 commands one by one:
```
curl -L tinyurl.com/switchlan > switchlan
chmod +x switchlan
bash switchlan
```
4. It'll setup additional packages and compile lanplay from source (1-5 minutes)
5. Start WiFi tethering (or connect your phone to wifi)

#### Actions in HOS (Switch):
1. Connect to WiFi and configure network settings:
```
IP-address Settings Manual
IP-address 10.13.X.Y (where X and Y is two random numbers 0-255, example: 10.013.187.66 DO NOT COPY EXAMPLE)
Subnet Mask 255.255.0.0
Gate 10.13.37.1
DNS Settings Manual
Primary DNS 163.172.141.219
Secondary DNS 207.246.121.77
```
2. download ldn-mitm "https://github.com/spacemeowx2/ldn_mitm/releases/latest"
3. extract it in root of your SDcard (don't forget to clear the archive bit in Hekate if necessary)
4. reboot switch

### Connect to Servers: 
* Launch Termux and enter `bash switchlan`, script will ask you for server ip and root privileges
* or enter `bash switchlan server's address` to skip asking part, example: `bash switchlan edgymin.ga:11451`
* If connection was successful you'll see "Server IP: x.x.x.x" at the end

### To Disconnect:
* Long tap anywhere in Termux -> more -> kill process; or press "exit" in Termux's notification

### How to delete/reinstall lanplay:
enter `rm -rf ~/switch-lan-play; rm ~/switchlan` in Termux
