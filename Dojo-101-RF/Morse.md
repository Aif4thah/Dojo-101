# Morse 

## avantages

* Pas de modulation, juste "émission ou non". 
* plus de portée et de résistance aux perturbations

## inconvénients

* Lenteur
* peu de caractères disponibles

## codes

| char | code |
|--|----|
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
|0| ----- |
|1| .---- |
|2| ..--- |
|3| ...-- |
|4| ....- |
|5| ..... |
|6| -.... |
|7| --... |
|8| ---.. |
|9| ----. |

## émission avec hackrf

projet [morse_synth.py](https://gist.github.com/jboone/de67df55a2059dcebcdb)

* installer python
* `pip install numpy`

```Powershell
python .\Morse.py TEST test.cs8
hackrf_transfer -s 8000000 -x 16 -a 1 -f 144050000 -b 1750000 -t test.cs8
```

## réception avec SDR Sharp

Lire le code morse dans le spectrogramme (Waterfall)

