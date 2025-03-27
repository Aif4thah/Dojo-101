# Zero Trust et sécurisation d'une machine nomade

Une machine nomade dérogeant à la PSSI doit être sécurisée. Cette situation pousse l'entreprise à adopter un modèle Zero Trust.

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

Poids: 5


### Ressources

* [Guide ANSSI Nomadisme](https://cyber.gouv.fr/publications)

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [Zero Trust](https://cyber.gouv.fr/publications/le-modele-zero-trust)

* [Modèles DAT](https://github.com/bflorat/modele-da)

### Contexte

Depuis le confinement, le dirigeant de l'entreprise ABC - une entreprise de 30 salariés spécialisée dans le développement de logiciels utilise son PC personnel pour accéder aux ressources de l'entreprise. 


* À date, ce matériel n’est pas managé par votre entrepris et n'est pas joint au domaine, vous devez néanmoins durcir la configuration de ce « nouveau poste de travail ».

* Ce matériel doit toujours pouvoir se connecter à n’importe quels réseaux et l’utilisateur insiste fortement pour conserver les droits administrateur.


La société ABC fonctionne actuellement comme suit : 

* L’entreprise utilise une infrastructure Windows Active Directory (AD) et MS365 pour gérer les identités et les accès des utilisateurs.

* L’infrastructure AD est composée d'un seul contrôleur de domaine et d’un serveur Linux non intégré au domaine.

* L’entreprise a également développé une API REST personnalisée qui est utilisée par plusieurs applications internes.


### Modalités pédagogiques

Binôme ou seul (au choix)


### Modalités d'évaluation

0. Prendre le temps de lire les ressources et guides ANSSI.

1. Sélectionner 10 mesures de sécurité liée au contexte. Prenez bien en compte les principaux points du Zero Trust, à savoir :

    * Les Identités
    * Les Devices
    * Les Accès
    * Les Services

2. Implémenter (sur une VM et le Lab) les mesures appropriées.

3. Rédiger un document d'architecture technique (DAT), reprenant le contexte de l'entreprise et conforme aux bonnes pratiques Zero Trust.


### Livrables

1. Un **DAT** minimaliste présentant les mesures adoptées dans le cadre du Zero Trust. 


2. Un **PV de recette** décrivant: 

    * Les mesures de sécurité
    * Les preuves de la bonne implémentation (Screenshot avec commande `date;hostname`)
    * Vos Observations / explications complémentaires si nécessaires


### Critères de performance

* pertinence des mesures de sécurité
* respect du contexte et des cas d'usage
* réalisation des actes techniques
* respect de l'état de l'art et des principes "Zero Trust"


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)
