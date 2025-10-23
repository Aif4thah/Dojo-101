# Déploiement d'un container Docker

Déploiement de code dans un microservice Docker

Poids: 4

> [!NOTE]
> Ce contenu est publié sous licence *GNU GENERAL PUBLIC LICENSE Version 3* et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp)
* [Docker](https://www.docker.com/)
* [Exemple Kanban](https://www.jetbrains.com/fr-fr/youtrack/)
* [Docker Hub](https://hub.docker.com/)
* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-relatives-au-deploiement-de-conteneurs-docker)
* [Terraform](https://www.terraform.io/)
* [Trivy](https://trivy.dev/latest/)

## Contexte

Vous faites partie de la PURPLE team de l'entreprise. Afin de former les équipes du SOC à la détection des attaques, il vous est demandé de déployer le projet "vulnerablelightapp" dans un environnement de test docker.

Ce container sera ensuite utilisé par les équipes RED et BLUE afin de mener des tests de détection d'attaques Web.

## Modalités pédagogiques

1. Installer Docker.

2. Vérifier que docker fonctionne en lançant le container **Hello World**.

3. Prendre connaissance du projet Vulnerable-light-App, lire son `Dockerfile` et le workflow `Docker.yml`. Executer le `Dockerfile` en local sur vôtre machine.

4. Reprendre le `dockerfile` et/ou la commande `docker run` pour que l'application se lance sur le **port TCP 443**, avec un **volume partagé** qui permettra le partage de fichiers entre le container et l'hôte.

5. Vérifier que votre `Dockerfile` modifié fonctionne : vous pouvez envoyer vos requêtes à l'application et partager un fichier via le partage de volume.

6. Utiliser le **volume partagé** avec l'hôte afin d'y **stocker les journeaux d'évenements**, le but est de conserver les logs même une fois le container détruit. le chemin des logs se modifie via le fichier de configuration `nlog.config` de l'application.

7. Pousser votre travail sur un **repo github**.

8. Les tests de build doivent se faire automatiquement lors du push sur GitHub via les **canaux CI/CD**.

9. Optionel : Mettre à disposition votre container (Docker Hub / Registry).

10. Appliquer les bonnes pratiques de sécurité issues du **Guide docker ANSSI** (container uniquement, pas de sécurisation du code).

11. Afficher les **métriques** et relever la consomation des containers.

12. Pour aller plus loin, réaliser le déploiement de 2 containers à l'aide d'un **Docker-compose** ou de **Terraform** : le premier pour *VulnerableLightApp*, le second pour *parser une copie des logs* manuellement à l'aide d'une connexion SSH et de la commande `jq`.

## Modalités d'évaluation

* Test du ou des container(s) depuis une machine Linux

* Relecture des preuves de bonnes pratique de sécurité

## Livrables

* un projet Github / Groupe, le repos doit contenir les Push/Merge/Pull Request de chaque utilisateur du groupe.

* Preuves de l'application des bonnes pratiques de sécurité et de la présence des logs applicatifs sur l'hôte.

## Critères de performance

* La commande `docker run <container> -p x:x`, `docker build` ou `docker compose up` fonctionne.

* Les mesures de sécurité sont appliquées

* Les logs applicatif sont bien sur le volume partagé.

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)
