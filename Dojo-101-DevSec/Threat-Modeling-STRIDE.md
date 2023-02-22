# STRIDE

https://docs.microsoft.com/en-us/azure/security/develop/threat-modeling-tool

- Spoofing (usurpation)
- Tampering (falsification)
- Repudiation (répudiation)
- Information Disclosure
- Déni de service
- Élévation de privilège


Catégories de contrôles de sécurité
Chaque catégorie de menaces est associée à un contrôle de sécurité destiné à vous aider à atténuer ou éliminer les risques

## CATÉGORIES DE CONTRÔLES DE SÉCURITÉ

|Catégorie	                       | Contrôle de sécurité	|Description
|----------------------------------|------------------------|----------------
|Spoofing (usurpation)	            |Authentification	    |Vérifie si la partie est bien ce qu’elle |prétend être
|Tampering (falsification)	        |Intégrité	            |Empêche toute modification malveillante des données
|Repudiation (répudiation)	        |Non-répudiation	     |   Les actions sont liées à des utilisateurs
|Divulgation d’informations	        |Confidentialité	      |  Les données sont protégées contre toute divulgation involontaire
|Denial of service (déni de service)|	Disponibilité	       | Le système gère toutes les demandes de manière appropriée
|Élévation de privilège	            |Autorisation	        | L’utilisateur a les autorisations appropriées pour effectuer une demande


## ELEMENTS

- Processus (rond) : Activité qui modifie ou redirige l’entrée vers une sortie
- Entité Externe (carré): Processus, magasin de données ou même applications à part entière en dehors de votre contrôle
- Magasin de données (2 barres horizontales): Stockage de données permanent ou temporaire
- Flux de données (fleches bi-directionnelles): Déplacement de données entre les éléments

## INTERACTION

|Nom	                    	            | Définition
|-------------------------------------------------------
|Processus <-> Processus	                 |Interaction entre un processus et un autre.	Une tâche envoie des données à une tâche, ou en reçoit d’une tâche
|Processus <-> Magasin de données	     | Interaction entre un processus et un magasin de données.	|Une tâche envoie des données à un magasin de données, ou en reçoit d’un magasin de données
|Processus <-> Entité externe	         |Interaction entre un processus et une entité externe.	Une tâche envoie des données à une entité externe, ou en reçoit d’une entité externe
|Flux de données <-> Limite de confiance	| Interaction entre un flux de données et une limite de confiance.	Les données sont transmises d’un environnement fiable à une personne sur Internet (et inversement)


## SPOOFING

### Pour vos données :

* Codes de hachage
* Codes d’authentification des messages
* Signatures numériques

### Pour votre système :

* Authentification des utilisateurs
* Authentification par cookie
* Kerberos
* SSL/TLS
* Certificats
* IPSec
* Paquets signés numériquement

## TAMPERING (falsification)

* Contrôles d’intégrité du système d’exploitation
* Listes de contrôle d’accès (ACL)
* Signatures numériques
* Codes d’authentification des messages

## REPUDIATION

* Authentification renforcée
* Journalisation et supervision sécurisées
* Signatures numériques
* Horodatages sécurisés
* Tiers de confiance

## DIVULGATION

* Chiffrement
* Listes de contrôle d’accès (ACL)

## DENI DE SERVICE

* Listes de contrôle d’accès (ACL)
* Filtrage
* Quotas
* Autorisation
* Haute disponibilité

## ELEVATION DE PRIVS

* Listes de contrôle d’accès (ACL)
* Contrôles d’accès en fonction du rôle (RBAC)
* Accès en fonction du groupe
* Autorisations
* Validation d’entrée

# MODELISATION DES MENACES


|Phase	|Titre	|Description
|-------|--------|------------
|1.	 |Conception	|    Capturer toutes les exigences de votre système et créer un diagramme de flux de données.
|2.	| Détection	    |Appliquer un framework de modélisation des menaces au diagramme de flux de données et trouver des problèmes de sécurité potentiels. (Le STRIDE)
|3.	| Correction	 |   Décider comment aborder chaque problème avec la combinaison de contrôles de sécurité appropriée.
|4.	| Vérification	| Vérifier que les exigences sont satisfaites, que les problèmes sont détectés et que les contrôles de sécurité sont implémentés.