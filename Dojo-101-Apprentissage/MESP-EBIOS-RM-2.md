# Réaliser une analyse de risque EBIOS RM

Vous devez mener une AdR EBIOS RM d'un projet infra commandé par la MOA

Durée: 4 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

[Guide EBIOS RM](https://cyber.gouv.fr/publications/la-methode-ebios-risk-manager-le-guide)
[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[Mitre Attack](https://attack.mitre.org/)


## Contexte

L'entreprise cliente fabrique des masques et des tests PCR:

* Travail en heure ouvrée 7h-19h
* 2 sites physiques
* 40 employés 
* Services: Ressources, Humaines, Comptabilité, Développement, Informatique, SAV, Marketing, Direction, Logistique, Production (4 personnes / service)
* Basé en France
* Travail en distanciel lorsque possible, via VPN
* un réseau WAN qui relie les 2, les connexions VPN entrantes ainsi qu'un serveur de fichiers
* Protocoles RZO / Système: DHCP,TFTP,OSPF,NAT

Une refonte de l'infrastructure est en cours:

    Site 1:
        6 VLAN Bureautique pour les services
        1 VLAN pour la téléphonie
    Site 2:
        1 Subnet avec machines bureautiques et serveurs
        1 Réseau WAN reliant les 2 sites et permettant le travail à distance


L’entreprise a également été victime d’une cyberattaque par ransomware il y a quelques mois. Les pirates informatiques ont réussi à pénétrer dans le système informatique de l’entreprise et ont chiffré les fichiers de l’entreprise. Les pirates ont ensuite demandé une rançon pour déchiffrer les fichiers, mais l'entreprise a refusé de payer la rançon et a plutôt engagé une équipe d’experts en cybersécurité pour récupérer les fichiers. L’équipe cyber a réussi à récupérer les fichiers sans payer la rançon, mais l’incident a eu un impact significatif sur les opérations de l’entreprise. 

Suite à cet évènement, il vous est demandé en tant que prestataire, de réaliser une AdR EBIOS RM qui prendra en compte la refonte de l'infrastructure.


## Modalités pédagogiques

Groupe de 4 Personnes

## Modalités d'évaluation

Lecture du rapport et présentation à l'oral

## Livrables

* les couples SR/OV (tableau)
* Les scénarii stratégiques (schémas)
* un plan de traitement du risque (bruts -> résiduels) comportant à minima 5 scénarii de risques et 5 mesures de sécurité

## Critères de performance

- respect de la méthode EBIOS RM
- Formalisme et synthétisme
- Pertinence de risques identifiés
- Pertinence des mesures de sécurité retenues


## Pour finir

Si vous avez apprécié ce cours, n'hésitez pas à ajoutez une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)