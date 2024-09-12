# SAST - Scan des dépendances et du middleware / librairies

## principes d'attaques via les dépendances

0. Les dépendances utilisées sont vulnérables.

1. Une dépendance légitime est remplacée par une dépendance malveillante.

Par exemple:

* un dépôt (git*) public malveillant contient un nom identique à un package privé avec une version supérieure. Il est alors possible d'exécuter du code arbitraire, et ce même si la compilation échoue.
* un dev se fait compromettre ou modifie malencontreusement un paquet et introduit une vulnérabilité dans l'application.


## outils

### Dependancy check

en local ou dans les CI/CD

```powershell
.\dependency-check.bat --scan <fichier.jar ou lib folder> --out <output>
```

### sonatype

[en ligne](https://ossindex.sonatype.org/search)

syntaxe: package@version

### snyk.io

[en ligne](https://security.snyk.io/vuln/?search=<lib>)



## preconisations

### cas générale

* s'assurer que l'on va charcher les dépendance au bon endroit
* parfois, mieux vaut télécharger les dépendances manuellement via pull request.

### npm

fichier `.bpmrc` ou commande `npm config set registry`

### python

option `-i` ou `index-url` au lieu de `--extra-index-url`
afin de spécifier le dépôt privé

### ruby

faire un `--clear-sources` puis spécifier le dépôt privé avec `sources`

### dotnet / nuget / .NET / c#

Ajouter une source pour télécharger les paquets

```sh
dotnet nuget add source "https://api.nuget.org/v3/index.json" --name "Microsoft"
```

configurer `packageSources` dans `nuget.config`
<clear /> supprime l'héritage
<add /> ajoute un dépôt



### maven / java

Les packets sont protegé par leur FQDN. Attention aux changements de proprietaire des domaines!
on peut spécifier <mirrorOf>*</mirrorOf> pour rediriger toutes les requetes vers un dépôt

## outil

snync (snyk.io)