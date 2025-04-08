# CodeQL


## Ressources

* [Binaires](https://github.com/github/codeql-cli-binaries)

* [Queries](https://github.com/github/codeql)

* [Github Actions](https://github.com/github/codeql-action)


## Scan en local

### Installation

Import des binaires ( dossier `codeql`) et des queries ( dossier renomé `codeql-queries`) à partir des dépots Github

```Powershell
PS C:\Users\vaca\Pro-temp\VulnerableLightApp> gci codeql*

    Répertoire : C:\Users\vaca\Pro-temp\VulnerableLightApp

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        07/11/2024     09:12                codeql
d-----        07/11/2024     09:05                codeql-queries
```

### création des databases

ex: java

```PowerShell
..\codeql-home\codeql\codeql.cmd database create ..\java-spring-POC1 --language=java
```

ex: c#

```PowerShell
..\codeql\codeql.exe database create VLA-CODEQLDB --language=csharp --command='dotnet build /t:rebuild'
```

À l’issue de la compilation, l’outil confirme que la base de données a été correctement créée par le retour suivant :

```txt
Successfully created database at <PATH>
```

### Scans des databases

ex java

```PowerShell
..\codeql\codeql.cmd database analyze --format=csv --output=cqlscan <CODEQL-database> "..\codeql-queries\java\ql\src\codeql-suites\java-security-extended.qls"
```

ex c#

```PowerShell
.\codeql\codeql.exe database analyze VLA-CODEQLDB ..\codeql-queries\csharp\ql\src\codeql-suites\csharp-security-extended.qls --format=csv --output=CodeQL-result.csv --ram=8000
```


Différents formats sont possibles pour les résultats, en voici un extrait au format JSON avec notre fichier et la ligne comportant une vulnérabilité de type injection SQL :

```json
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


## Retours d'experience

### Logs verbeux via les CI/CD Github

ajouter `debug: true` au fichier de workflow.

```yml
<…SNIP…>
    # Initializes the CodeQL tools for scanning.
    - name: Initialize CodeQL
      uses: github/codeql-action/init@v3
      with:
        debug: true
<…SNIP…>
```
