# Deploiment d'un container Docker

Déploiment de code dans un microservice Docker

Durée: 8 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [vulns-light-apps](https://github.com/Aif4thah/VulnerableLightApp)
* [Docker](https://www.docker.com/)
* [Exemple Kanban](https://www.jetbrains.com/fr-fr/youtrack/)
* [Docker Hub](https://hub.docker.com/)
* [Terraform](https://www.terraform.io/)



## Contexte

Vous faites partie de la purple team de l'entreprise. Afin de former les équipes du SOC à la détection des attaques, il vous est demandé de déployer vuln-light-apps dans un microservice docker.

Ce container sera ensuite utilisé par les équipes afin de mener leurs tests.


## Modalités pédagogiques

1. Installer Docker

2. Vérifier que docker fonctionne (container Hello World)

3. Prendre connaissance du projet Vulnerable-light-App

4. Planifier dans un KanBan comment va se faire la mise en container de l'application.

    * Passer en revue les étapes suivantes et créer une liste de tâche (story).

    * Mettez un poid ou une difficulté (chiffre entier) sur chaque story.

    * Attribuez vous les stories au sein du groupe.

    * Utilser les colonnes "à venir", "en cours", "en test", "terminé" pour suivre l'avancement du Brief

5. Créer un docker file

6. Automatiser l'installation et le lancement de vuln-light-apps

7. Pousser votre travail sur un repo github

8. Les tests de build doivent se faire automatiquement lors du push sur GitHub

9. Mettre à disposition votre container (Docker Hub / Registry)

10. Pour aller plus loin : réaliser un déploiement à l'aide de Terraform

## Modalités d'évaluation

Test du container depuis une machine Linux


## Livrables

un projet Github / Groupe


## Critères de performance

La commande `docker run <container> -p 3000:3000` fonctionne.


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)
