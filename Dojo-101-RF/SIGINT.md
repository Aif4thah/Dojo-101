# indentification de signal SIGINT

## methode:

1. Capture

Every fruitful hunt starts from this first most important step! Try to gain as much information as possible: Frequency, Bandwidth, Mode, and so forth. Even the smallest detail could be decisive!

2. Inspection

Inspect the unknown signal with many useful tools: compare the waterfall, listen to an audio sample to discover similarities, or use the advanced filtering functions to reduce possible erroneous matches.

3. Identification

When only a few signal candidates remain on the top list, try to cross every piece of information you have in combination with the most detailed description readily available on sigidwiki.com... now should be easy to understand what you are looking for​.

Source: https://www.aresvalley.com/artemis/

## Manuellement

* Documentation `SDR#` avec captures d'écran

## via Base de données

### Internet

[sigidwiki](https://www.sigidwiki.com/wiki/Signal_Identification_Guide)

### Artemis

[Artemis.exe](https://www.aresvalley.com/artemis/)
[Artemis Github](https://github.com/AresValley/Artemis)

## automatisation via logiciels

[SigDigger](https://github.com/BatchDrake/SigDigger)

## Captures

| Id | Freq (Mhz) | Capture |
|:----:|----: |:---------:|
|FM (radio)| 107 | ![1](./SIGINT-images/1-107Mhz.png)|
|Morse (script SDR - hackRF)| 433 | ![2](./SIGINT-images/2-433Mhz.png)|
|AM (aviation civile)| 121 | ![3](./SIGINT-images/3-121Mhz.png)|
|Cable HDMI (émission compromettante d'un écran déporté)| 148 | ![4](./SIGINT-images/4-148Mhz.png)|
|Wifi (Boxe internet)| 2400 | ![5](./SIGINT-images/5-2400Mhz.png)|
|DECT (Babyphone Avent Philips - aussi utilisé pour des téléphones d'entreprise)| 1889 | ![6](./SIGINT-images/6-1889Mhz.png)|
|Bluetouth (5.0) Low Energy (écouteurs Google pixels buds et leur boitier) - norms proprietaire de Google Fast Pair (GFPS)| 2400 | ![7](./SIGINT-images/7-2400Mhz.png)|
|POCSAG (système de messagerie utilisé par les sapeurs-pompiers et des sociétés privées - échanges privés capturés près de Grenoble)| 466 | ![8](./SIGINT-images/8-466Mhz.png)|
|Télécommande portail (ouverture de résidence avec télécommande FERPORT TAC2KR)| 433 | ![9](./SIGINT-images/9-433Mhz.png)|
|LoRa (Communication IoT non identifié)| 433 | ![10](./SIGINT-images/10-433Mhz.png) |
|Téléphonie - 4G LTE (bandes montante et descendante)| 800 | ![11](./SIGINT-images/11-800Mhz.png) |
|Drone - commandes + camera (DJI Tello)| 2442 | ![12](./SIGINT-images/12-2442Mhz.png) ![12-1](./SIGINT-images/12-Drone-DJI-Tello-Camera-telemetrie-cmd.png) ![12-2](./SIGINT-images/12-Drone-DJI-Tello-Perte-de-signal-et-arret.png) |
|NFC NXP - Mifare+ ISO 14443-4 (lecture de clé Yubikey avec l'application mobile yubico)| 13.550 | ![13](./SIGINT-images/13-13Mhz.png) |
|Télécommande de voiture téléguidée| 27 | ![14](./SIGINT-images/14-27Mhz.png) |
| Scan de détection Airtags (Detecteur de traqueur Apple pour Android) | 2400 | ![15](./SIGINT-images/15-2400Mhz-Scan-Airtags-Apple-detector-Android.png) |
| Airtag Advertising - (Apple Airtag) | 2400 | ![16](./SIGINT-images/16-2400MHz-Airtag-Advertising.png) |

