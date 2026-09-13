# Développement sécurisé / DevSec basics

## Référentiels et bonnes pratiques

* [Projets OWASP](https://owasp.org/projects/)

* [Guides ANSSI](https://cyber.gouv.fr)

* [Chaine DevOps](https://learn.microsoft.com/fr-fr/azure/cloud-adoption-framework/ready/considerations/devops-toolchain#azure-devops-and-github-toolchain)

* [OWASP ASVS](https://github.com/OWASP/ASVS)

## Intégration de la sécurité au Software Development LifeCycle (SDLC)

| Exigences | Conception | Développement | Déploiement | Maintenance |
|---|---|---|---|---|
|Analyse de risques| Audit d'architecture | Audit de Code | Test d'intrusion | Contrôles de sécurité |
|Modélisation de menaces| Ateliers de sensibilisations sécurité | Audit de Configuration | | Audits périodiques |
|Expression de besoin sécurité | | | | |

## Integration de la la sécurité aux canaux CI/CD

* [Chaine DevOps](https://learn.microsoft.com/fr-fr/azure/cloud-adoption-framework/ready/considerations/devops-toolchain#azure-devops-and-github-toolchain)

* [Scan des CI/CD - Octoscan](https://github.com/synacktiv/octoscan)

### CI - Intégration continue

* Analyse et scan de la sécurité du code source
* Analyse et scan de dépendances
* Tests d’intégration (unitaires, E2E)

### CD - Déploiement continu

* Gestion et scan des secrets
* Test de l'application
* Audit des permissions

### Github Workflows/Actions ou pluguins pour la sécurité

* DependencyCheck
* CodeQL
* Nuclei
* SonardQube

### tests unitaires

* Test inputs utilisateurs
* Fuzzings

### tests E2E

* Contournements / mauvais respect des workflows


## Notions de vulnérabilité

Risque = Impact * Vraisemblance

Vulnérabilité = Faiblesse du SI

Menace = Cause potentielle de l’incident

Impact = Gravité, portée de l’incident sur les échelles et critères DICT

Risque = Vuln + Menace + Impact


## énumeration des vulnréabilités et mauvaise pratiques

* [OWASP TOP10](https://owasp.org/Top10/)

* [SANS TOP25](https://www.sans.org/top25-software-errors/)

* [liste des CWE](https://cwe.mitre.org/)


## DREAD : Evaluation d'une vulnérabilité

* Damage potential : If exploited, how harmful could it be?

* Reproducibility : Will attacks succeed every time, some of the time, or only rarely?

* Exploitability : How hard, in terms of technical difficulty, effort, and cost, is the vulnerability to exploit? How long is the attack path?

* Affected users :Will all, some, or only a few users be impacted? Can specific targets be easily attacked, or are the victims arbitrary?

* Discoverability : How likely is it that attackers will find the vulnerability?


## CIA Information security:

1. Confidentiality

2. Integrity

3. Availability

4. Authenticity

5. Non repudiation		


## Security dilema	

* functionality	

* Usuability

* Security


## Type of Policies

* Promiscuous

* Permissive

* Prudent

* Paranoid	


## Oganisational security Documents

1. Policies	

2. Standards

2. Guidelines (not mandatory)

3. Procedures


## suivi des besoins sécurité

1. Besoin de sécurité identifié par la sécurité

2. Animation d'Atelier par la sécurité pour le projet

3. Intégration au Backlog du projet

4. Implémentation par le projet

5. Recette sécurité par la sécurité

6. Evaluation du risque résiduel par la sécurité
retour à 1

## Rechercher des vulns spécifiques

* [cvemap](https://github.com/projectdiscovery/cvemap)

* [API KEY](https://cloud.projectdiscovery.io/?ref=api_key)

```powershell
.\cvemap.exe -auth
.\cvemap.exe -l 100
```


## threats modeling	helper

1. What are we working on ?

2. What can go wrong ?

3. What are we going to do about it ?

3. Did we do a good job ?

* Assess Scope - What are we working on? This might be as small as a sprint, or as large as a whole system.

* Identify what can go wrong - This can be as simple as a brainstorm, or as structured as using STRIDE, Kill Chains, or Attack Trees.

* Identify countermeasures or manage risk - Decide what you’re going to do about each threat. That might be to implement a mitigation, or to apply the accept/transfer/eliminate approaches of risk management.

* Assess your work - Did you do a good enough job for the system at hand?

## Rappel VSCode

Palette commande : `Ctrl + Shift + `
Terminal : `Ctrl + `
Format Cote : `Shift + Alt + F`
Chat Copilot : `Ctrl + I`
