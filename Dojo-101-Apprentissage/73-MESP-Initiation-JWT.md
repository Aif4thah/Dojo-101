# Découverte de l'authentification par Token JWT (JSON Web Token)

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Durée: 1 jour

En tant que consultant cybersécurité, votre expertise est requise quant au choix et à la bonne implémentation des technologies Infra/Web

## Ressources

[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[JWT.IO](https://jwt.io/)

## Contexte

La société Azerty propose une gamme de radiateurs connectés. Jusqu’à présent des techniciens se déplacent chez leurs clients pour assurer le SAV. Afin d’améliorer la qualité de son service, la société lance le projet d’une application cloud, appelée « Azerty-manager » permettant aux techniciens de diagnostiquer et télécommander l’ensemble des équipements vendus aux particuliers.

Azerty-manager utilisera des jetons JWT pour l’authentification et le suivi des sessions. Chaque token contient :

* le nom de l’utilisateur ainsi que son rôle (admin ou user), 
* Une date d’expiration
* la signature permettant de vérifier l’intégrité du token (HMAC-SHA256)

Par exemple : `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoibWljaGFlbCIsImFkbWluIjoiVHJ1ZSIsImlhdCI6MTUxNjIzOTAyMn0.t69vaPQY82J0LnzhOSdhP1DZsA1HchQMNzTKalD2354`

0. De quels éléments est constitué le token ? 

1. Quelle fonction remplit le Token JWT ?

2. Quels éléments du token doit-on protéger ?

3. Quels impacts si un token est volé par un attaquant ?

4. Comment délivrer un token à un utilisateur valide ? (hint: Oauth)

5. Quels sont les risques liés au choix et à l’implémentation de cette technologie ?

6. Quelles recommandations adresseriez-vous au projet pour traiter vos risques ? Pour chacune des recommandations, précisez:

* Nom
* Description
* Risque associé
* Délai d'implémentation
* *A quoi ça sert ?*
* *Limites / risque résiduel*
* Les références (documentation, guide ANSSI, standard, RFC...)


## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

Lecture des livrables

## Livrables

* Réponse aux requestions
* Tableau de recommandations (10)

## Critères de performance

Pertinence des réponses et des recommandations

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)