# Audit de sécurité d’un OS Windows en env. AD

Vous êtes chargé d’auditer la configuration d’une machine Windows cliente et de son Serveur Active Directory, vis-à-vis des bonnes pratiques de l'ANSSI et afin de corriger les possibles vulnérabilités

Le rapport d’audit permettra d’identifier les vulnérabilités, leurs criticités ainsi que les préconisations de sécurité conformément au référentiel PASSI (partie exécution de la prestation)

Durée estimée: 6 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Guide ANSSI AD](https://cyber.gouv.fr/publications/recommandations-pour-ladministration-securisee-des-si-reposant-sur-ad)
* [Guides ANSSI](https://cyber.gouv.fr/publications)
* [Referentiel PASSI](https://cyber.gouv.fr/referentiels-dexigences-pour-la-qualification)
* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
* [bloodhound](https://github.com/SpecterOps/BloodHound)
* [Sharphound](https://github.com/BloodHoundAD/SharpHound)
* [PingCastle](https://www.pingcastle.com/)
* [ORAD](https://github.com/ANSSI-FR/ORADAD)
* [Nuclei](https://github.com/projectdiscovery/nuclei)
* [Privesc](https://github.com/carlospolop/PEASS-ng)
* [Privesc bins](https://lolbas-project.github.io/)


## Contexte

Ce contexte est issu du Lab déjà mis en place.

* Vous êtes un auditeur de sécurité pour ABC, une entreprise de 30 salariés spécialisée dans le développement de logiciels. 

* L’entreprise utilise une infrastructure Windows Active Directory (AD) pour gérer les identités et les accès des utilisateurs. 

* L’infrastructure AD est composée d'un seul contrôleur de domaine et d’un serveur Linux non intégré au domaine. 

* L’entreprise a également développé une API REST en interne, qui est utilisée par plusieurs applications corporate. 

Dans le cadre de son programme d'audit, vous serez amené à auditer certains composants du SI.

## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

Relecture par le formateur du rapport d'audit finalisé

## Livrables

* Rapport d'audit répondant aux exigences du référentiel PASSI 

## Critères de performance

Participer à la mesure et à l’analyse du niveau de sécurité de l’infrastructure.

     - Pertinence et preuve des vulnérabilités identifiées
     - Justesse de l’évaluation de la criticité et gravité

Participer à l’élaboration et à la mise en œuvre de la politique de sécurité

     - Pertinence des préconisations

Communiquer par écrit avec les professionnels et les utilisateurs de l’informatique.

    - Synthèse managériale compréhensible pour un personnel non technique
    - détails des vulnérabilités clair et technique
    - Lisibilité globale du document

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)