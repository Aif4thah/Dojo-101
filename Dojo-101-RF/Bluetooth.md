# Bluetooth

## Specs

| Bluetooth Classic | Bluetooth Low Energy (LE) |
| --- | --- |
| Bande de fréquence: 2.4GHz ISM (2.402 – 2.480 GHz utilisé) | Bande de fréquence: 2.4GHz ISM (2.402 – 2.480 GHz utilisé) |
| Canaux: 79 canaux avec un espacement de 1 MHz | Canaux: 40 canaux avec un espacement de 2 MHz (3 canaux publicitaires/37 canaux de données) |
| Utilisation des canaux: Spectre étalé à sauts de fréquence (FHSS) | Utilisation des canaux: Spectre étalé à sauts de fréquence (FHSS) |
| Modulation: GFSK, π/4 DQPSK, 8DPSK | Modulation: GFSK |
| Débit de données: EDR PHY (8DPSK): 3 Mb/s, EDR PHY (π/4 DQPSK): 2 Mb/s, BR PHY (GFSK): 1 Mb/s | Débit de données: LE 2M PHY: 2 Mb/s, LE 1M PHY: 1 Mb/s, LE Coded PHY (S=2): 500 Kb/s, LE Coded PHY (S=8): 125 Kb/s |
| Puissance Tx*: ≤ 100 mW (+20 dBm) | Puissance Tx*: ≤ 100 mW (+20 dBm) |


[sources](https://www.bluetooth.com/learn-about-bluetooth/tech-overview/)

## canaux

### BLE (Low Energy)

| id | Freq (MHz) |
|----|------------|
| 37 | 2402 |
| 38 | 2426 |
| 39 | 2480 |

## analyse avec Wireshark

### prerequis Windows

* USBpcap pour Windows

## Tools Microsoft

* [MS BTP](https://learn.microsoft.com/en-us/windows-hardware/drivers/bluetooth/testing-btp-setup-package)

```powershell
./btvs.exe -Mode Wireshark
```