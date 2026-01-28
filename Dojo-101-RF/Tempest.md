# TEMPEST

## Mesure du chanmps electromagnétique

`BT` le champs magnétique terrestre se mesure sur les 3 axes : BTx, BTy et BTz en micro Tesla : `B(µT)`

### Android + Phyphox

* [Phyphox](https://phyphox.org/)

Le magnétométre permet la détection des émissions électro magnétique des appareils éléctroniques

## Reconstitution d'ecran via les émanations des cables (HDMI)

### TempestSDR + HackRF

* [TempestSDR](https://github.com/eried/Research/tree/master/HackRF/TempestSDR)

1. avec un analyseur de spectre (`SDRSharp`), la frequence d'emission du cable HDMI (Pixel Clock). Souvent on est sur un multiple de 148.5 MHz (297, 445.5 etc.).
2. ouvrir `TempestSDR` 
3. choisir la source `file` -> `ExtIO source`
4. se mettre sur frequence exacte et jouer avec les options pour reconstituer l'image

> [!TIP]
> En cas de chiffrement de l'image, `protocole HDCP` on a une "Neige Fixe".
