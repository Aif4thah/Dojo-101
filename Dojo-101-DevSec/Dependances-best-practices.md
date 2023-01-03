# dependances et supply chain attacks

## principes d'attaques

Une dépendance légitime est remplacée par une dépendance malveillante.
Par exemple:

* un dépot (git*) public malveillant contient un nom identique à un package privé avec une version superieur. il est alors possible d'executer du code arbitraire et ce meme si la compilation échoue.
* un dev se fait compromettre ou modifie malencontreusement un paquet et introduit une vulnérabilité dans l'application.

## preconisations

### cas générale

* s'assurer que l'on va charcher les dépendance au bon endroit
* parfois, mieux vaut télécharger les dépendances manuellement via pull request.

### npm

fichier `.bpmrc` ou commande `npm config set registry`

### python

option `-i` ou `index-url` au lieu de `--extra-index-url`
afin de spécifier le dépot privé

### ruby

faire un `--clear-sources` puis spécifier le dépot privé avec `sources`

### nuget / .NET / c#

configurer `packageSources` dans `nuget.config`
<clear /> supprime l'héritage
<add /> ajoute un dépot

### maven / java

Les packets sont protegé par leur FQDN. Attention aux changements de proprietaire des domaines!
on peut spécifier <mirrorOf>*</mirrorOf> pour rediriger toutes les requetes vers un dépot

## outil

snync (snyk.io)




 