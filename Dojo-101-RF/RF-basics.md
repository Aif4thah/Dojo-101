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

Amplitude AM, et en quadrature QAM, ex: TNT
Binaire (On-Off Key), ex: télécommandes
Fréquence FM
Déplacement de frequence FSK, ex: RFID 
Changement de phase PSK et en quadrature QPSK
Gaussian minimum-shift keying ex: GSM
Orthogonal Frequency-division multiplexing (OFDM), ex: UMTS,LTE, CPL, Wifi

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
