# CodeQL

## Article écrit pour Squad:

CodeQL est un outil permettant de découvrir des vulnérabilités en analysant le code source de vos applications.

Il peut aussi bien être utilisé pour des tests automatisés durant le Software développement Life Cycle (SDLC), que par des chercheurs en sécurité pour des projets spécifiques.

Un de ses cas d’usage les plus rependus est probablement le scan automatique de projet GitHub, dont on peut bénéficier gratuitement [1].

L’outil se distingue par ces « queries » au format « from-where-select » qu’il est possible d’exécuter directement en ligne [2].

Figure 1: Intégration Github
Il est également possible de s’approprier l’outil afin de rechercher des vulnérabilités dans le code hébergé ou rapatrié localement sur une machine dédiée. C’est à ce moment-là qu’intervient CodeQL-CLI.

Cet outil est déjà très bien documenté [3]. L’idée de cet article est d’aller à l’essentiel afin de dégrossir rapidement la recherche de vulnérabilités dans une application cible, en vue de mener ensuite des tests plus spécifiques.

Pour cela, il est nécessaire de télécharger l’outillage afin de l’utiliser localement, à savoir :

Les binaires permettant d’exécuter nos requêtes (queries) [4] ;
Les queries elles-mêmes [4], qui serviront de base pour débuter la recherche de vulnérabilités.
Ces deux éléments sont ensuite placés côte à côte dans un même répertoire. Ceux-ci portant le même nom, un des deux doit être renommé. Dans notre cas le dossier contenant nos queries s’appelle « codeql-queries ». Notons que CodeQL peut être ajouté au Path, bien que cela ne soit pas indispensable :

```
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
da---l        06/06/2021     10:52                codeql
da---l        06/06/2021     10:48                codeql-queries
```

Notre code et ses dépendances doivent également être convertis en une base de données que CodeQL pourra ensuite analyser.

Pour cela la commande database create va tenter de retrouver automatiquement, ou prendre en entrée, les options de compilation du projet et créer une base de données qu’il sera ensuite possible de maintenir dans le temps.

Ci-dessous un exemple de commande exécutée depuis le répertoire courant d’un projet, dans ce cas précis l’outil retrouve automatiquement le pom.xml du projet spring et la commande maven adéquate.

Evidement ce ne sera pas toujours le cas et l’option --command permet de corriger les éventuels écarts ou d’utiliser un outil spécifique pour la compilation :

```
..\codeql-home\codeql\codeql.cmd database create ..\java-spring-POC1 --language=java
```

À l’issue de la compilation, l’outil confirme que la base de données a été correctement créée par le retour suivant :

```
Successfully created database at <PATH>
```

L’objectif initial étant de dégrossir la recherche de vulnérabilités, il est préférable de lancer tout une batterie de requêtes. D’un point de vue sécurité, les queries préexistante classées par CWE (Common Weakness Enumeration) constituent un bon point de départ.

Pour aller à l’essentiel, des répertoires nommés « codeql-suites » contiennent des listes de requêtes spécifiées dans des fichiers .qls. Notons que l’extension .ql contiendra la requête CodeQL qui sera individuellement analysée.

Enfin, la commande database analyze et les options suivantes permettent de spécifier le chemin des « helpers » nécessaires à notre listes de requêtes ainsi que le format souhaité du résultat de l’analyse :

```
 .\codeql-home\codeql\codeql.cmd database analyze java-spring-POC1-database .\codeql-home\codeql-queries\codeql-main\java\ql\src\codeql-suites\java-lgtm.qls --format=sarifv2.1.0 --output=OUTPUT.sarif --search-path .\codeql-home\codeql-queries\codeql-main\misc\suite-helpers
```

Différents formats sont possibles pour les résultats, en voici un extrait au format JSON avec notre fichier et la ligne comportant une vulnérabilité de type injection SQL :

```
    "results" : [ {
      "ruleId" : "java/sql-injection",
      "ruleIndex" : 54,
<…SNIP…>
            "uri" : "src/main/java/com/appli/test/testsqli.java",
            "uriBaseId" : "%SRCROOT%",
<…SNIP…>
          "region" : {
            "startLine" : 18,
            "startColumn" : 44,
            "endColumn" : 45
          }

```

Une fois cette première étape effectuée, la recherche de vulnérabilité peut être poursuivie par des requêtes CodeQL plus spécifiques, une lecture manuelle du code ou encore des tests dynamiques.

## Références

License : https://securitylab.github.com/tools/codeql/license/
Query Console : https://lgtm.com/
Documentation : https://codeql.github.com/docs/codeql-cli/
Binaires : https://github.com/github/codeql-cli-binaries
Queries : https://github.com/github/codeql