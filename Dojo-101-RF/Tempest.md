# TEMPEST

## Mesure du chanmps electromagnétique

`BT` le champs magnétique terrestre se mesure sur les 3 axes : BTx, BTy et BTz en micro Tesla : `B(µT)` 

### Android + PhyBox

* [PhyBox](https://phyphox.org/)

Le magnétométre permet la détection des émissions électro magnétique des appareils éléctroniques


## Reconstitution d'ecran via les émanations des cables (HDMI)

### TempestSDR + HackRF

* [TempestSDR](https://github.com/eried/Research/tree/master/HackRF/TempestSDR)

1. avec un analyseur de spectre (`SDRSharp`), chercher 100 Mhz to 500 Mhz la frequence d'emission du cable HDMI
2. ouvrir `TempestSDR` 
3. choisir la source `file` -> `ExtIO source`
4. se mettre sur frequence exacte et jouer avec les options pour reconstituer l'image

