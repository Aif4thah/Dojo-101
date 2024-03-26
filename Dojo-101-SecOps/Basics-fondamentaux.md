# Fondamentaux SSI - Basics

## Notions SSI

* **système d’information** :  ensemble organisé de ressources (matériel, logiciels, personnel, données et procédures) permettant de traiter et de diffuser de l’information.

* **Sécurité d’un système d’information** - ensemble des moyens techniques et non techniques de protection, permettant à un système d’information de résister à des événements susceptibles de compromettre la disponibilité, l’intégrité ou la confidentialité des données, traitées ou transmises et des services connexes que ces systèmes offrent ou rendent accessibles.

* **Actifs** (Assets) : tout ce qui à de la valeur au sein du SI

# DICP ("CIA triad" en anglais)

* **Disponibilité** : ***que les données soient bien accessibles***

* **Intégrité** : Garantie que le système et l’information traitée ne sont modifiés que par une action volontaire et légitime. ***que les données n'ont pas été altérées ou modifiées***

* **Confidentialité** : Propriété d’une information qui n’est ni disponible, ni divulguée aux personnes, entités ou processus non autorisés. ***accessibles aux seules personnes autorisées***

* **Preuve**, Tracabililité, Non-répudiation

* **Authentitication** : L’authentification a pour but de vérifier l’identité dont une entité se réclame. ***La personne est bien celle qu'elle prétend être.***



# Notions de Risque

* **Vulnérabilité** : Faute, par malveillance ou maladresse, dans les spécifications, la conception, la réalisation, l’installation ou la configuration d’un système, ou dans la façon de l’utiliser. 
* **Remarques** : Une vulnérabilité peut être utilisée par un code d’exploitation et conduire à une intrusion dans le système. (faiblesse sur le SI)
* **Risque** = Menace * Vulnérabilité * Impact = Impact * Vraissemblance

## Traitement du risque

* écarter
* atténuer (mitigate)
* transférer
* accepter

## Cadre juridique

* articles 323-1 et suivants : Le fait d'accéder ou de se maintenir, frauduleusement, dans tout ou partie d'un système de traitement automatisé de données est puni de trois ans d'emprisonnement et de 100 000 € d'amende.

* RGPD -> données personnelles : Une donnée personnelle est toute information se rapportant à une personne physique identifiée ou identifiable. ex:  Nom, numéro de téléphone ou de plaque d’immatriculation, un identifiant tel que le numéro de sécurité sociale, une adresse postale ou courriel, mais aussi la voix ou l’image. ou croisement de données: une femme vivant à telle adresse, née tel jour et membre dans telle association

## Définitions

* PSSI : Politique SSI
* SMSI : Système de management de la Sécurité de l'information (ISO27001)
* SOC : Security operation center, utilise un SIEM pour la supervision de la sécurité.
* AdR : Analyse de risque

## Normes et cadre règlementaire

* LPM : Loi de programmation militaire (OIV)
* NIS : Network Information Security (OSE)
* RGPD : Données personnelles
* PCI : bancaire (payement)
* HDS : Données de Santé
* ISO2700X : normes SMSI
* RGS : Administration
* DORA : entités financières

## La documentation en entreprise (concept anglo-saxon)

### Mandatory 

* Policies : General Management statement
* Standards : Specific Mandatory Controls
* Procedures : Step By Step Instructions

### Discretionary

* Guidelines : Best Practices / Recommendations
* Baselines : Minimal implementation

## Vulnérabilités

* N° CVE : identifiant unique pour une vuln. base [Nist NVD](https://nvd.nist.gov/vuln)
* Score CVSS : évaluation d'une vulnérabilité [First Calculator](https://www.first.org/cvss/)
* Reference CWE : mauvaise pratique [MITRE CWE](https://cwe.mitre.org/)
* Score EPSS : Exploit Prediction Scoring System

### Lister les dernières CVE avec cvemap

[cvemap](https://github.com/projectdiscovery/cvemap)
[API KEY](https://cloud.projectdiscovery.io/?ref=api_key)
```powershell
.\cvemap.exe -auth
.\cvemap.exe -l 100
```

## Référentiels et bonnes pratiques

* [ANSSI](https://cyber.gouv.fr/)
