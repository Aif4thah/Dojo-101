# Governance, Risk, and Compliance (GRC)

## Homologation du SI

### Ressources

[élaboration de PSSI](https://cyber.gouv.fr/publications/pssi-guide-delaboration-de-politiques-de-securite-des-systemes-dinformation)

### Lignes de maitrise

1. Opérationnel (DSI)
2. Support - gestion des risques (RSSI)
3. Contrôle (Comité d'Homologation)
4. Contrôle externe


## La documentation en entreprise (concept anglo-saxon)

### Mandatory 

* Policies : General Management statement
* Standards : Specific Mandatory Controls
* Procedures : Step By Step Instructions

### Discretionary

* Guidelines : Best Practices / Recommendations
* Baselines : Minimal implementation


## Actifs

### Actifs Essentiels

* Informationnels
* Services

### Actifs supports

* Physique (Hardware, Software, immobilier)
* Corporels (personnels avec skills et expérience)
* Incorporels (réputation)

## la classification des SI hébergeant des données sensibles

Dans la pratique, cette  classification est faite dans le cadre d'une stratégie d'homologation.

| Classe | Description |
|----|----|
| Classe 0 | SI public (p. ex. Internet) ou SI connecté à un SI public (p. ex. SI usuel) qui ne respecte pas les exigences de la classe 1. |
| Classe 1 | SI sensible / DR, connecté à Internet au travers d’une passerelle sécurisée (rupture de flux entre deux dispositifs de filtrage, produits qualifiés) satisfaisant les exigences de sécurité définies dans l’II 901. |
| Classe 2 | SI sensible / DR physiquement isolé d’Internet. |

*DR : Diffusion Restreinte*


## Autorités d'Homologation

| Règlementation | Autorité d'Homologation |
|---|---|
| IGI1300 | ANSSI |
| II 2100 (OTAN) | ANSSI |
| IGI 2102 (EU) | ANSSI |
| II901 | Pas d'exigence |
| PSSIE | Pas d'exigence |
| IGI 1337 | Pas d'exigence |
| RGS | Pas d'exigence |
| LPM | Pas d'exigence |


## Les responsabilités dans un contexte Cloud

Répartition des responsabilités entre le fournisseur de services cloud (CSP):

|  | **IaaS** | **PaaS** | **SaaS** |
|---|---|---|---|
| **Applications** | **Client** | **Client** | CSP |
| **Données** | **Client** | **Client** | CSP |
| **Runtime** | **Client** | CSP | CSP |
| **Middleware** | **Client** | CSP | CSP |
| **Système d'exploitation** | **Client** | CSP | CSP |
| **Virtualisation** | CSP | CSP | CSP |
| **Serveurs** | CSP | CSP | CSP |
| **Stockage** | CSP | CSP | CSP |
| **Réseau** | CSP | CSP | CSP |


## ISO 27001

### Processus Global

```mermaid
flowchart TD
    1(Soutien direction) --> 2(périmètre du SMSI)
    2 -->3(Inventaire des Actifs)
    3 -->4[Analyse de risques - AdR]
    4 -->5{Déclaration d'Applicabilité - DDA}
    4 -->6{Plan de traitement des risques - PTR}
    6 -->7(Programme de mise en oeuvre du SMSI)
    5 -->7(Programme de mise en oeuvre du SMSI)
    7 -->8{Système de Management de la Sécurité de l'Information - SMSI}
    9(Sécurité opérationnelle) --> 8
    10(cadre légal) --> 5
    11(Audits de conformité) --> 8
    12(Audits de sécurité) --> 8
    12-->9
    13(Audit de certification et de surveillance 27001) --> 8
    14(Logs)--> 9
    15(PCA PRA)-->9
    16(KPI)-->9
    17(REX Incidents)-->9
    18(Contrôles)-->9
```

## EBIOS RM

### Processus Global

```mermaid
flowchart TD
    
    0[Parties Prenantes]
    1{Valeurs métiers}
    2[Événements Redoutés]
    1-->2

    3[Sources de risques]
    4[Objectifs Visés]
    5[Couples SROV]
    3-->5
    4-->5
    5-->0
    1<-->|en lien avec|5

    6[Biens supports]
    1-->6
    7[Vulnérabilités]
    7-->6
    6-->8

    8[/Scénarios Opérationnels/]
    9[\Scénarios Stratégiques\]
    5-->|Pertinence|8
    5-->|Pertinence|9
    0-->|Chemins d'attaques|9
    2-->|Gravité|9
    9-->|Chemins d'attaques|8

    10{Scénarios de risques}
    9-->|Gravité|10
    8-->|Vraisemblance|10

    20{Mesures de sécurité}
    20-->|Atténue la Vraisemblance|8
    20-->|Atténue la Gravité|9
    20-->|Atténue le Risque|10

    21(Etat de la menace)
    21-->3
    21-->4
```

### Ateliers

```mermaid
flowchart TD
    1[Atelier 1 : cadrage et socle de sécurité] 
    1--> 2[Atelier 2 : sources de risque]
    2--> | Risques Écosystème| 3[/Atelier 3 : scénarios stratégiques/]
    2--> | Risques Système|4[\Atelier 4 : scénarios opérationnels\]
    3--> 5[Atelier 5 : traitement du risque]
    4--> 5
    5--> |Cycle Opérationnel| 4
    5--> |Cycle Stratégique| 1 
```


### Le traitement du risque

Exemple de niveau de risque en fonction de la gravité (ordonnée) et de la vraisemblance (abscisse):

| | Faible | Moyenne | Élevée | Critique |
| --- | --- | --- | --- | --- |
| **Très improbable** | Faible | Faible | Moyen | Élevé |
| **Improbable** | Faible | Moyen | Élevé | Très élevé |
| **Probable** | Moyen | Élevé | Très élevé | Critique |
| **Très probable** | Élevé | Très élevé | Critique | Critique |


* écarter : par exemple, l'arrêt d'un service obsolète
* atténuer (mitigate) : par exemple, la mise en place d'un Firewall applicatif (WAF)
* transférer : par exemple, la migration vers un service cloud qui s'engage contractuellement à couvrir ce risque
* accepter : laisser le risque tel quel est assumer l'impact d'une exploitation par un attaquant


## Les audits de sécurité

Les activités couvertes par le référentiel PASSI :

- audit d’architecture (ARCHI);
- audit de configuration (CONF);
- audit de code source (CODE);
- test d’intrusion (PENTEST);
- audit organisationnel et physique (ORGAPHY)

[Source PASSI](https://cyber.gouv.fr/actualites/appel-public-commentaires-sur-la-mise-jour-du-referentiel-passi)

## Souveraineté

[Dossier technique du Clusif](https://clusif.fr/wp-content/uploads/2025/01/20240627-Souverainete-et-confiance-numerique.pdf)

*La souveraineté numérique peut être définie comme un concept essentiel visant à garantir la préservation des intérêts fondamentaux d’un État, ainsi que ceux de ses organisations nationales et de leurs utilisateurs en matière de services et de protection des données. La souveraineté numérique permet de répondre à l’impérieux besoin d’indépendance, d’autonomie stratégique, de résilience et d’immunité face aux menaces institutionnalisées provenant de puissances étrangères.*

### Critères de souveraineté

Technique :

* Localisation des datacenters
* Localisation des données (transit, repos, utilisation)
* Localisation des services et applications tierces
* Localisation des sous-traitants
* Localisation des personnes à privilèges
* Localisation des supervisions et sauvegardes
* Localisation du siège de la société

Juridique :

* Certification de l'hébergeur
* Nationalité de l'hébergeur
* Nationalité du personnel ayant accès
* Nationalité des fonds de capitaux
* Montage juridique de la société
* Nationalité des produits et services utilisés
