# Leurre et usurpation (spoofing) RF

Initiation aux Émissions Opérationnelles (écoutes et captures bas niveau, leurres et usurpation).

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Poids: 1

## Ressources


* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* `Dossier Toolbox RF`

* Fichier CS8 (Drone et phonie)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)


## Contexte

Analysez le signal et remettez le en forme pour le ré-émettre



## Modalités pédagogiques

Binôme


### Mise en forme du signal

> Utiliser le LaNa sans DC block peut endommager le SDR !

1. à l'aide de l'outil `SDRSharp` jouez avec les amplis `LNA` et `VGA` pour améliorer la qualité du signal reçu.

2. Optionnel : Utiliser le `HackRF` équipé du `DC blocker` et du `LaNA` pour améliorer encore la qualité des signaux reçu (ex. GPS)


### Rejeu

> Afin de rester conforme à la réglementation, l'usage d'un ampli externe (LaNA) pour l'émission est interdit.

1. Analyser ce que contient le fichier `.cs8` (émission drone et phonie)

2. Rejouer le signal capturé d’un appareil sur les ondes, jouer avec les options du `SDR` pour améliorer la qualité de l'émission.

3. Observer la signature usurpée à l’analyseur de spectre ou écouter si le fichier contient de la voix.

4. Identifier les éventuelles différences entre le signal usurpé et l’authentique grâce aux données SIGINT et à vos propres tests. (porteuse, répétition, largeur de bande…)


## Modalités d'évaluation

* présentation orale ou Livrable

## Livrables

* screenshots

## Critères de performance

* réussite de la transmission
* Pertinance de l'analyse

# HW

HackRF

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)