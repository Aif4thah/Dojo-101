# Azure Web Apps

## Secrets

Web.config ou appsettings.json doivent aller dans l'App service (portail Azure)
Une fois stockés, les paramètres d’application sont toujours chiffrés (chiffrement au repos).

## Activer la journalisation de serveur Web

Pour Journalisation du serveur web, sélectionnez Stockage pour stocker les journaux dans le stockage d’objets blob, ou Système de fichiers pour stocker les journaux sur le système de fichiers App service.

Dans Période de conservation (jours) , définissez le nombre de jours pendant lesquels les journaux doivent être conservés.

Lorsque vous avez terminé, sélectionnez Enregistrer.

## Ajouter des messages de journalisation dans le code

Dans votre code d’application, vous utilisez les fonctionnalités de journalisation habituelles pour envoyer des messages de journalisation aux journaux des applications. Par exemple :

Les applications ASP.NET peuvent utiliser la classe System.Diagnostics.Trace pour enregistrer des informations dans le journal de diagnostic d’application. Par exemple :

```C#
System.Diagnostics.Trace.TraceError("If you're seeing this, something bad happened");
```
Par défaut, ASP.NET Core utilise le fournisseur de journalisation Microsoft.Extensions.Logging.AzureAppServices.

## lire les logs

```Bash
az webapp log tail --name appname --resource-group myResourceGroup
```
Applications Linux/de conteneur : https://<app-name>.scm.azurewebsites.net/api/logs/docker/zip
Applications Windows : https://<app-name>.scm.azurewebsites.net/api/dump


