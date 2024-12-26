# GPS

* 1164-1215 MHz
* 1215-1300 MHz
* 1559-1610 MHz 


## analyzer

### Android

* GPS TEST

## tool for hackrf

* [GPS-SDR-SIM](https://github.com/osqzss/gps-sdr-sim/)

## Spoofing

### télécharger le dernier fichier de broadcast (NASA earth data): 

https://cddis.nasa.gov/archive/gnss/data/daily/2023/brdc/

### recuperer une coordonnée GPS: 

ex `71.74979859541622, -40.1146284141901`

### creer un fichier bin : 

-b 8 pour hackrf .cs8
-l Latitude,longitude,altitude

```Powershell
.\gps-sdr-sim.exe -b 8 -e .\brdc0870.23n -l 71.74979859541622,-40.1146284141901,50
```

### Emettre la position choisie :

```powershell
hackrf_transfer -R -t gpssim.bin -f 1575420000 -s 2600000 -a 1 -x 42
```
