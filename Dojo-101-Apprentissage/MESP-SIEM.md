# Journalisation (Logs)

Initiation au SIEM

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte d'en vos usages.

Durée: 1 jour

## Ressources

[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

[Elastic SIEM Brochure commerciale](https://www.elastic.co/fr/security/siem)

[Elastic SIEM installation](https://www.elastic.co/guide/en/siem/guide/current/install-siem.html)

[download ElasticSearch](https://www.elastic.co/fr/downloads/elasticsearch)

[download Kibana](https://www.elastic.co/fr/downloads/kibana)

[download Winlogbeat](https://www.elastic.co/guide/en/beats/winlogbeat/8.2/winlogbeat-installation-configuration.html)

[Guide ANSSI](https://www.ssi.gouv.fr/guide/recommandations-de-securite-pour-la-mise-en-oeuvre-dun-systeme-de-journalisation/)

## Contexte

Afin de préparer l'arrivée du SIEM vous êtes chargé de présenter un POC sur l'OS de votre choix.

Vous êtes libre de choisir la techno, les actions ci-après sont données pour un POC en local du SIEM ELK sous Windows, à titre d'exemple:


* Télécharger et installer les composants ELK nécessaires sur votre VM : ElasticSearch et WinLogBeat s'installent avec leurs fichiers ".msi". Kibana contient un exécutable dans le répertoire "bin" qu'il faudra exécuter ensuite.

* Vérifier que le service "Elasticsearch" est lancé. Vous pouvez vous aider des commandes:

```powershell
Set-service -name elasticsearch -startupType auto
Get-service elasticsearch |start-service
```

* lancer `./Kibana.bat` et connectez-vous au service Web `http://localhost:5601`

* Collecter vos journaux d’évènements de sécurité avec le forwarder approprié ("WinlogBeat" pour Windows)

```powershell
Set-service -name winlogbeat -startupType auto
Get-service winlogbeat |start-service
```

* Essayez de vous authentifier avec un mauvais mot de passe

* Retrouvez la trace laissée dans votre SIEM via le menu "Security/Host"

* Ouvrez powershell en administrateur

* Retrouvez la trace laissée dans votre SIEM en effectuant une requête dans les journaux d'événements


## Modalités pédagogiques

Seul ou en binôme

## Modalités d'évaluation

Lecture du livrable

## Livrables

Procédure d'installation au format markdown et preuves (screenshot)

## Critères de performance

Le SIEM est fonctionnel