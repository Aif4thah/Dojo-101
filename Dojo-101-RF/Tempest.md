# TEMPEST


## Reconstitution d'ecran via les émanations des cables (HDMI)

### TempestSDR + HackRF

https://github.com/eried/Research/tree/master/HackRF/TempestSDR

1. avec un analyseur de spectre (`SDRSharp`), chercher 100 Mhz to 500 Mhz la frequence d'emission du cable HDMI
2. ouvrir `TempestSDR` 
3. choisir la source `file` -> `ExtIO source`
4. se mettre sur frequence exacte et jouer avec les options pour reconstituer l'image

