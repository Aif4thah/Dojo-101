# Déploiement d'un container Docker

Déploiement de code dans un microservice Docker

Durée: 5 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.


## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp)
* [Docker](https://www.docker.com/)
* [Exemple Kanban](https://www.jetbrains.com/fr-fr/youtrack/)
* [Docker Hub](https://hub.docker.com/)
* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-relatives-au-deploiement-de-conteneurs-docker)
* [Terraform](https://www.terraform.io/)


## Contexte

Vous faites partie de la PURPLE team de l'entreprise. Afin de former les équipes du SOC à la détection des attaques, il vous est demandé de déployer le projet "vulnerablelightapp" dans un environnement de test docker. 

Ce container sera ensuite utilisé par les équipes RED et BLUE afin de mener des tests de détection d'attaques Web.


## Modalités pédagogiques

1. Installer Docker

2. Vérifier que docker fonctionne (container **Hello World**)

3. Prendre connaissance du projet Vulnerable-light-App, lire son `Dockerfile`.

4. Créer un nouveau dockerfile pour que l'application se lance sur le **port TCP 433**, avec un volume partagé avec la machine hôte

5. Automatiser l'installation et le lancement de cette API grâce au `Dockerfile`.

6. Utiliser le volume partagé avec l'hôte afin d'y stocker les **journeaux d'évenements**, le but est de conserver les logs même une fois le container détruit.

7. Pousser votre travail sur un **repo github**.

8. Les tests de build doivent se faire automatiquement lors du push sur GitHub via les **canaux CI/CD**.

9. Optionel : Mettre à disposition votre container (Docker Hub / Registry)

10. Appliquer les bonnes pratiques de sécurité issues du **Guide docker ANSSI** (container uniquement, pas de sécurisation du code)

11. Afficher les **métriques** et relever la consomation des containers

12. Optionel : Pour aller plus loin, réaliser le déploiement de 2 containers à l'aide de **Terraform**

    * 1 pour l'API Web

    * 1 pour lire et afficher les logs


## Modalités d'évaluation

* Test du container depuis une machine Linux

* Relecture des preuves de bonnes pratique de sécurité


## Livrables

* un projet Github / Groupe, le repos doit contenir les Push/Merge/Pull Request de chaque utilisateur du groupe.

* Preuves de l'application des bonnes pratiques de sécurité et de la présence des logs applicatifs sur l'hôte.


## Critères de performance

* La commande `docker run <container> -p x:x`, `docker build` ou `docker compose up` fonctionne.

* Les mesures de sécurité sont appliquées


## Pour finir


Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)

