# RF et SDR basics

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
| FFT | Fast Fourier transform, permet de convertir une suite nombres complexes en Frequences |
| Procédure | c’est un ensemble de règles qui fixent la forme et la succession des émissions, dans le but de garantir la REGULARITE et la RAPIDITE d’acheminement du trafic et d’assurer la SECURITE des transmissions. L’inobservation de ces règles provoque l’inefficacité, des indiscrétions, de la confusion et un manque de rapidité opérationnelle. |
| Station | c’est un ensemble d’appareils et de personnels placés sous l’autorité d’un chef de station, mis à la disposition d’une ou plusieurs autorités en vue de réaliser une ou plusieurs liaisons. |
| Réseau | C’est un ensemble de stations (radio, FH, TG) qui travaillent entre elles suivants les mêmes règles imposées et les mêmes caractéristiques (fréquences, indicatifs, modulation).
| Indicatif | n appelle indicatif, un ensemble de lettres ou de chiffres, ou de lettres et de chiffres mélangés pouvant désigner soit une station (ou un groupe de stations) soit une autorité (ou un groupe d’autorités). | 
| SDR | Software-Defined Radio |
| DSP | Digital Signal Processing |



## Mise en oeuvre

1. Vérifier l’arrêt puis,
2. ANTACAL : ANTenne ACcessoires ALimentation
3. Utiliser des cables blindés sous peine d'avoir un signal de mauvaise qualité

```
Pour les ER avec forte puissance d'émission:
NE JAMAIS EMETTRE SANS ANTENNE
NE JAMAIS TOUCHER L’ANTENNE EN EMISSION
```

## SDR software define radio

`Antenna` <-> `Ampli + filter` <-> `Analog/Digit` <-> `Modem error correction` <-> `Encryption` <-> `Network routing GUI` <-> `User`

## Modulations

| Type | Designation | Description | Cas d'usage |
|------|-------------|-------------|-------------|
| Amplitude | AM | modulation d'amplitude | Radio Analogique "grandes ondes"|
| Amplitude | ASK | Shift Keying | |
| Frequence | FM | modulation de freq. | Radio Analogique |
| Frequence | FSK | Shift Keying | RFID |
| Frequence | GFSK | guaussian (signal plus propre) | Bluetooth |
| Phase | BPSK | simple 2 état à 180° |  |
| Phase | QPSK | Quadrature |  |
| Phase | GMSK| Gaussian minimum-shift keying  | GSM |
| Amplitude+Phase | QAM | Quadrature - completé par nombre de bits | TNT |
| autre | OFDM | Orthogonal Frequency-division multiplexing | sous porteuse espacé en Freq qui utilisent d'autres modulations (BPSK, QPSK, QAM-16, QAM-64…) | UMTS,LTE, CPL, Wifi |
| autre | OOK | Binaire (On-Off Key) | télécommandes et morse |
| autre | USB | Upper Side Band = Bande Latérale Supérieure ||
| autre | LSB | Lower Side Band = Bande Latérale Inférieure ||
| autre | SSB | Single Side Band = Bande Latérale Unique (BLU) ||


## Encodage

NRZ, NRZI, Manchester, Miller, bipolaires

## Antennes

* Verticales omnidirectionnelles à λ/2 ou λ/4

* Directionnelles avec directeurs, radiateur et réflecteur ex: Yagi

* Parabolique (ex: reception sattelite)

* Loop et cadre magnétique (ex: RFID)

## informations sur les produits

* [FCC](https://www.fcc.gov/)

## Tools

* [SDRSharp (SDR#)](https://airspy.com/download/) : analyse de spectre et démodulations audio (analogique) et plugins pour numérique
* [SDRAngel](https://www.sdrangel.org/), Universal Radio Hacker : analyse de spectre, analyse de capture / fichiers pour démoduler des signaux numériques
* [PothosSDR](https://www.pothosware.com/) : flow
* [GNU Radio](https://www.gnuradio.org/) / Radioconda : flow
* [SoapySDR](https://github.com/pothosware/SoapySDR/wiki) : API
* [qt-Dab](https://github.com/JvanKatwijk/qt-dab/releases) : Radio Numerique Terrestre (RNT DAB+) - rester en version 2.7 pour windows

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

### convertir les fichiers:

Convert the file from unsigned 8-bit integers to 32-bit floats. This can be done with:

```powershell

PS > C:\Program` Files` `(x86`)\sox-14-4-2\sox.exe .\wifi-like.s8 wifilike.f32

C:\Program Files (x86)\sox-14-4-2\sox.exe WARN raw: `.\wifi-like.s8': sample rate not specified; trying 8kHz
C:\Program Files (x86)\sox-14-4-2\sox.exe WARN raw: `.\wifi-like.s8': # channels not specified; trying mono

PS > ls *.f32

 Répertoire : C:\Users\vaca\OneDrive\Documents\Projets-InfoSec\Keisei-sanshoku\ER\OpenER
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        24/03/2023     09:19     1858076672 wifilike.f32
```

## Numpy

exemples de "signal Discrete Fourier Transform" (DFT)

```python

signal = numpy.random.random(10) + 1j * numpy.random.random(10)

signal = numpy.exp(1j * 2 * numpy.pi * (2.5 / 128) * numpy.arange(128))

```

voir les scripts pour aller plus loin