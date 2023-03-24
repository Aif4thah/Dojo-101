# RF basics

## definitions

| terme | definition |
|-------|---------|
| λ | longueur d'onde |
| v ou f | frequence |
| T | temps |
| E | Emission |
| R | Reception
| if_freq | fréquence intermediaire avant E ou Apres R |
| lo_freq | frequance de l'oscilateur local |
| LO + FI | Frequence E/R |
| LNA | Low noise ampli. (ampli en entrée de reception) |
| VGA | Variable Gain Amplifiers |
| Base band | signal utile |

## SDR software define radio

`Antenna` <-> `Ampli + filter` <-> `Analog/Digit` <-> `Modem error correction` <-> `Encryption` <-> `Network routing GUI` <-> `User`

## Modulations

* Amplitude AM, et en quadrature QAM, ex: TNT

* Binaire (On-Off Key), ex: télécommandes

* Fréquence FM

* Déplacement de frequence FSK, ex: RFID 

* Changement de phase PSK et en quadrature QPSK -> BPSK est la forme la plus simple du PSK. Elle utilise deux phases qui sont séparées de 180° ; on l'appelle également 2-PSK. Cette modulation est la plus robuste de toutes les PSK car il faut une grande déformation du signal pour que le démodulateur se trompe sur le symbole reçu.

* Gaussian minimum-shift keying ex: GSM

* Orthogonal Frequency-division multiplexing (OFDM), ex: UMTS,LTE, CPL, Wifi

* Pas de modulation mais plus robuste: Morse

## Encodage

NRZ, NRZI, Manchester, Miller, bipolaires

## Antennes

* Verticales omnidirectionnelles à λ/2 ou λ/4
* Directionnelles avec directeurs, radiateur et réflecteur ex: Yagi
* Parabolique (ex: reception sattelite)
* Loop et cadre magnétique (ex: RFID)

## Tools

[PothosSDR](https://www.pothosware.com/)
[SoapySDR](https://github.com/pothosware/SoapySDR/wiki)

### Test avec PothosFlow

1. lancer `PothosFlow`
2. Choisir une source, ex: `audio / audios source`
3. Choisir un plotter, ex: `plotters / wave monitor`
4. relier la source -> plotter
5. Activer la topologie (roue dentée dans la barre de taches)

## format de fichiers

* IQ = écriture en nombre complexe (I+jQ)

* .cu4: Complex (I/Q), Unsigned integer, 4-bit per value (8 bit per sample)

* .cs4: Signed integer

* .cu8 (.data .complex16u): 8-bit per value (16 bit per sample) - Complex 8-bit unsigned integer samples  (RTL-SDR)

* .cs8 (.complex16s)

* .cu12: 12-bit per value (24 bit per sample)

* .cs12

* .cu16: 16-bit per value (32 bit per sample)

* .cs16: Complex 16-bit signed integer samples (BladeRF)

* .cu32: 32-bit per value (64 bit per sample)

* .cs32

* .cu64: 64-bit per value (128 bit per sample)

* .cs64

* .cf32 (.cfile .complex): Float, 32-bit per value (64 bit per sample) - Complex 32-bit floating point samples (GNURadio, osmocom_fft)

* .cf64: Double Float, 64-bit per value (128 bit per sample)

