# Configurer le fw sur une machine Linux

Il vous est demandé de configurer le firewall d'un serveur Linux selon les modalités ci-après

Durée estimée: 2 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[nmap](https://nmap.org/)

## Contexte

1. Déployer une machine Linux

2. Implémenter la configuration suivante:

Interdire tous les flux en entrée par défaut, mais permettre les connexions déjà établies (statefull)
Autoriser DHCP
Autoriser DNS uniquement vers 8.8.8.8
Autoriser HTTPS sortant et SSH entrant
Autoriser HTTP uniquement vers le domaine taisen.eu
Interdire tous les autres flux en sortie
Activer le forwarding des trames et rediriger vers la passerelle par défaut
Dropper ICMP

3. Vérifier à l'aide de l'outil **nmap** que le firewall fonctionne correctement


## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

lecture de la procédure

## Livrables

captures décran des commandes `uname -a`, `date`, et resutlat des scan nmap

Procédure de configuration et de vérification au format markdown

## Critères de performance

Réussite de l'exercice et pertinence de la procédure
