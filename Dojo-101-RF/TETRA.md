# Terrestrial Trunked Radio (TETRA)

* système de radio numérique mobile professionnel bi-directionnel
* Modulation:  `π/4 DQPSK`

## Demodulation

### SDR Sharp

1. Plugin tetra
2. Copier les .dll directement dans le dossier SDR# (pas dans plugins)
3. ajouter `<add key="Tetra" value="SDRSharp.Tetra.TetraPlugin,SDRSharp.Tetra"/>` dans la balise `</sharpPlugins>` plugin .xml
4. WFM, sample >= 48k
5. ouvrir le plugin et coher "demodulator"
6. placer les "ligne" au milieu de chaque diagram (0, π/2 etc...)
7. écouter (rien d'intéligible si chiffrement)