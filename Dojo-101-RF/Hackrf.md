# HackRF

## Caractéristiques

| chars | valeur |
|-------|----------|
| E/R | Half duplex |
| Gamme de Fréquences | 1-6000Mhz |
| Échantillonage CAN | 20 Msps 8 bits |

## Leds

When HackRF One is plugged in to a USB host, four LEDs should turn on: 3V3, 1V8, RF, and USB. 
* The 3V3 LED indicates that the primary internal power supply is working properly.
* The 1V8 and RF LEDs indicate that firmware is running and has switched on additional internal power supplies. 
* The USB LED indicates that the HackRF One is communicating with the host over USB.
* The RX and TX LEDs indicate that a receive or transmit operation is currently in progress.

## Binaires pré compilés Windows

* PothosSDR

## Drivers windows

1. Utiliser Zadig pour installer WinUSB

## Tools

* hackrf_*.exe : binaires cli
* SDRSharps / SDR# / AirSpy : analyse de spectre
* Universal Radio Hacker : analyse de spectre et capture

## update firmware

hackrf_spiflash -w hackrf_one_usb.bin

## update cpld

hackrf_cpldjtag -x sgpio_if/default.xsvf

## replay attack

Trouver la porteuse avec la documentation de la cible et/ou un analyseur de spectre puis capturer:

```sh
hackrf_transfer -s <sample-rate-mhz> -f <frequence> -r <file>
```

rejeu:

```sh
hackrf_transfer -s <sample-rate-mhz> -f <frequence> -t <file>
```

## Emission avec Pothos SDR et SoapySDR API

selectionner le hackrf:

`Device Args` : `{"driver":"hackrf"}`
