# Wifi basics

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


## aicrack-ng

Enabling monitor mode, **la carte wifi doit etre compatible!**

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

### capture dans un fichier :

```sh
$ airodump-ng --essid <nom AP> -c <channel> -w capture-file wlan1
$ airodump-ng --bssid <mac AP> -c <channel> -w capture-file wlan1
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

* Kismet
* WiFi Analyzer (Windows Store)
* Acrylic Wifi