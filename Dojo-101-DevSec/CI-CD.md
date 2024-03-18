# integrer la sécurité aux CI/CD

## Refs

[Chaine DevOps](https://learn.microsoft.com/fr-fr/azure/cloud-adoption-framework/ready/considerations/devops-toolchain#azure-devops-and-github-toolchain)

## CI - Intégration continue

* Analyse et scan de la sécurité du code source
* Analyse et scan de dépendances
* Tests d’intégration (unitaires, E2E)

## CD - Déploiement continu

* Gestion et scan des secrets
* Test de l'application
* Audit des permissions

## Github Workflows/Actions ou plguins pour la sécurité

* DependencyCheck
* CodeQL
* Nuclei
* SonardQube

## tests unitaires

* Test inputs utilisateurs
* Fuzzings

## tests E2E

* Contournements / mauvais respect des workflows


