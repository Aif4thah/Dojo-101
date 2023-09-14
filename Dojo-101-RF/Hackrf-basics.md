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

## Binaires pré-compilés Windows

* Radioconda (exe et dll)
* PothosSDR (exe et dll)
* SDRSharp (dll)

## Drivers windows

* Utiliser Zadig pour installer WinUSB

## Command Line

* hackrf_*.exe : binaires cli pour hackrf

## fichiers de capture

* extension : .cs8 - (.complex16s) 
* type : Complex 8-bit signed integer samples (Complex = pairs of I/Q values)
* convert from CU8 : +127

Pour stocker le signal on utilse des nombres complexes sous forme I+jQ, exemple: [0.123 + j0.512, 0.0312 + j0.4123, 0.1423 + j0.06512, …]

## update firmware

```sh
hackrf_spiflash -w hackrf_one_usb.bin
```

## update cpld

```sh
hackrf_cpldjtag -x firmware/cpld/sgpio_if/default.xsvf
```

## analyse de spectre

```powershell
hackrf_sweep.exe -f <freq_min>:<freq_max> -N <nombre de passes>
```

exemple pour 2,440Ghz:

```powershell
hackrf_sweep.exe -f 2439:2440 -N 15
```

## replay attack

Trouver la porteuse avec la documentation de la cible et/ou un analyseur de spectre puis capturer:

```sh
hackrf_transfer [-s <sample-rate>] -f <frequence> -r <file>
```

exemple avec ampli LNA (l) et vga (g)
```sh
hackrf_transfer -s 20000000 -l 32 -g 8 -f 2446000000 -r test.cs8
```

rejeu:

```sh
hackrf_transfer [-s <sample-rate>] -f <frequence> -t <file>
```

exemple avec ampli en sortie (a) et ampli vga (x):

```sh
hackrf_transfer -R -a 1 -x 32 -s 20000000 -f 2441000000 -t test.cs8
```

## Emission avec SoapySDR API from Pothos SDR

sélectionner le hackrf dans les propriétés de SoapySDR:

Device Args : 
```json
{"driver":"hackrf"}
```

## Librairies python

[pyhackRF](https://github.com/dressel/pyhackrf/tree/master#quick-example)


