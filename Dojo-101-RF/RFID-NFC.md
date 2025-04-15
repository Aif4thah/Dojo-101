# RFID

## Tags Classes

| Classe | Description|
|--------|-----------------------------------------------------------------------------|
| Class 0 | A read-only passive tag with non-programmable memory.   |
| Class 1 | A write-once, read-many passive tag.|
| Class 2 | A read-write passive tag with up to 65 KB of read-write memory.   |
| Class 3 | A semi-passive tag with up to 65 KB read-write memory; a Class 2 tag with a built-in battery to support increased read range. |
| Class 4 | An active tag that uses a built-in battery to run the microchip's circuitry and to power a transmitter that broadcasts a signal to a reader. |
| Class 5 | An active RFID tag that can communicate with other Class 5 tags and/or other hardware. |

## Passive RF

| **Fréquence**    | **Technologies/Normes** |
|-----------------------|---------------------------------------------|
| **Low Frequency (120–140 KHz)** | ISO 11784/5    |
|   | ISO 18000-2|
| **High Frequency (13 MHz)**| NFC  |
|   | ISO 15693  |
|   | ISO 14443 (NXP, Mifare-plus)   |
|   | ISO 1800-3 |
| **Active RF (2.4 GHz)** | Bluetooth/BLE  |
|   | Zigbee|
|   | Wi-Fi |


## Usage et Protocoles

| Application| Protocole fréquent |
|-------|-------|
| Paiements mobiles (Apple Pay, Google Pay) | Chiffrement AES, Tokenisation  |
| Partage de données (Android Beam) | Chiffrement AES |
| Appairage Bluetooth  | SSP (Simple Secure Pairing)  |
| Billetterie électronique  | 3DES, 3KDES, AES, MIFARE Classic/DESFire |
| Contrôle d'accès (cartes d'accès) | 3DES, 3KDES, AES, MIFARE Classic/DESFire |
| Cartes de fidélité   | 3DES, 3KDES, MIFARE Classic/DESFire |
| Cartes de visite électroniques | Aucun |
| Authentification sécurisée| 3DES, 3KDES, AES, PKI |

### Protocole qualifié CC

| Protocole | Certification |
|-----|----|
| MIFARE DESFire EV1 | EAL4+ |
| MIFARE DESFire EV2/EV3 | EAL5+ |

## Tools

* Linux: `Proxmark3`
* Android: `NFC Tools`
* Flipper Zero

## Vulns connues

### MIFARE Classic

* *weak key* qui permet de cloner / usurper facilement les badges
* brute force et export possible vers `proxmark` depuis Android avec `Mifaire Classic Tools`



