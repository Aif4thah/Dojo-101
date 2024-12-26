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


## Exemple de setting complexe avec plusieurs dépots / dépendances

```xml
<settings>
    <localRepository/>
        <interactiveMode/>
        <offline/>
        <pluginGroups/>
        <servers>
            <server>
                <id>InternalDepot</id>
                <username>User</username>
                <password>Password</password>
            </server>
            <server>
                <id>http-project-releases</id>
                <username>User</username>
                <password>Password</password>
            </server>
            <server>
                <id>http-project-snapshots</id>
                <username>User</username>
                <password>Password</password>
            </server>
            <server>
                <id>http-project</id>
                <username>User</username>
                <password>word</password>
            </server>
        </servers>
        <mirrors>
            <mirror>
                <id>InternalDepot</id>
                <mirrorOf>InternalDepot</mirrorOf>
                <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/public/</url>
                <blocked>false</blocked>
            </mirror>
                <mirror>
                <id>http-project-snapshots</id>
                <mirrorOf>http-project-snapshots</mirrorOf>
                <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-snapshots/</url>
                <blocked>false</blocked>
            </mirror>
            <mirror>
                <id>http-project</id>
                <mirrorOf>http-project</mirrorOf>
                <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project/</url>
                <blocked>false</blocked>
            </mirror>
            <mirror>
                <id>http-project-releases</id>
                <mirrorOf>http-project-releases</mirrorOf>
                <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-releases</url>
                <blocked>false</blocked>
            </mirror>
        </mirrors>
        <proxies>
            <!--
            <proxy>
                <id>Entreprise-proxy</id>
                <active>true</active>
                <protocol>http</protocol>
                <host>proxy.intranet-Entreprise.fr</host>
                <port>8080</port>
                <nonProxyHosts>InternalDepot.intranet-Entreprise.fr|127.0.0.1|localhost</nonProxyHosts>
            </proxy>
            <proxy>
                <id>Entreprise-proxy-https</id>
                <active>true</active>
                <protocol>https</protocol>
                <host>proxy.intranet-Entreprise.fr</host>
                <port>8080</port>
                <nonProxyHosts>InternalDepot.intranet-Entreprise.fr|127.0.0.1|localhost</nonProxyHosts>
        </proxy>
         -->
        </proxies>
        <profiles>
            <profile>        
            <id>InternalDepot</id>
            <!--Enable snapshots for the built in central repo to direct -->
            <!--all requests to InternalDepot via the mirror -->
            <repositories>
                <repository>
                    <id>InternalDepot</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/public/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
                <repository>
                    <id>http-project</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
                <repository>
                    <id>http-project-releases</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-release/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
                <repository>
                    <id>http-project-snapshots</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-snapshots/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>central</id>
                    <url>https://central</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                    <id>InternalDepot</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/public/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                    <id>http-project</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                    <id>http-project-releases</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-release/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                    <id>http-project-snapshots</id>
                    <url>http://InternalDepot.intranet-Entreprise.fr/InternalDepot3/repository/project-snapshots/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
                </pluginRepositories>
            </profile>
        </profiles>
        <activeProfiles>
            <!--make the profile active all the time -->
            <activeProfile>InternalDepot</activeProfile>
        </activeProfiles>     
</settings>
```