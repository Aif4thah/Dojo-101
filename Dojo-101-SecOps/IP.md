# IP Linux

ip addr add 192.168.1.5/24 dev eth0
ifconfig eth0 192.168.1.5 netmask 255.255.255.0


ip link set eth0 [up|down]
ifconfig wlan0 down


route add default gw 192.168.1.254

