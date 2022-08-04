# Méthodologie pour une revue de sécurité Applicative

## References:

* [ASVS version 4.0](https://github.com/OWASP/ASVS/tree/master/4.0/fr)
* [Methode SIMPLE](./README.md)

## Synthèse

L'Application Security Verification Standard (ASVS) de l'OWASP est une liste d'exigences et de contrôles de sécurité servant de référentiel à la fois pour les équipes sécurité et les projets.

Cette méthodologie prend en compte les limites d'exhaustivité de l'audit et propose une batterie de tests permettant d'optimiser le ratio "durée des tests / couverture du référentiel".

Lorsque les conditions sont optimales, c'est-à-dire lorsque le DAT est complet, que les accès sont transmis à temps et que les outils sont correctement configurés, il devrait être possible de couvrir 70% des contrôles applicables de l'ASVS dans un délai de 10 à 20 jours.


## Revue de code et tests de type "Static Application Security Testing" (SAST)

### Objectif

- Vérification des bonnes pratiques de développement sécurisé
- Identification des vulnérabilités liées à l'utilisation de composant vulnérable
- Identification de vulnérabilité potentiellement non testable lors des tests dynamiques

### Limites

- L'audit de code et les tests statiques à eux seuls ne peuvent détecter l'ensemble des vulnérabilités

### Prérequis

- Accès au DAT
- Accès au Code Source 
- Accès aux binaires/bytecode

### Outils

Outils de revue de code et d'analyse des dépendances

### Méthode

0. Recherche de vulnérabilités liées au design (DAT)
1. Recherche de vulnérabilités dans les dépendances du projet
2. Recherche de vulnérabilités dans le code source de l'application (à minima les règle OWASP Top 10 et SANS Top 25 (CWE) présente par défaut dans SonarQube)
3. Revue manuelle des "security hostspots" (sonarQube et Regex)

### Points contrôlés par la méthode

Points contrôlés théoriquement lorsque l'environnent de test et les outils en place le permettent:

- V1.2 Exigences architecturales d'authentification (4)
- V1.12 Téléchargement de fichiers sécurisés Exigences architecturales (2)
- V2.3 Exigences relatives au cycle de vie des authentificateurs (SAST + DAST) (3)
- V2.4 Exigences en matière de stockage des identifiants (5)
- V2.9 Exigences relatives aux vérificateurs de logiciels et d'appareils cryptographiques (3)
- V5.1 Exigences de validation des entrées (5)
- V5.3 Exigences en matière d'encodage de sortie et de prévention des injections (SAST + DAST) (10)
- V5.4 Exigences en matière de mémoire, de chaînes de caractères et de code non géré (SAST + DAST) (3)
- V5.5 Exigences de prévention de la désérialisation (4)
- V6.2 Algorithmes (Cryptographisque) (SAST + DAST) (8)
- V6.3 Valeurs aléatoires (SAST + DAST) (3)
- V6.4 Gestion du secret (2)
- V9.2 Exigences de sécurité des communications du serveur (5)
- V12.1 Exigences pour le téléchargement de fichiers (SAST + DAST) (3)
- V12.2 Exigences en matière d'intégrité des fichiers (SAST + DAST) (1)
- V12.4 Exigences en matière de stockage des fichiers (2)
- V12.5 Exigences de téléchargement des fichiers (SAST + DAST) (2)
- V12.6 Exigences de protection des SSRF (1)
- V13.2 Exigences de vérification pour les services web de type RESTful (SAST + DAST) (6)
- V13.3 Exigences de vérification du service web SOAP (SAST + DAST) (2)
- V13.4 GraphQL et autres exigences de sécurité de la couche de données des services Web (SAST + DAST) (2)
- V14.2 Exigences sur les dépendances (6)

(82)

-----

## Test d'intrusion et tests de type "Dynamic Application Security Testing" (DAST)

### Objectif

- Vérification de l'exploitabilité et de l'impact des vulnérabilités
- Découvertes de vulnérabilités non couvertes par les tests SAST
- Vérification des worklows complexes grâce à des tests manuels

### Limites

- Un test d’intrusion seul n’a pas vocation à être exhaustif. Il s’agit d’une activité qui doit être effectuée en complément d’autres activités d’audit afin d’en améliorer l’efficacité ou de démontrer la faisabilité de l’exploitation des failles et vulnérabilités découvertes à des fins de sensibilisation.


### Prérequis

- Accès au DAT (architecture middleware)
- Accès à l'application en préproduction (avec un compte utilisateur et/ou admin si nécessaire)

### Outils

Outils de scan, de fuzzing et de tests d'intrusion

### Méthode

0. Scan de vulnérabilité sur les services exposés (dont TLS et Headers)
1. Recherche de vulnérabilités liées à l'authentification, aux autorisations et à la gestion des sessions
2. Recherche de vulnérabilités liées aux workflows (tests manuels)
3. Recherche de vulnérabilités liées à la validation des saisies utilisateurs (Fuzzing)

### Points contrôlés par la méthode

Points contrôlés théoriquement lorsque l'environnent de test et les outils en place le permettent:

- V2.3 Exigences relatives au cycle de vie des authentificateurs (SAST + DAST) (3)
- V2.5 Exigences en matière de récupération des identifiants (7)
- V2.8 Exigences relatives aux vérificateurs uniques à facteur unique ou à facteurs multiples (7)
- V2.10 Exigences d'authentification des services (4)
- V3.1 Exigences fondamentales en matière de gestion des sessions (1)
- V3.2 Exigences contraignantes de la session (4)
- V3.3 Exigences en matière de déconnexion et de temporisation des sessions (4)
- V3.4 Gestion de session basée sur les cookies (5)
- V3.5 Gestion de session à jetons (3)
- V4.1 Conception générale du contrôle d'accès (5)
- V4.2 Contrôle d'accès au niveau des opérations (2)
- V4.3 Autres considérations relatives au contrôle d'accès (3)
- V5.2 Exigences en matière d'assainissement et de « bac à sable » (8)
- V5.3 Exigences en matière d'encodage de sortie et de prévention des injections (SAST + DAST) (10)
- V5.4 Exigences en matière de mémoire, de chaînes de caractères et de code non géré (SAST + DAST) (3)
- V6.2 Algorithmes (Cryptographisque) (SAST + DAST) (8)
- V6.3 Valeurs aléatoires (SAST + DAST) (3)
- V7.4 Traitement des erreurs (3)
- V8.2 Protection des données côté client (3)
- V9.1 Exigences de sécurité des communications des clients (3)
- V11.1 Exigences de sécurité de la logique d'entreprise (8)
- V12.1 Exigences pour le téléchargement de fichiers (SAST + DAST) (3)
- V12.2 Exigences en matière d'intégrité des fichiers (SAST + DAST) (1)
- V12.3 Exigences relatives à l'exécution des fichiers (partiel selon le niveau de complexité de l'application) (6)
- V12.5 Exigences de téléchargement des fichiers (SAST + DAST) (2)
- V13.1 Exigences génériques de vérification de la sécurité des services web (5)
- V13.2 Exigences de vérification pour les services web de type RESTful (SAST + DAST) (6)
- V13.3 Exigences de vérification du service web SOAP (SAST + DAST) (2)
- V13.4 GraphQL et autres exigences de sécurité de la couche de données des services Web (SAST + DAST) (2)
- V14.4 Exigences relatives aux en-têtes de sécurité HTTP (7)
- V14.5 Exigences sur la validation des en-têtes de requête HTTP (4)

(135)

## Couverture du référentiel 

## Information sur les tests non couverts

Sur les 286 contrôles de l'ASVS:

- V1.1 Exigences relatives au cycle de vie du développement de logiciels sécurisés (8)
- V1.4 Exigences architecturales en matière de contrôle d'accès (6)
- V1.5 Exigences architecturales d'entrée et de sortie (4)
- V1.6 Exigences en matière d'architecture cryptographique (4)
- V1.7 Erreurs, enregistrement et vérification des exigences architecturales (2)
- V1.8 Exigences architecturales en matière de protection des données et de la vie privée (2)
- V1.9 Exigences en matière d'architecture des communications (2)
- V1.10 Exigences en matière d'architecture des logiciels malveillants (1)
- V1.11 Exigences en matière d'architecture de la logique d'entreprise (3)
- V1.14 Configuration des exigences architecturales (7)
- V6.1 Classification des données (3)
- V7.1 Exigences relatives au contenu des journaux (4)
- V7.2 Exigences de traitement des journaux (2)
- V7.3 Exigences en matière de protection des journaux (4)
- V8.1 Protection générale des données (6)
- V8.3 Données privées sensibles (8)
- V10 : Exigences de vérification des codes malveillants (10)
- V14.1 Exigences sur les constructions (5)

(81)


### calcul de la couverture SAST:

82 / 286 * 100 = 29%

### calcul de la couverture DAST:

135 / 286 * 100 = 47%

### calcul de la couverture globale:

( 82 + 135 - 11 ) / 286 * 100 = 72 %
