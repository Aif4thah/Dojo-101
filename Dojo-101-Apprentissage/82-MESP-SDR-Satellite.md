# Satellites et GPS Spoofing

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Durée: 2 jours

## Ressources


* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* Dossier Toolbox RF

* [Space Track](https://www.space-track.org/)

* [SatDump](https://www.satdump.org/)

* [PhyPhox](https://phyphox.org/)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)

## Contexte

> Recevoir et démoduler correctement des signaux satellites à l'aide d'un simple dipôle et d'une configuration manuelle est difficile et peut échouer dans le temps imparti. Normalement cela se fait avec une antenne parabolique qui suit le satellite, car cette dernière offre un gain plus élevé et une meilleure directivité, permettant ainsi de capter des signaux plus faibles et de réduire les interférences.

### Démodulation de Signal Satellites

0. S'inscrire sur `SpaceTrack` et obtenir ses coordonnées GPS à l'aide de l'app `phyphox`
1. Rechercher les satellites NOAA et Meteor sur `SpaceTrack`
2. Installer `SatDump` et configurer ses coordonnées au format décimal (`QTH`) et son compte `SpaceTrack`.
3. Connecter le `HackRF` ou autres `matériel SDR` avec une antenne de type `Dipole`.
4. Réussir à visualiser le passage d'un satellite `NOAA` ou `Meteor` et à planifier l'enregistrement des données.
5. Réussir à enregistrer une image transmise par les satellites `NOAA` ou `Meteor`.


### sécurité GPS

0. Couper toutes connexions autres que le GPS / Localisation.
1. Analyser les satellites et `signaux GPS` reçus via PhyPhox et les applications.
2. Si possible, mettez à jour le fichier des `éphémérides` (*Broadcast ephemeris data* de la NASA.)
3. Préparer un fichier de `spoofing` avec une position erronée (mais réaliste). 
4. Usurper les signaux GPS à l’aide du `HackRF` à proximité de vos instruments.
5. `Analyser` le comportement de phyphox et d’autres applications.

> Certaines applications peuvent prendre en compte les dernières positions connues, les points d'accès wifi et sélectionner uniquement certains satellites, a vous de mener vos tests et de voir ce qui réussit ou non.

## Modalités pédagogiques

Binôme

## Modalités d'évaluation

* présentation orale ou Livrable

## Livrables

* screenshots

## Critères de performance

* réussite de la transmission
* Pertinance de l'analyse

# Hardware

HackRF
Récepteur GPS (Voiture, Téléphone, Drone, Tracker…)


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)