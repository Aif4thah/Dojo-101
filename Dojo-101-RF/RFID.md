# RFID

## Passive RF

### Low frequency - 120–140 KHz

* ISO 11784/5
* ISO 18000-2

### High frequency - 13 MHz

* NFC
* ISO 15693
* ISO 14443 (NXP, Mifare-plus)
* ISO 1800-3

## Active RF

### 2.4 GHz

* Bluetooth/BLE
* Zigbee
* Wi-Fi

## Tags Classes

* Class 0–a read-only passive tag with non-programmable memory.
* Class 1–a write-once, read-many passive tag.
* Class 2–a read-write passive tag with up to 65 KB of read-write memory.
* Class 3–a semi-passive tag with up to 65 KB read-write memory; a Class 2 tag with a built-in battery to support increased read range.
* Class 4–an active tag that uses a built-in battery to run the microchip's circuitry and to power a transmitter that broadcasts a signal to a reader.
* Class 5–an active RFID tag that can communicate with other Class 5 tags and/or other hardware.

## Tools

* Linux: `Proxmark3`
* Android: application permettant de lire ou écrire les RFID comme `NFC Tools`

## Vulns connues

### MIFARE Classic

weak key qui permet de cloner / usurper facilement les badges
brute force et export possible vers `proxmark` depuis Android avec `Mifaire Classic Tools`


