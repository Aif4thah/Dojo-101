# RFID

> [!IMPORTANT]
> La copie de Badge RFID est strictement règlementée et peut être sanctionnée au civil comme au pénal.

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
| MIFARE PLus EV1 | EAL5+ |

## Tools

* Linux: `Proxmark3`
* Android: `NFC Tools` et `Mifare Classic Tools`
* Flipper Zero
* lecteur / writer : `ACR122U`

## Vulns connues

### MIFARE Classic

* [fichier de clé en ligne](https://github.com/ikarus23/MifareClassicTool/blob/master/Mifare%20Classic%20Tool/app/src/main/assets/key-files/extended-std.keys)

* *weak key* ou *default key* qui permet de cloner et usurper facilement les badges

* *brute force* des clés et export possible vers `proxmark` depuis Android avec `Mifaire Classic Tools`

* *Nested* via un lecteur RFID malveillant pour exploitation de faiblesses cryptographiques

* Darkside / Coirtois

* MITM


Fonctionnement du Mifare Classic : 

> [!NOTE]
> Le bloc 0 est réservé à l'UID du badge, sur les cartes classique il n'est pas accéssible en écriture. En revanche sur les *magic badges* c'est possible.

| Secteur | Bloc 0  | Bloc 1  | Bloc 2  | Bloc 3 (bloc clé) |
|---------|---------|---------|---------|-------------------|
| 0  | Données (UID) | Données  | Données    | Clé A, Clé B, ACL|
| 1  | Données | Données | Données | Clé A, Clé B, ACL|
| 2  | Données | Données | Données | Clé A, Clé B, ACL|
| 3  | Données | Données | Données | Clé A, Clé B, ACL|
| 4  | Données | Données | Données | Clé A, Clé B, ACL|
| 5  | Données | Données | Données | Clé A, Clé B, ACL|
| 6  | Données | Données | Données | Clé A, Clé B, ACL|
| 7  | Données | Données | Données | Clé A, Clé B, ACL|
| 8  | Données | Données | Données | Clé A, Clé B, ACL|
| 9  | Données | Données | Données | Clé A, Clé B, ACL|
| 10 | Données | Données | Données | Clé A, Clé B, ACL|
| 11 | Données | Données | Données | Clé A, Clé B, ACL|
| 12 | Données | Données | Données | Clé A, Clé B, ACL|
| 13 | Données | Données | Données | Clé A, Clé B, ACL|
| 14 | Données | Données | Données | Clé A, Clé B, ACL|
| 15 | Données | Données | Données | Clé A, Clé B, ACL|

Chaque secteur comporte 4 blocs. les Blocs 0 à 2 contiennent des données utilisateur, le Bloc 3 contient les clés A et B ainsi que les conditions d'accès (ACL - Access Control List) pour le secteur.

Les clés A et B définissent les droits d'accès aux blocs du secteur (lecture, écriture, etc.), tandis que les ACL déterminent les permissions spécifiques :

* Clé A : Utilisée généralement pour des opérations spécifiques, comme la lecture ou l'accès basique.

* Clé B : Habituellement utilisée pour des accès plus privilégiés, comme l'écriture ou la modification des ACL elles-mêmes.

* ACL (Conditions d'accès) : Ces bits définissent précisément quels droits (lecture, écriture, gestion) sont attribués en fonction de la clé utilisée.

### exemple linux et ACR122U

Installation

```sh
apt install mfoc
apt install pcscd pcsc-tools
add-apt-repository universe
apt install libnfc-dev libnfc-bin libnfc-examples
```

Dump avec clé standard

```sh
mfoc -P 500 -O original.dmp
```

Brute force des clés et Dump (ou spécification des clés dans un fichier en option)

```sh
wget https://raw.githubusercontent.com/ikarus23/MifareClassicTool/refs/heads/master/Mifare%20Classic%20Tool/app/src/main/assets/key-files/extended-std.keys
mfoc -f extended-std.keys -O original.dmp
```

Clone avec bloc O / UID

```sh
nfc-mfclassic W a u original.dmp
```


### Mifare Classic NG et MIFARE Plus Standard Level 1

* Vulnérable à l'attaque *HardNested*


### Protection

* Il existe de nombreux porte-feuilles et porte-cartes `anti-RFID` sur le marché. Ils préviennent les lectures/copies non-souhaitées.