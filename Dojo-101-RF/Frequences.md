# frequences

## Gammes de Frequences

| Frequency band | Signal  range |
|-----------------|-----------------|
|Very low frequency (VLF)|3 kHz–30 kHz|
|Low frequency (LF)| 30 kHz–300 kHz|
|Medium frequency (MF)| 300 kHz–3,000 kHz|
|High frequency (HF)| 3,000 kHz–30 MHz|
|Very high frequency (VHF) |30 MHz–300 MHz|
|Ultra high frequency (UHF)| 300 MHz–3,000 MHz|
|Super high frequency (SHF)| 3,000 MHz–30 GHz|
|Extremely high frequency (EHF)| 30 GHz–300 GHz|
|Uncategorized | 300 GHz–3,000 GHz |


## Bandes libres en France

Source: [ARCEP](https://www.arcep.fr/la-regulation/grands-dossiers-reseaux-mobiles/le-guichet-start-up-et-innovation/le-portail-bandes-libres.html)

| Fréquences | Utilisations notables|
|------------|----------------------|
| 13 553 – 13 576 kHz | RFID, NFC |
| 169,4 – 169,8125 MHz | Wize |
| 433,05 – 434,79 MHz | Talkies-walkies, télécommandes, LoRa|
| 863 – 868,6 MHz | z-Wave, Sigfox, LoRa, RFID UHF, Zigbee|
| 868,7 – 869,2 MHz	 ||
| 869,3 – 869,65 MHz	 ||
| 869,7 – 870 MHz	 ||
| 2400 – 2483,5 MHz	| Wi-Fi, Bluetooth, Zigbee, Thread|
| 5150 – 5350 MHz	||
| 5470 – 5725 MHz ||

## Radios classiques

| Modulation | Frequences |
|------------|------------|
| FM |  87.5 à 107.9 MHz |
| AM | 150 kHz à 281 kHz |
| AM | 520 à 1620 kHz |
| AM |  2,3 à 26,1 MHz |

## RNT (Radio Numérique Terrestre)

| DAB+ | 174 à 240 MHz |


## Fréquences d'urgence, détresse et essentielles - France et Europe HF VHF UHF

Source: [Groupe FCF](https://groupefcf.org/)

| NOM DE LA FREQUENCE	| FREQUENCE	| MODULATION |	SERVICE |	PAYS |
|-----------------------|-----------|------------|----------|-----|
|GUARD	| 121.500 |	AM |	Aéronautique civil |	International|
|S.A.R	| 123.100 |	AM	|Aéronautique civil |	International |
| VHF 16 |	156.800 |	NFM	| Maritime |	Mondiale |
|CANAL (E)MERGENCY |	161.300 CT 123.0 TX ZVEI1: 21313 (pour certains pays) |	NFM | Secours Montagne |	France , Italie , Suisse , Allemagne |
|GUARD | 243.000 |	AM | Aéronautique Militaire |	International |
| EmCOM VHF |	145.550 | NFM |	Radioamateur | Europe | 
| LPD 20 EmCOM | 433.550 | NFM |	Radioamateur Usage libre LPD433 10Mw PAR | France Europe |
| C.B 09 |	27.065 |	AM / NFM / USB | 	URGENCE Bande Citoyenne	France | Europe |
| PMR 1-12 | 446.00625 CT 100.0 RX TX |	NFM | URGENCE  PMR446 |	France Europe |
| PMR 3-33 SHTF Survie - prévoyance | 446.03125 CT 210.7 RX TX | NFM |	canal d'intercomm entre différents groupes de survivalistes et prévoyants |	France Europe |
| C.B03 SHTF SURVIE PREPPERS |	26.985 | AM/NFM/USB | Canal SHTF SURVIE PREPPERS | Mondial |
| PMR 7-7 Seguridad en Montana (Espagne) Radio Rando Montagne (France) | 446.08125 CT 85.4 RX TX | NFM | COMM RANDO MONTAGNE (peut servir de fréquence d'urgence en zone montagneuse) |PMR446 | France Espagne Europe |
| CANAL (M) ONTAGNE | 169.575 CT 85.4 RX TX |NFM |	canal sécurité montagne bande libre VBL169 MHz |France |
| PMR 8-18 Détresse (voix + balise) | 446.09375 CT 123.0 TX (pour détresse) CT 123.0 TX RX (pour les stations de veille) |	NFM |appels de détresses sur canal d'appel (8) avec ajout d'un filtre 123.0 afin d'être également entendu par les stations de veille |	France |
| EmCOM DMR 9112 PMR 09 |	446.10625 TG 9112 CC1 |	NFM |	PMR446 Digital | France Europe |
|| 21.360 | USB | Radioamateur |Europe Region 1 |
|| 18.160 |	USB |	Radioamateur	| Europe Region 1 |
|| 14.300 |	USB |	Radioamateur	|Europe Region 1 |
|| 7.110 |	LSB	| Radioamateur |	Europe Region 1 |
||3.760	| LSB |	Radioamateur | Europe Region 1 |
|| 2.182 |	USB / AM |	Maritime |	International |
||2.191 |	USB / AM |	Maritime | International |
||3.023	| USB / AM |	Aéronautique |	International |
||4.125	 ||	Aeronautique Maritime |	International |
||5.680 | USB |	Aeronautique Maritime |	International |
|| 6.215 || Aeronautique Maritime |	International |

### Complément FCf

* cf `Baofeng_UV-5R_V1-2.csv`

* fichier lisez moi:

```
** En aucun cas le groupe FCF sera tenu responsable d'une mauvaise utilisation des fréquences radio; toutes les fréquences 
proposés sur ce codeplug sont uniquement réservé à de l'écoute ** 


fichier .img uniquement compatible avec UV5R et certains variants à utiliser avec le menu [ouvrir / sauvegarder]
fichier .csv compatible avec n'importe qu'elle radio couvrant les fréquences 136-174 MHz et 400-470 MHz,
pensez à l'utiliser avec les menus [importer / exporter]


LEXIQUE : 

T = CTCSS uniquement en émission 
* = détresse 
! = appel 
!* = canal d'appel et de détresse 

*bande PMR446 pour plus d'info http://fcf77.wifeo.com/la-norme-pmr446.php*


0: PMR8 TX 18 avec sous canal 18 uniquement en émission (TX) le canal 8 est celui destiné
 à l'appel sur la bande PMR446 le sous canal 18 est destiné à de la détresse en France, 
la réception est quand à elle ouverte à toute communications car aucun sous canal en RX.

1: Canal 1 PMR446
2: Canal 2 PMR446
3: Canal 3 PMR446 
4: Canal 4 PMR446 
5: Canal 5 PMR446
6: Canal 6 PMR446
8: Canal 8 PMR446 
9: Canal 9 PMR446
10: Canal 10 PMR446
11: Canal 11 PMR446
12: Canal 12 PMR446
13: Canal 13 PMR446
14: Canal 14 PMR446
15: Canal 15 PMR446 
16: Canal 16 PMR446
17: Canal 1 avec sous canal 1 souventprogrammé par défaut sur les talkie-walkies du commerce 
18: Canal 1-2 CSC Canal Sécrité Chasse (comme le .12) 
19: Canal 1-9 CSR Canal Sécurité Route (comme le canal 19 CB) 
20: Canal 1-12 Canal communication d'urgences europe 
21: Canal 2-2 PMR446 
22: Canal 2-8 Canal Camping-Car 
23: Canal 3-3 survie prévoyance destiné aux relais 
24: Canal 3-13 survie prévoyance destiné aux relais 
25: Canal 3-23 survie prévoyance destiné aux relais 
26: Canal 3-33 survie prévoyance appel, communications direct 
27: Canal 4-4 pratiquants 4x4, sorite 
28: Canal 4-14 Canal Sécurité Drônes entre pratiquants FPV afin déviter tout danger
alerte météo ou autres 

29: Canal 5-5 Radioscoutisme 
30: Canal 6-6 destiné aux relais expérimentaux aussi appellé R1 
31: Canal 6-16 destiné aux relais expérimentaux aussi appellé R2 
32: Canal 6-26 destiné aux relais expérimentaux aussi appellé R3 
33: Canal 6-36 destiné aux relais expérimentaux aussi appellé R4
34: Canal 7-7 RRM Radio Rando Montagne destiné aux communications entre pratiquants
de la rando, bivouac, bushcraft, alpinisme ou toutes autres pratiques en extérieur, 
peut aussi être utilisé pour de la détresse entre pratiquants mais également 
pour les communications de sécurité http://77rrm.fr/ 

35: Canal 8-8 destiné à l'appel entre pratiquants PMR446 
36: Canal 8-18 destiné à la détresse réservé à la veille de celle-ci, pour lancer 
un appel de détrese -> Mémoire 0


*bande VFB pour plus d'infos http://fcf77.wifeo.com/vfb-169-mhz.php*


37: Canal 1 VFB destiné aux appelles et à la détresse 
38: Canal 2 VFB 
39: Canal 3 VFB destiné à la survie prévoyance 
40: Canal 4 VFB destiné au Packet radio APRS 
41: Canal 5 VFB 
42: Canal 6 VFB destiné aux relais expérimentaux 
43: Canal 7 VFB Canal (M) ontagne semblable au 7-7 RRM de la bande PMR446 


*bande VHF marine pour plus d'info http://fcf77.wifeo.com/vhf-marine.php*


44: Canal 9 VHF marine veillé par les capitaineries des ports de plaisance
45: Canal 10 VHF marine destiné aux communications fluviales, Marine Nationale 
46: Canal 11 VHF marine 
47: Canal 12 VHF marine 
48: Canal 13 VHF marine 
49: Canal 14 VHF marine dégagement du canal 15 VHF marine 
50: Canal 15 VHF marine surveillance des plages, postes de secours 
51: Canal 16 VHF marine d'appel, de sécurité, d'urgence et de détresse, ce canal est veillé par
toutes les VHF marines en double veille ainsi que par toutes les capitaineries, ports
Marine Nationale, secours en mer, CROSS etc.. 

52: Canal 17 VHF marine 
53: Canal 18 VHF marine 
54: Canal 67 VHF marine communications entre navires, canal de dégagement secours en mer
55: Canal 68 VHF marine communications entre navires, canal de dégagement secours en mer
56: Canal 69 VHF marine communications entre navires, canal de dégagement secours en mer
57: Canal 70 VHF marine uniquement ASN Appel Selectif Numérique, appel de détresse numérique
58: Canal 71 VHF marine communications entre navires, canal de dégagement secours en mer
59: Canal 72 VHF marine communications entre navires, canal de dégagement secours en mer 
60: Canal 73 VHF marine communications entre navires, canal de dégagement secours en mer 
61: Canal 74 VHF marine communications entre navires, canal de dégagement secours en mer 
62: Canal 77 VHF marine communications entre navires


*fréquence FFVL parapente 
pour plus d'info https://federation.ffvl.fr/pages/fr-quences-et-postes-radio-pour-vol-libre*


63: Canal FFVL Fédération Française de Vol Libre, parapente, canal de sécurité, d'info météo 
de détresse entre pratiquants 


*fréquence Canal E mergency 
pour plus d'info http://fcf77.wifeo.com/canal-emergency-montagne.php*


64: Canal E mergency destiné aux communications de sécurité, d'rugence et de détresse 
dans la zone des alpes Haute Savoie, ce canal est gratuit mais nous vous recommandons 
de passer via un revendeur de matériel radio pro agréé dispo sur le guide (lien du dessus) 


*bande radioamateur usage soumis à licence, pour les fréquences LPD433 en service partagé
avec les radioamateurs pour plus d'info http://fcf77.wifeo.com/la-norme-lpd433.php*

65: Canal 1 VHF ADRASEC destiné à de la détresse 
66: Canal 2 VHF ADRASEC 
67: Canal 3 VHF ADRASEC 
68: Canal 18 bande LPD433 canal d'appel radioamateurs partagé avec LPD433
69: Canal 20 bande LPD433 canal communications d'urgence partagé avec LPD433
70: Canal d'appel VHF service radioamateurs 
71: Canal ISS VHF International Spacial Station destiné aux communications simplex 
entre l'ISS et la terre dans le cadre de communications avec des écoles ou de l'envoie
d'images en mode SSTV en mode PD120 
72: Canal ISS UHF International Spacial Station destiné aux communications simplex 
entre l'ISS et la terre dans le cadre de communications avec des écoles
73: Canal de sortie du relais transpondeur ambarqué sur l'ISS, 
fréquence d'entrée 145.990 + CT 67.0 Hz, contact radioamateur via le relais.
Assez souvent écoutable depuis le sol avec un simple portatif.
74: Canal 1 UHF destiné aux communications d'urgence service radioamateur 
75: Canal 2 UHF destiné aux communications d'urgence service radioamateur 
76: Canal 3 UHF destiné aux communications d'urgence service radioamateur


************ n'hésitez pas à nous proposer d'autres fréquences utiles et ludiques***********

FCF groupe
```

## Internet

[WRN World Radio Network](https://www.encompass.tv/solutions/radio/)

