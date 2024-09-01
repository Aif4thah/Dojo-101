# Développement sécurisé / DevSec basics


### Référentiels et bonnes pratiques

* [projets OWASP](https://owasp.org/projects/)
* [Guides ANSSI](https://cyber.gouv.fr)
* [Chaine DevOps](https://learn.microsoft.com/fr-fr/azure/cloud-adoption-framework/ready/considerations/devops-toolchain#azure-devops-and-github-toolchain)


### énumeration des vulnréabilités et mauvaise pratiques

[OWASP top 10](https://owasp.org/Top10/) 
[SANS TOP 20](https://www.softwaretestinghelp.com/sans-top-20-security-vulnerabilities/)
[liste des CWE](https://cwe.mitre.org/)

### Rechercher des vulns spécifiques

[cvemap](https://github.com/projectdiscovery/cvemap)
[API KEY](https://cloud.projectdiscovery.io/?ref=api_key)
```powershell
.\cvemap.exe -auth
.\cvemap.exe -l 100
```

## notions de vulnérabilité

Risque = Impact * Vraisemblance

Vulnérabilité = Faiblesse du SI

Menace = Cause potentielle de l’incident

Impact = Gravité, portée de l’incident sur les échelles et critères DICT

Risque = Vuln + Menace + Impact

## threats modeling	

1. What are we working on ?
2. What can go wrong ?
3. What are we going to do about it ?
3. Did we do a good job ?

* Assess Scope - What are we working on? This might be as small as a sprint, or as large as a whole system.
* Identify what can go wrong - This can be as simple as a brainstorm, or as structured as using STRIDE, Kill Chains, or Attack Trees.
* Identify countermeasures or manage risk - Decide what you’re going to do about each threat. That might be to implement a mitigation, or to apply the accept/transfer/eliminate approaches of risk management.
* Assess your work - Did you do a good enough job for the system at hand?

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
