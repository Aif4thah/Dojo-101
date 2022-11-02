## Isolation des ressources Azures

## permission des roles

- Actions / NotActions
- DataActions / NotDataActions

beaucoup de rôles sont prédéfinis

### actions possibles

- read
- write
- delete
- action (interaction)
- * (toutes)

### format

`Company.ProviderName/RessourceType/action`

### exemple

`Microsoft.Storage/storageAccounts/blobServices/containers/read`

## Méthodologie

2 solutions possibles pour une politique de moindres privilèges

1. créer un compte sans aucun droit puis choisir les rôles prédéfinis à partir des résultats des messages d'erreurs
2. créer un compte sans aucun + créer un rôle personnalisé

## Network Security Group (NSG)

création du groupe de ressource et du NSG:

```shell
az group create --location <location> --ressource-group <name>
az network nsg create --ressource-group <name> --name <name> --location <location>
```

### Règle Deny

Par défaut les règles sont trop permissives. On crée une règle Deny en fin de table pour le trafic entrant:

```shell
az network nsg rule create --ressource-group <name> --Name DenyAllInbound --priority 4096 --source-address-prefixes '*' --source-port-ranges '*' --destination-adress-prefixes '*' --destination-port-ranges '*' --access Deny --protocol '*' --description <Deny Inbound>
```
### Monitoring avec Network Watcher

```shell
az network watcher configure --ressource-group NetworkWatcherRG --locations <location> --enabled true
```

## Blob storage

### public

3 conf. pour les points d'accès public

- tous
- privés pour des IP
- Désactivé (aucun accès)

### privé

Une les fichiers uploadés via un point d'accès public, le désactiver et utiliser le portail