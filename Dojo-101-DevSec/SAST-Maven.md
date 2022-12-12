# compilations maven


## varial d'environnement

```powershell
$env:JAVA_HOME
C:\Program Files\Java\jdk-17.0.1
$env:M2_HOME
C:\Program Files\apache-maven-3.8.6
$env:M2
C:\Program Files\apache-maven-3.8.6\bin
```

## avoir les dépendances dans son repository local .m2:

télécharger les projets et faire un "maven install"


## spécifier le chmin d'un projet parent (après l'avoir téléchargé manuellement):
    <parent>
        <groupId>not.real.commons</groupId>
        <artifactId>real-spring-boot-parent</artifactId>
        <version>2.4.4.0</version>
        <relativePath>../real-spring-boot-parent-release-2.4.4@041f33b9bf7</relativePath>
    </parent>


## erreur git:
trouver dans le pom et ajouter le "<failOnNoGitDirectory>false</failOnNoGitDirectory>"
 <groupId>pl.project13.maven</groupId>
                <artifactId>git-commit-id-plugin</artifactId>
                <configuration>
                <failOnNoGitDirectory>false</failOnNoGitDirectory>

## splunk

        <repositories> 
        <repository> 
            <id>splunk-artifactory</id> 
            <name>Splunk Releases</name> 
            <url>https://splunk.jfrog.io/splunk/ext-releases-local</url> 
        </repository>
        </repositories>


# Options pour création db codeql
mvn.cmd clean package -f "pom.xml" -B -V -e -Dfindbugs.skip -Dcheckstyle.skip -Dpmd.skip=true -Denforcer.skip -Dmaven.javadoc.skip -DskipTests -Dmaven.test.skip.exec -Dlicense.skip=true -Drat.skip=true