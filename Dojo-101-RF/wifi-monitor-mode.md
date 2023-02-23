## wifi

2.1 Enabling monitor mode
Before capturing any traffic, it is necessary to enable the monitoring mode on the 802.11 interface wlan0.
This is typically done using iwconfig
$ iface = wlan0
$ sudo ifconfig $iface down
$ sudo iwconfig $iface mode monitor
$ sudo ifconfig $iface up
Where wlan0 is the name of your wireless interface supporting the monitor mode. From this point,
the interface wlan0 is in monitor mode and ready to capture and inject traffic.
If you are encountering errors or a strange behavior with your monitoring interface, you can try
"unblocking" the interface with the following commands:
$ nmcli nm wifi off
$ sudo rfkill unblock all

ou

airodump-ng start wlan0
airodump-ng wlan0mon

