# Réaliser une analyse de risque EBIOS RM

Vous êtes le RSSI d'une Startup et vous devez mener une AdR EBIOS RM.

Durée: 4 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

[Guide EBIOS RM](https://cyber.gouv.fr/publications/la-methode-ebios-risk-manager-le-guide)
[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[Mitre Attack](https://attack.mitre.org/)


## Contexte

Vous êtes le RSSI d'une Startup de 6 personnes spécialisée dans l'obtention de la certification ISO27001 pour ses clients.

Le système d'information se compose de:

* 4 machines nomades pour les consultants, basés à Paris et mobiles dans toute la France
* 2 Postes fixes pour le directeur et le responsable RH, basés à Aix-en-Provence
* 1 Application cloud fournissant aux clients tous les éléments concernant le suivi de l'avancement de leurs certifications ainsi que le détail des analyses de risques menées par les consultants

Chaque utilisateur utilise le service VPN de sont choix. L'application cloud est exposée sur internet, protégée par un WAF et une authentification par login + mot de passe (les comptes sont dans la BDD de l'application). 

En tant que responsable de la gestion des risques, vous avez pour mission de mener une analyse EBIOS RM afin d'établir un premier plan de traitement des risques.

L'obtention de ce plan de traitement des risques permettra:

* de maintenir la conformité à la certification 27001 de l'entreprise
* de prévenir ou d'atténuer une fuite ou une perte des données, en particulier les données des clients

Afin de mener cette analyse:

* Le périmètre et les éléments à prendre en compte pour l'Atelier 1 se limiteront aux éléments énumérés ci-dessus afin que vous puissiez passer rapidement à l'atelier 2.

* Les scénarii opérationnels (Atelier 4) ne seront pas mis en oeuvre. L'examen porte sur vos connaissances générales en cybersécurité, des détails techniques peuvent être apportés, mais ne sont aucunement nécessaires.

* Vous trouverez les échelles page 26 (diapositive 15) de la méthode EBIOS RISK MANAGER

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
