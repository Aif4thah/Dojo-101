# Durcissement de la configuration SSH

Vous êtes chargé de renforcer le niveau de sécurité des serveurs Linux

Durée: 2 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Guides ANSSI](https://cyber.gouv.fr/publications)
* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)


## Contexte

0. Déployer une VM Linux

1. générer des clés reposant sur des courbes elliptiques, la clé privée doit être protégée par mot de passe

2. copier la clé publique sur le serveur **avec les bonnes permissions**

3. s'authentifier avec sa clé 

4. désactiver l'authentification par mot de passe

5. vérifier qu'on ne peut plus s'authentifier par mot de passe

6. vérifier que les succès et erreurs d'authentification soient loggés

7. vérifier que l'accès soit interdit à root

8. Changer le port par défaut


## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

lecture de la procédure

## Livrables

Captures d'écran des commandes `uname -a`, `date`, et résultats des vérifications (Logs et commandes)

Procédure de configuration et de vérification au format markdown

## Critères de performance

Réussite de l'exercice et pertinence de la procédure


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)
