# Sécurité des réseaux sans fils

Software Defined Radio, Wifi, Rogue AP, Brouillage

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Durée: 2 jour

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)

* [Aircrack-ng](https://www.aircrack-ng.org/)

* [Acrylicwifi](https://www.acrylicwifi.com/fr/)

* [Wireshark](https://www.wireshark.org/)

* Dossier Toolbox RF

* Fichiers de captures Wifi

* Video jam wifi


## Contexte

Vous êtes chargé d'analyser la sécurité des réseaux sans fil de l'entreprise ABC.

### Protocoles et vulnérabilités

0. Lister les points d'accès wifi qui vous entourent et leurs protocoles d'authentification.
1. Analyzer les fichiers `.pcap`, que contiennent ces captures ?
2. Quelles sont les vulnérabilités connues pour ces protocoles Wifi (parler à minima de `WPA2` et `WPA3`) ?
3. Quels autres protocoles recommanderiez-vous pour une entreprise ? Pourquoi ?
4. Une capture du trafic Wifi a été réalisée à l'aide de l'outil Aircrack-ng. Mettez en place une attaque par force brute afin de `cracker la clé WPA-PSK`.

### jamming et résilience

> La puissance du HackRF étant limitée (pas d'ampli pour respecter le cadre légal), il faut placer l’antenne à proximité (quelques mètres) pour réaliser le brouillage

1. Identifier le canal Wifi de la cible 
2. Trouver la `fréquence` exacte correspondante
3. Tester le brouillage pour empêcher la communication, jouer avec la puissance et la bande-passante.
4. Observer si la fréquence et le canal de la cible changent et si le clients continuent à avoir accès au réseau.


### Rogue AP et détection

> Dans l'idéal, un Rogue Access Point se fait passer par un Access Point légitime : même nom, même adresse Mac, etc. Mais si vous n'êtes pas à l'aise, commencer par monter un AP plus facile à identifier.

1. Monter un `rogue access point` avec les moyens du bord (Téléphone, PC)
2. Toujours avec les moyens du bord (Carte Wifi / HackRF), comment détecter les points d'accès wifi malveillants ou non légitimes des autres binômes ?
3. En vous déplaçant et/ou l'aide de l'antenne directionnelle, trouver son emplacement.

*Hint: Vous pouvez faire le lien entre les canaux des SSID wifi détectés par la carte wifi et la fréquence des signaux analysés à l'aide du HackRF et mesurer le gain / puissance*



## Modalités pédagogiques

En Binôme, **si vous êtes à l'aise vous pouvez trouver un second binôme pour tester vos attaques et contre-mesures**

## Modalités d'évaluation

* présentation ou livrable

## Livrables

* Document pdf ou markdown avec screenshots

## Critères de performance

* réussite des actions demandées.

## HardWare

* HackRF (Facultatif: antenne directionnelle)

* Carte Wifi (de préference pouvant passer en mode monitor)

* Point d’accès Wifi (votre téléphone par éxemple)

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)