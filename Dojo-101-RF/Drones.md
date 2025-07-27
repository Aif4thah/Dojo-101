# Drones

## Usages

### Sécurité Physique

| **Type**              | **Usage**                                           | **Marque/Modèle**                          |
|-----------------------|-----------------------------------------------------|--------------------------------------------|
| Reconnaissance        | Surveillance, correction de tirs en profondeur      | DJI Mavic, Autel Evo, Parrot Anafi         |
| Largueur              | Largage de grenades ou charges artisanales          | DJI Matrice, DJI Mavic modifiés            |
| Kamikaze (FPV)        | Attaque directe avec explosifs                      | Drones FPV customisés                      |
| Observation tactique  | Suivi de troupes, repérage de terrain               | DJI Phantom, Autel Robotics                |
| Logistique légère     | Transport de petits équipements ou médicaments      | DJI Matrice, Flytrex                       |
| Brouillage/Leurre     | Saturation radar, diversion                         | Drones bon marché modifiés (ex: Syma)      |


## Detection

### écoute et analyse de la communication

* Wifi Access Point (sniffing de la communication wifi avec carte en mode `monitor`)
* Signature spécifique: env. 30 émissions / secondes (plus qu'une communication Wifi classique - 10 Tx/sec), on peut considérer que `Si ( Tx > 100Hz ) alors { Drone }`
* Bande utilisée parfois beaucoup plus large (drones bas de gamme ?)
* Variation de la puissance d'émission selon la distance
* Si antenne directionnelle: changement de direction

### radar actif

* réflexion du signal par les hélices: For example, if the propeller rotates with the speed around 7500 to 10500 RPM, we expect to see the signature of the drone on the frequency band less than 200Hz

* détection des vibrations du drone: In active approach, the
system sends out a wireless signal and observes the reflected
component caused by drone body vibration (peut aussi se faire de manière passive)

### capture avec HackRF

#### spectre

exemple pour la bande des 2.4GHz

```sh
hackrf_sweep -f 2400:2500 -n 8192 -w 600000 -r capture.csv
```

#### signal

une fois le canal wifi identifié on ajuste -f avec la frequence exacte.

```sh
hackrf_transfer -s 20000000 -l 32 -g 8 -f <freq.> -r capture.cs8
```

## Drones civils

### Sigint

| Frequency | 433Mhz | 868Mhz | 2.4Ghz | 5Ghz |
|-----|--------|---------|-------|-----|
| Control | No | No | DSSS+FHSS/DSSS/OFDM | OFDM |
| Video | No | No | OFDM | OFDM, FM |
| Telemetry | Divers | OFDM OFDM,DSSS | OFDM |

voir `Wifi` pour les Modulations à 2.4 et 5 Ghz

### Control

| Brand | Frequency | Modulation | Technology |
|-----|--------|---------|-------|
| DJI Mavic 3 |  2.4Ghz/5.8Ghz | FHSS/DSSS ||
| DJI Phantom | 2.4Ghz/5.8Ghz | FHSS/DSSS | FASST/Lightbridge |
| Futaba | 2.4Ghz | FHSS/DSSS | FASST |
| Spektrum | 2.4Ghz | FHSS/DSSS | DSMX |
| JR | 2.4Ghz | FHSS/DSSS | DMSS |
| Hitec | 2.4Ghz | FHSS/DSSS | AFHSS |
| Graupner | 2.4Ghz | FHSS/DSSS | HOTT |
| Yuneec | 2.4Ghz | DSSS | ZigBee |
| Parrot AR2 | | OFDM | Wi-Fi |

### Video

| Brand | Frequency | Modulation | Technology |
|-----|--------|---------|-------|
| DJI Mavic | 2.4Ghz/5.8Ghz | OFDM ||
| DJI Phantom | 2.4Ghz | OFDM | Lightbridge/Wi-Fi |
| Immersion | 2.4Ghz | FM ||
| Yuneec | 5.8Ghz | OFDM | Wi-Fi |
| Connex | 5.8Ghz | OFDM ||
| Immersion | 5.8Ghz | FM ||
| Boscam | 5.8Ghz | FM ||

### Protocols

* Navlink
* FrSky
* CrossFire


### Quelques specs

#### DJI Mini 3 Pro

| Specification | Value |
| --- | --- |
| Maximum Flight Speed | 16 m/s (S mode), 10 m/s (N mode), 6 m/s (C mode)  |
| Maximum Flight Altitude | 4000 meters  |
| Maximum Flight Time | 34 minutes (standard battery)  |
| Maximum Flight Distance | 18 km  |
| Wind Resistance | 29 to 38 km/h (5 Bft)  |
| Operating Frequency | 2.400-2.4835 GHz, 5.725-5.850 GHz  |

#### DJI Mavic 3

| Specification | Value |
| --- | --- |
| Maximum Flight Speed | 21 m/s (S mode)  |
| Maximum Flight Altitude | 6000 meters  |
| Maximum Flight Time | 46 minutes (no wind)  |
| Maximum Flight Distance | 30 km  |
| Wind Resistance | 12 m/s  |
| Operating Frequency | GPS + Galileo + BeiDou  |

#### Autel EVO Lite+

| Specification | Value |
| --- | --- |
| Camera Sensor | 1-inch CMOS  |
| Effective Pixels | 20 MP  |
| Video Resolution | 6K/30fps and 4K/60fps  |
| Flight Time | 40 minutes  |


#### Ryze Tech Tello

| Specification | Value |
| --- | --- |
| Weight | Approximately 80 g (with propellers and battery) ¹ |
| Dimensions | 98mm x 92.5mm x 41mm ¹ |
| Propeller | 3 inches  |
| Built-in Functions | Range Finder, Barometer, LED, Vision System, 2.4 GHz 802.11n Wi-Fi, 720p Live View  |
| Max Flight Distance | 100m  |
| Max Speed | 8m/s  |
| Max Flight Time | 13min  |
| Max Flight Height | 30m  |

## Ressources:

[sources pour les modulations](https://digitalcommons.odu.edu/cgi/viewcontent.cgi?article=1161&context=ece_etds)
[sigint](https://www.sigidwiki.com/wiki/Quadcopter_Telemetry_Signal)
[colorado.edu](https://home.cs.colorado.edu/~rhan/Papers/p17-nguyen.pdf)

