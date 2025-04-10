# Mettre en prod une solution réseau

Étudier et mettre en production une solution appropriée 

Poids: 5

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources


[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[Guide ANSSI TLS: anssi-guide-recommandations_de_securite_relatives_a_tls-v1.2](https://cyber.gouv.fr/publications)
[Guide ANSSI sur l'OS ou la solution choisie](https://cyber.gouv.fr/)
[Markdown](https://www.markdownguide.org/)


## Contexte

Notre startup a récemment commencée à travailler avec des clients internationaux. Nous avons besoin d’un moyen sécurisé pour accéder à nos ressources internes depuis l’extérieur de notre réseau. Nous comptons sur vous.


## Modalités pédagogiques

* Techno au choix:

* Firewall:
     - Linux 
     - Cisco

* VPN (client - serveur):
     - Wiregard
     - OpenVPN

LAN: 10.0.0.0/24
WAN : 192.168.1.0/24


## Modalités d'évaluation

Lecture du livrable

## Livrables

Documenter au format `markdown` ou `scripter` la mise en place et l'hardening (Authentification, permissions, Suites de chiffrement crypto)
de la solution retenue 

## Critères de performance

* La concision

* la clarté (du script ou de la doc .md)

* l'effort fait sur le durcissement par rapport la configuration par défaut, par exemple : interdire les suites de chiffrement obsolète.

* Scanner votre service à l'aide d'un outil tel que Nmap NSE ou vpnscan est inclure le  résultat au fichier md ou en commentaire du script

# Hardware

Matériel CISCO à disposition

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)