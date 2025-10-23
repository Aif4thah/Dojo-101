# Configurer le fw sur une machine Windows

Il vous est demandé de configurer le firewall d'un serveur Linux selon les modalités ci-après

Poids: 2

> [!NOTE] 
> Ce contenu est publié sous licence *GNU GENERAL PUBLIC LICENSE Version 3* et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [Mitre Attack](https://attack.mitre.org/)
* [LOLbas](https://lolbas-project.github.io/)
* [nmap](https://nmap.org/)
* [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp)

## Contexte

### Partie 1 : Durcissement OS

1. Déployer une machine Windows

2. Lister les règles firewall grâce à powershell ou la GUI

3. Configurer une politique par défaut "Drop" pour les flux entrants 

4. Supprimer / désactiver les règles inutiles ou trop permissives concernant le trafic entrant

5. à l'aide du MITRE Attack et LOLBas, identifier les binaires qui ne devraient pas pouvoir accéder au réseau et créer des règles "deny" pertinentes concernant les flux sortants (5 minimum)

6. Vérifier à l'aide de l'outil **nmap**, ou d'autres commandes que le firewall fonctionne correctement

7. Désactiver les réponses ICMP et les messages TCP Reset lorsqu'il n'y a pas d'applications sur le port concerné

### Partie 2 : Hébergement d'application

8. Lancer VulnerableLightApp et ouvrir un flux entrant pour HTTPS

9. Configurer le firewall pour réduire le risque de SSRF sur TCP et UDP

10. S'assurer que les IP effectuant des requêtes vers l'application soient dans les journaux d'événements (logs)

## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

lecture de la procédure

## Livrables

captures d’écran des règles firewalls (powershell ou GUI)

Procédure de configuration et de vérification au format markdown

## Critères de performance

Réussite de l'exercice et pertinence de la procédure


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)