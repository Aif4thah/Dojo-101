# Audit de sécurité d’un OS Windows en env. AD

Vous êtes chargé d’auditer la configuration d’une machine Windows. Le rapport d’audit permettra d’identifier les vulnérabilités, leurs criticités ainsi que les préconisations de sécurité conformément au référentiels PASSI (partie exécution de la prestation)

Durée estimée: 5 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Guide ANSSI AD](https://cyber.gouv.fr/publications/recommandations-pour-ladministration-securisee-des-si-reposant-sur-ad)
* [Guide CIS](https://github.com/cismirror/old-benchmarks-archive)
* [Guides ANSSI](https://www.ssi.gouv.fr/administration/bonnes-pratiques/)
* [Referentiel PASSI](https://www.ssi.gouv.fr/actualite/publication-du-referentiel-dexigences-applicable-aux-prestataires-daudit-de-la-securite-des-systemes-dinformation-passi/)
* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [bloodhound](https://github.com/BloodHoundAD/BloodHound)
* [Sharphound](https://github.com/BloodHoundAD/SharpHound)
* [PingCastle](https://www.pingcastle.com/)
* [Nuclei](https://github.com/projectdiscovery/nuclei)
* [Privesc](https://github.com/carlospolop/PEASS-ng)


## Contexte

Vous êtes un auditeur de sécurité pour une entreprise de développement de logiciels. L’entreprise utilise une infrastructure Windows Active Directory (AD) pour gérer les identités et les accès des utilisateurs. L’infrastructure AD est composée de deux contrôleurs de domaine et d’un serveur membre Linux intégré au domaine. L’entreprise a également développé une API REST personnalisée qui est utilisée par plusieurs applications internes. Votre tâche consiste à auditer la sécurité de l’infrastructure AD, du serveur Linux et de l’API REST pour identifier les vulnérabilités et les risques potentiels.

Methodologie: Referentiel PASSI

Referentiel d'audit: CIS

Gestes professionnels: https://github.com/Aif4thah/Dojo-101

## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

Relecture par le formateur du rapport d'audit finalisé

## Livrables

* Diagramme de Gant ou Kanban détaillant la méthodologie que vous allez appliquer
* Sorties de tous les outils cités en Ressources
* Rapport d'audit répondant aux exigences du référentiel PASSI 

## Critères de performance

Mesurer et analyser le niveau de sécurité de l’infrastructure.

     - Pertinence des vulnérabilités identifiées
     - Justesse de l’évaluation de la criticité et gravité

Participer à l’élaboration et à la mise en œuvre de la politique de sécurité

     - Pertinence des préconisations

Communiquer par écrit avec les professionnels et les utilisateurs de l’informatique.

    - Synthèse managériale compréhensible pour un personnel non technique
    - détails des vulnérabilités clair et technique
    - Lisibilité globale du document