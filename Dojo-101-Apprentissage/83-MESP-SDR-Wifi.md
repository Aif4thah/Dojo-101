# Sécurité des réseaux sans fils

Software Defined Radio, Wifi, Rogue AP, Brouillage

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Durée: 1,5 jour

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* Dossier Toolbox RF

* Fichiers de captures Wifi

* Video jam wifi

* [HackRF](https://greatscottgadgets.com/hackrf/one/)

* [Aircrack-ng](https://www.aircrack-ng.org/)

* [Acrylicwifi](https://www.acrylicwifi.com/fr/)

* [Wireshark](https://www.wireshark.org/)

## Contexte

Cette formation propose une approche RF (radiofréquence) de la sécurité Wifi. 

Comprendre les concepts RF et l'utilisation du HackRF peut prendre un certain temps, mais ces connaissances vous serviront à long terme et quel que soit le protocole sans fils rencontrés.

### Protocoles et vulnérabilités

1. Analyzer les fichiers `pcap`
2. Quelles sont les vulnérabilités connues pour ces protocoles Wifi ?
3. Quels autres protocoles recommanderiez-vous pour une entreprise ?

### jamming et résilience

> La puissance du HackRF étant limitée, il faut placer l’antenne à proximité (quelques mètres) pour réaliser le brouillage

1. Identifier le canal Wifi de la cible 
2. Trouver la fréquence correspondante
3. Tester le brouillage pour empêcher la communication
4. Observer si la fréquence et le canal de la cible changent


### Rogue AP et detection

> L'antenne directionnelle contient une âme (centre coaxial) de fortune pour pouvoir être utilisée avec le HackRF, il faut l'enlever pour l'utiliser avec une carte Wifi classique, SVP soyez extrêmement soigneux pour préserver le matériel.

1. Monter un rogue access point avec les moyens du bord (Téléphone, Machine Linux)
2. Toujours avec les moyens du bord (Carte Wifi / HackRF), comment le détecter ?
3. Optionnel : À l'aide d'une antenne directionnelle, trouver son emplacement.



## Modalités pédagogiques

Binôme

## Modalités d'évaluation

* présentation ou livrable

## Livrables

* Document pdf ou markdown avec screenshots

## Critères de performance

* réussite des actions demandées.

## HardWare

* HackRF (Facultatif: antenne directionnelle)

* Point d’accès Wifi

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)