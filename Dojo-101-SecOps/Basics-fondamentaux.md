<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Les fondamentaux de la cybersécurité

* Sensibilisation proposée par [Taisen-Solutions](https://taisen.fr)

* Support sous [License: GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0)

* Ce contenu fait partie des `Basics` du projet [DOJO-101](https://github.com/Aif4thah/Dojo-101/)


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Introduction

Les pertes mondiales imputables aux attaques informatiques dépassent les **1000 milliards/an** de dollars depuis 2020, ce qui représente plus de **1% du PIB mondial**

Depuis ce chiffre est en constante augmentation...

Les enjeux ne sont pas seulement financiers : les emplois, l’image et la stabilité de l’entreprise dépendent de la sécurité de ses actifs.

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Les attaques les plus courantes:

* Usurpation d'identité
* Vol de données
* Chiffrement par ransomware
* Deni de services


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



## Notions SSI

* **système d’information** :  ensemble organisé de ressources (matériel, logiciels, personnel, données et procédures) permettant de traiter et de diffuser de l’information.

* **Sécurité d’un système d’information** - ensemble des moyens techniques et non techniques de protection, permettant à un système d’information de résister à des événements susceptibles de compromettre la disponibilité, l’intégrité ou la confidentialité des données, traitées ou transmises et des services connexes que ces systèmes offrent ou rendent accessibles.

* **Actifs** (Assets) : tout ce qui a de la valeur au sein du SI


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## La surface d'attaque

Tout ce que vous exposez à vos adversaire

* L'architecture
* Les serveurs
* Les services
* Les Applications
* l'Humain


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Les attaquants

### Les profils

* White Hat / Ethical Hacker : respecte le cadre légal (Pentest, Red Team, Bug Bounty, Divulgation responsable)
* Black Hat : intention de nuire ou de gagner de l'argent
* Grey Hat : Parfois éthique, parfois non...
* Script Kiddies : Peu de connaissance, mais utilisation d'outils "clé en main"

### Moyens x Ciblage

 | Compétences | ciblage | type d'attaque |
 |-------------|---------|----------------|
 | 0 | 0 | Spam |
 | 1 | 0 | attaques opportunistes |
 | 1 | 1 | attaques étatiques ou state sponsored |

### Motivation

* **Gain** : monétisation des informations et/ou déni de service
* **Hacktivisme** : communication, idéologie
* **Concurrence** : nuire à ses adversaires
* **Intérêts étatiques et mercenariat** : espionnage et enjeux régaliens


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Les vulnérabilités

Faiblesses au sein du système d'information

[CERT-FR](https://www.cert.ssi.gouv.fr/)

* N° CVE : identifiant unique pour une vuln. base [Nist NVD](https://www.cve.org/)
* Score CVSS : évaluation d'une vulnérabilité [First Calculator](https://www.first.org/cvss/)
* Reference CWE : mauvaise pratique [MITRE CWE](https://cwe.mitre.org/)
* Score EPSS : Exploit Prediction Scoring System [First EPSS](https://www.first.org/epss/user-guide)



<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Pourquoi y a t-il autant de vulns ?

Ce qu’on veut faire faire :

```txt
«  Pour aller à la gare : aller toujours tout droit, dès que vous voyez un panneau vert : tourner à droite et vous êtes arrivé »
```

Ce qu'on code : 

```python
def AllerGare():
    Arrivé = False
    while not Arrivé:
        ToutDroit()
        if Regarder() == 'vert':
            TournerDroite()
            Arrivé = True
    return 0
```

Ce que la machine execute :

```Assembly
ection .text
global _start
_start:
    ; while not Arrivé:
    jmp check

loop:
    ; ToutDroit()
    ; if Regarder() == 'vert':
    ; TournerDroite()
    ; Arrivé = True
    mov byte [Arrivé], 1

check:
    cmp byte [Arrivé], 0
    je loop

    ; return 0
    mov eax, 0x60
    xor edi, edi
    syscall
```

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



## Les Risques

* **Vulnérabilité** : Faute, par malveillance ou maladresse, dans les spécifications, la conception, la réalisation, l’installation ou la configuration d’un système, ou dans la façon de l’utiliser. 
* **Remarques** : Une vulnérabilité peut être utilisée par un code d’exploitation et conduire à une intrusion dans le système. (faiblesse sur le SI)
* **Risque** = `Menace * Vulnérabilité * Impact` = `Impact * Vraissemblance` = `Gravité * Facilité d'exploitation`

Niveau de risque en fonction de la gravité (ordonnée ) et de la vraissemblance (abscisse):

|  | Faible | Moyenne | Élevée | Critique |
| --- | --- | --- | --- | --- |
| **Très improbable** | Faible | Faible | Moyen | Élevé |
| **Improbable** | Faible | Moyen | Élevé | Très élevé |
| **Probable** | Moyen | Élevé | Très élevé | Critique |
| **Très probable** | Élevé | Très élevé | Critique | Critique |




<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>




## Le traitement du risque

* écarter : par exemple, l'arrêt d'un service obsolète
* atténuer (mitigate) : par exemple, la mise en place d'un Firewall applicatif (WAF)
* transférer : par exemple, la migration vers un service cloud qui s'engage contractuellement à couvrir ce risque
* accepter : laisser le risque tel quel est assumer l'impact d'une exploitation par un attaquant


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



## Critères de sécurité (DICP)

* **Disponibilité** : ***que les données soient bien accessibles***

* **Intégrité** : Garantie que le système et l’information traitée ne sont modifiés que par une action volontaire et légitime. ***que les données n'ont pas été altérées ou modifiées***

* **Confidentialité** : Propriété d’une information qui n’est ni disponible, ni divulguée aux personnes, entités ou processus non autorisés. ***accessibles aux seules personnes autorisées***

* **Preuve**, Tracabililité, Non-répudiation

* **Authentitication** : L’authentification a pour but de vérifier l’identité dont une entité se réclame. ***La personne est bien celle qu'elle prétend être.***


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Le STRIDE (les menaces plutôt que les DICP)

* Spoofing (usurpation)
* Tampering (falsification)
* Répudiation (répudiation)
* Information Disclosure (fuite de données)
* Déni de service
* Élévation de privilège

[source Microsoft](https://docs.microsoft.com/fr-fr/azure/security/develop/threat-modeling-tool-threats)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Cadre juridique

### articles 323-1 et suivants du Code pénal – version du 26/01/2023

* Le fait d'accéder ou de se maintenir, frauduleusement, dans tout ou partie d'un système de traitement automatisé de données est puni de 3 ans d'emprisonnement et de 100 000 € d'amende.
* Lorsqu'il en est résulté soit la suppression ou la modification de données contenues dans le système, soit une altération du fonctionnement de ce système, la peine est de 5 ans d'emprisonnement et de 150 000 € d'amende.
* Lorsque les infractions prévues aux deux premiers alinéas ont été commises à l'encontre d'un système de traitement automatisé de données à caractère personnel mis en œuvre par l'Etat, la peine est portée à **7 ans d'emprisonnement et à 300 000 € d'amende**.


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Les émissions radio

* L’ ANFR en application de l’article L.43 du Code des postes et communications électroniques (CPCE), veille à ce que les sites et les réseaux radioélectriques soient conformes à la réglementation et instruit les cas de brouillage qui lui sont signalés.

* Les utilisations de fréquences ou d’équipements radioélectriques en dehors des conditions réglementaires sont des délits soumis à une sanction pénale pouvant aller jusqu’à 6 mois de prison et 30 000 euros d’amende (L. 39-1 du CPCE).

* Les brouillages de fréquences autorisées causés par l’utilisation non conforme d’équipements radioélectriques, électriques ou électroniques sont des délits soumis à une sanction pénale pouvant aller jusqu’à 6 mois de prison et 30 000 euros d’amende (L. 39-1 du CPCE).

* En dehors de dérogations encadrées pour des services de l’État, la possession, l’utilisation, la cession à titre commercial ou gratuit, la publicité illicites de brouilleurs sont strictement interdites (article L. 33-3-1 du CPCE). Ce sont des délits soumis à une sanction pénale pouvant aller jusqu’à **6 mois de prison et 30 000 euros d’amende** (L. 39-1 du CPCE).


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Le RGPD

**données personnelles** : Une donnée personnelle est toute information se rapportant à une personne physique identifiée ou identifiable. ex:  Nom, numéro de téléphone ou de plaque d’immatriculation, un identifiant tel que le numéro de sécurité sociale, une adresse postale ou courriel, mais aussi la voix ou l’image. ou croisement de données: une femme vivant à telle adresse, née tel jour et membre dans telle association

Il est obligatoire de : 

    * Recueillir l'accord préalable des clients.
    * Informer les clients de leurs droits d'accès, de rectification, d'opposition et de suppression des informations collectées.
    * Veiller à la sécurité des systèmes d'information.
    * Assurer la confidentialité des données.
    * Indiquer une durée de conservation des données.


* le montant des sanctions pécuniaires peut s'élever jusqu'à **20 millions d'euros ou dans le cas d'une entreprise jusqu'à 4 % du chiffre d'affaires annuel mondial**


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Gouvernance

* PSSI : Politique SSI
* SMSI : Système de management de la Sécurité de l'information (ISO27001)
* SOC : Security operation center, utilise un SIEM pour la supervision de la sécurité.
* AdR : Analyse de risque

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Normes et cadre réglementaire

* LPM : Loi de programmation militaire (OIV)
* NIS : Network Information Security (OSE)
* RGPD : Données personnelles
* PCI : bancaire (payement)
* HDS : Données de Santé
* ISO2700X : normes SMSI
* RGS : Administration
* DORA : entités financières

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



## La documentation en entreprise (concept anglo-saxon)

### Mandatory 

* Policies : General Management statement
* Standards : Specific Mandatory Controls
* Procedures : Step By Step Instructions

### Discretionary

* Guidelines : Best Practices / Recommendations
* Baselines : Minimal implementation

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## La sécurité physique

La sécurité physique est la première couche de sécurité d’une entreprise, son but est de:

* Prévenir les accès non autorisés aux ressources et aux systèmes

* Empêcher l’altération et le vol des données sensibles

* Protéger de l’espionnage et du sabotage

* Limiter les attaques par ingénierie sociale


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Les risques

* Tailgating : suivre quelqu'un pour passer une porte
* PiggyBacking : demander l'ouverture d'une porte
* Shoulder Surfing : regarder le mot de passe d'un autre (par dessus son épaule)
* Wiretapping : écoute via le réseau (logiciel ou materiel)
* Keylogger : enregistrement des frappes au clavier (logiciel ou materiel)
* Tempest : Compromissions par rayonnement éléctro magnetique

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Exemple de materiels

* [Great Scott Gadgets Throwing Star LAN Tap Kit ](https://www.amazon.fr/Great-Scott-Gadgets-Throwing-Star/dp/B07GYWZPXG)
* [Rubber Ducky](https://shop.hak5.org/products/usb-rubber-ducky)
* [HackRF](https://www.passion-radio.fr/emetteur-sdr/hackrf-sdr-75.html)
* [Flipper zero](https://flipperzero.one/)
* [Wfi PineApple](https://shop.hak5.org/products/wifi-pineapple)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Les mots de passe

Toujours le principal point d'entrée pour l'attaquant

* Gestionnaire de mots de passe individuel pour les comptes personnels (ex: Keepass)
* Gestionnaire de mots de passe partagée pour les comptes de service
* Autant que possible on complète par du MFA

* Le minimum syndical : 12 chars avec maj, min, digit, spéciaux
* Avec les gerstionnaire de mots de passe: 20 chars
* Comptes de services : +30 chars


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Les smartphones

Les problématiques spécifiques aux Smartphones

* Connecté simultanément à de multiples réseaux : 5G, Wifi, Bluetouth 
* Droits donnés aux applications : l’appli lampe torche lit les messages...
* Toujours sur soi : pro et perso
* Backdoor Fabricant : micro activable légalement
* Pas toujours à jour: Krack, 5Ghoul

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## L'ingénierie sociale

#### MICE

* Monnaie (Money)
* Idéologie
* Contrainte
* Ego (flatterie)

### autres leviers

* Urgence
* Sabotage

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


### Phishing

Phishing à partir de `https://www.securite-solutions.fr/login`, où est le piège ? 

```txt
* https://www.securite-solutions.fr.it/login

* https://www.securite-solutions.fr?p=<script>https://bidule.io?login</script>

* https://www.securite-solutions/fr/login (plus de TLD, la machine utilisera les suffixes par défaut du bail DHCP)

* https://www.securite-solution.fr/login (solution au singulier)

* https://www.securite-solµtions.fr/login (« u » cyrillique)

* https://www.securite-sоlution.fr/login (« o » cyrillique)
```

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Le Cloud

Consiste à utiliser des ressources distantes le plus souvent au travers d’internet

* Public : ressources partagées et détenu par des tiers
* Privé : systèmes réservés au client
* Hybride : Public + Privé


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

### Les responsabilités

Répartition des responsabilités entre le fournisseur de services cloud (CSP):

|  | **IaaS** | **PaaS** | **SaaS** |
|---|---|---|---|
| **Applications** | Client | Client | CSP |
| **Données** | Client | Client | CSP |
| **Runtime** | Client | CSP | CSP |
| **Middleware** | Client | CSP | CSP |
| **Système d'exploitation** | Client | CSP | CSP |
| **Virtualisation** | CSP | CSP | CSP |
| **Serveurs** | CSP | CSP | CSP |
| **Stockage** | CSP | CSP | CSP |
| **Réseau** | CSP | CSP | CSP |

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Les audits

Les activités couvertes par le référentiel PASSI :

- audit d’architecture (ARCHI);
- audit de configuration (CONF);
- audit de code source (CODE);
- test d’intrusion (PENTEST);
- audit organisationnel et physique (ORGAPHY)

[Source PASSI](https://cyber.gouv.fr/actualites/appel-public-commentaires-sur-la-mise-jour-du-referentiel-passi)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


## Intégration des prestations dans le Software Development LifeCycle (SDLC)

| Exigences | Conception | Développement | Déploiement | Maintenance |
|---|---|---|---|---|
|Analyse de risques| Audit d'architecture | Audit de Code | Test d'intrusion | Contrôles de sécurité |
|Modélisation de menaces| Ateliers de sensibilisations sécurité | Audit de Configuration | | Audits périodiques |
|Expression de besoin sécurité | | | | |


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Référentiels et bonnes pratiques

* [ANSSI](https://cyber.gouv.fr/)
* [Guide d'hygiène](https://cyber.gouv.fr/publications/guide-dhygiene-informatique)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Les réflexes en cas d'incidents

* Débrancher du réseau
* Ne pas éteindre
* Alerter le RSSI et N+1 par un autre canal
* [CERT-FR : les bons réflexes en cas d'incident](https://www.cert.ssi.gouv.fr/les-bons-reflexes-en-cas-dintrusion-sur-un-systeme-dinformation/)
* [ANSSI : Gestion de crise](https://cyber.gouv.fr/anticiper-et-gerer-une-crise-cyber)


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Pour aller plus loin 

* [Supports Dojo-101](https://github.com/Aif4thah/Dojo-101/)
* [Démonstation d'attaques](https://github.com/Aif4thah/VulnerableLightApp)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>