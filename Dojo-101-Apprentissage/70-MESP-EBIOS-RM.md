# Réaliser une analyse de risque EBIOS RM

Vous êtes le RSSI d'une Startup et vous devez mener une AdR EBIOS RM.

Poids: 4

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Guide EBIOS RM](https://cyber.gouv.fr/publications/la-methode-ebios-risk-manager-le-guide)

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [Mitre Attack](https://attack.mitre.org/)

* [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp)

## Contexte

Vous êtes RSSI (Responsable de la sécurité des Systèmes d'information) pour ABC, une entreprise de 30 salariés spécialisée dans le développement de logiciels. 

* L’entreprise utilise une infrastructure Windows Active Directory (AD) pour gérer les identités et les accès des utilisateurs.

* L’infrastructure AD est composée d'un seul contrôleur de domaine et d’un serveur Linux non intégré au domaine.

* L’entreprise a également développé une API REST interne qui est utilisée par plusieurs applications front (cf. README du projet).

Note: *Le périmètre technique est celui du Lab*

L'entreprise est soumise aux réglementations suivantes :

* La loi française

* Le RGPD

* la PSSI qui précise que :

    * l'intégrité et la confidentialité des données métiers doit être une priorité

    * les mots de passe de l'entreprise doivent être robustes

    * les utilisateurs doivent être sensibilisés tous les ans à la cybersécurité

    * l'Analyse de risque devra être mise à jour tous les ans.

L'entreprise s'appuie sur les réferentiels suivants : 

* L'OWASP ASVS v4 - Traduction Française

* Les guides ANSSI

Les fournisseurs de l'entreprise sont des entreprises taiwanaises. Ses clients sont Français.


En tant que responsable de la gestion des risques, vous avez pour mission de mener une analyse EBIOS RM afin d'établir un premier plan de traitement des risques.

L'obtention de ce plan de traitement des risques devra permettre :

* d'obtenir la certification 27001 de l'entreprise

* de prévenir ou d'atténuer une fuite ou une perte des données, en particulier les données métiers et personnelles

Afin de mener cette analyse:

* Le périmètre et les éléments à prendre en compte pour l'Atelier 1 se limiteront aux éléments énumérés ci-dessus, afin que vous puissiez passer rapidement à l'atelier 2.

* Vous trouverez les échelles page 26 (diapositive 15) de la méthode EBIOS RISK MANAGER


## Modalités pédagogiques

Groupe de 4 Personnes

## Modalités d'évaluation

Lecture du rapport et/ou présentation à l'oral

## Livrables

* les évenements redoutés (tableau)

* les couples SR/OV (tableau)

* Les scénarii stratégiques (schémas + tableau)

* les scénarii opérationels (schémas + tableau)

* un plan de traitement du risque (bruts + résiduels) comportant à minima 5 scénarii de risques et 5 mesures de sécurité


## Critères de performance

* respect de la méthode EBIOS RM

* Formalisme et synthétisme

* Pertinence de risques identifiés

* Pertinence des mesures de sécurité retenues


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)