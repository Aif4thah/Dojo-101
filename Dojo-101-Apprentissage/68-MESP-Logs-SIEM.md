# Journalisation (Logs)

Initiation aux solutions SIEM

Poids: 8

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [Guide ANSSI](https://cyber.gouv.fr/publications)

* [Windows Event Forwarding](https://learn.microsoft.com/fr-fr/windows/security/operating-system-security/device-management/use-windows-event-forwarding-to-assist-in-intrusion-detection)

* [Splunk](https://www.splunk.com/fr_fr)

* [ELK](https://www.elastic.co/fr/security)

* [Wazuh](https://wazuh.com/)

* [Wazuh QuickStart](https://documentation.wazuh.com/current/quickstart.html)

* [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp)

* [NLog](https://nlog-project.org/config/)

> [!TIP]
> La liste des SIEM proposée n'est pas exhaustive.

## Contexte


### Benchmark des solutions

0. Comparer les solutions (ex. Splunk et ELK) au travers des critères suivants : Licence, prix, prérequis, OS supportés, facilité de mise en oeuvre (binaires d'installation, Container, etc.)


### Partie centralisation dans un puits de log

Afin de préparer l'arrivée du SIEM dans l'entreprise, vous êtes chargé de mettre en place un puits de logs et de réaliser un POC de la solution SIEM retenue.

1. S'assurer que tous les événements importants pour la sécurité figurent dans les logs (succès et erreur d'authentification, escalade de privilèges, accès aux dossiers sensibles, etc.)

2. Mettre en place ce puits dans une nouvelle machine du Lab, les logs Windows et Linux seront collectés

### Partie intégration des logs système au SIEM

3. Installer en SIEM en local de la machine hébergeant le puits de logs et importer les logs dans le SIEM à l'aide de collecteurs appropriés.

4. À l'aide du langage de requête de votre solution SIEM, trouver les éléments suivants :

    * Escalade de privilège (un simple utilisateur obtient ou lance un processus admin ou root)

    * Échecs d'authentification

    * Succès d'authentification

> [!TIP]
> Si vous avez mis en place le Lab, c'est le moment de rejouer des attaques vu lors des audits de sécurité (Scans de vuln, Mimikatz, Kerberoast etc...)


### Partie intégration des logs applicatifs

5. Étudier le projet VulnérableLightApp et sa journalisation. Une fois les fichiers de logs identifiés, étudier la faisabilité d'intégrer ces Logs au SIEM.

6. Rejouer les exploits vus en pentest puis importer les logs de l'application dans votre SIEM (manuellement, à l'aide d'un script ou d'un collecteur)

7. Rechercher les incidents de sécurité à l'aide du moteur de recherche du SIEM. Catégoriser le type d'attaque et son impact, si elle a réussi.


## Modalités pédagogiques

Seul ou en binôme

## Modalités d'évaluation

Lecture du livrable

## Livrables

* Procédure d'installation du puits de logs et du SIEM.

* Screenshots du SIEM avec les requêtes et les éléments demandés.

## Critères de performance

La réussite du POC avec un SIEM permettant d'analyser les journaux d'événements.

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)