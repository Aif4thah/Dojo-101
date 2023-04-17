# Morse 

## avantages

* Pas de modulation, juste "émission ou non". 
* plus de portée et de résistance aux perturbations

## inconvénients

* Lenteur
* peu de caractères disponibles

## codes

### Lettres

| char | code |
|------|------|
|A| .- |
|B| -... |
|C| -.-. |
|D| -.. |
|E| . |
|F| ..-. |
|G| --. |
|H| .... |
|I| .. |
|J| .--- |
|K| -.- |
|L| .-.. |
|M| -- |
|N| -. |
|O| --- |
|P| .--. |
|Q| --.- |
|R| .-. |
|S| ... |
|T| - |
|U| ..- |
|V| ...- |
|W| .-- |
|X| -..- |
|Y| -.-- |
|Z| --.. |

### chiffres
| char | code | code court|
|------|------|-----------|
|0| ----- | - |
|1| .---- | .- |
|2| ..--- | ..- |
|3| ...-- | ...- |
|4| ....- | ....- |
|5| ..... | ..... |
|6| -.... | -....|
|7| --... | -... |
|8| ---.. | -.. |
|9| ----. | -. |

### Ponctuation

| char | code | Observation|
|------|------|------------|
| é | ..-.. ||
| . | .-.-.- ||
| , | --..-- ||
| : | ---... ||
| ? | ..--.. | demande la retransmission d'un message incompris |
| ' | .----. ||
| - | -....- ||
| \| | -..-. ||
| ( | -.--.- ||
| ) | -.--.- ||
| à | .--.- ||
| souligné | ..--.- | avant et après la partie soulignée |
| double trait | -...- ||

### Misc

| msg | code | Observation|
|------|------|------------|
| compris | ...-. ||
| erreur | ........ ||
| fin de transmission | .-.-. ||
| à vous | -.- ||
| Attente | .-... ||
| Fin de travail | ...-.- ||
| Signal de commencement | -.-.- | commencement de toute transmission |
| séparatif | .-..- | pour la transmission de chiffres / nombres / coordonnées |


## mise en oeuvre

* n'importe quelle radio (ex.: jouer avec la pédale du combiné ou du talkie-walkie)
* n'importe quel signal lumineux, sifflet, outil, etc..

## Automatisation de transmissions Morse avec hackrf

projet initial [morse_synth.py](https://gist.github.com/jboone/de67df55a2059dcebcdb), modifié via le script `Morse.py`

* installer python
* `pip install numpy`

```Powershell
python .\Morse.py TEST test.cs8
hackrf_transfer -s 8000000 -x 16 -a 1 -f 144050000 -b 1750000 -t test.cs8
```

* Lire le fichier avec `Universal Radio Hacker` avant l'envoi permet d'en vérifier le contenu.

## réception avec SDR Sharp

Écouter (CW) / lire le code morse dans le spectrogramme (Waterfall)

## réception avec Universal radio hacker

* Enregistrer la reception dans un fichier binaire (IQ) et puis visualiser le signal

