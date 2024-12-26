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


## Analyse des permissions des application

Type de permissions

* **Role based** : Permissions RBAC
* **Scope Delegated** : Agit au nom d'un utilisateur authentifié (Impersonation)

Il peut etre interessant de les classer par niveau de risques :

```powershell
## sort Azure permissions

$appli = gc .\Permissions-Role-Application-review.csv
$deleg = gc .\Permissions-Scope-Delegated-review.csv

$outAppli = '.\Final-Permissions-Role-Application-review.csv'
$outDeleg = '.\Final-Permissions-Scope-Delegated-review.csv'

function sort-graphApi{
    param(
        [Object[]]$c,
        [String]$f
    )
    $total = $bloquant = $critique = $majeur = $metier = 0
    '' > $f

    $c |% {

        #criticité
        if($_ -cmatch 'Privileged' -or $_ -match 'bitlocker'){      
            $_ += 'Bloquant;'
            $bloquant += 1
            #write-host -ForegroundColor Magenta $_
        }

        elseif(($_ -cmatch '.All' -and ($_ -match 'write' -or $_ -match '.manage'  -or $_ -match '.fullcontrol' -or $_ -match '.export')) -or $_ -match 'risk'){      
            $_ += 'Critique;'
            $critique += 1
            #write-host -ForegroundColor Magenta $_
        }

        elseif($_ -match 'Write' -or $_ -cmatch '.All' -or $_ -match 'create' -or $_ -match 'idendity' -or $_ -match 'security' ){
            $_ += 'Majeur;'
            $majeur += 1
            #write-host -ForegroundColor Blue $_
        }
        else{
            $_ += 'Mineur;'
        }


        #type et données
        if(`
        $_ -match 'business' -or $_ -match 'mail' -or $_ -match 'teams' -or $_ -match 'chat' -or $_ -match 'channel' -or $_ -match 'files' -or $_ -cmatch 'IMAP' -or $_ -cmatch 'POP' `
        -or $_ -match 'Schedule' -or $_ -match 'Calendar' -or $_ -match 'booking' -or $_ -match 'workforce' -or $_ -match 'meeting' -or $_ -match 'onenote' -or $_ -match 'powerbi' `
        -or $_ -match 'export' -or $_ -match ' log' -or $_ -match 'events'
        ){
            $_ += 'données metier;;'
            $_ = $_.replace('Mineur;','Critique;').replace('Majeur;','Critique;')

            #categorie de données
            if($_ -match 'mail' -or $_ -match 'IMAP' -or $_ -cmatch 'POP' ){
                $_ = $_.Substring(0,$_.Length-1) + ' mail;'
            }
            if($_ -match 'Schedule' -or $_ -match 'Calendar' -or $_ -match 'booking' -or $_ -match 'meeting'){
                $_ = $_.Substring(0,$_.Length-1) + ' calendrier;'
            }
            if($_ -match 'files'){
                $_ = $_.Substring(0,$_.Length-1) + ' fichiers;'
            }
            if($_ -match 'teams' -or $_ -match 'chat' -or  $_ -match 'channel'){
                $_ = $_.Substring(0,$_.Length-1) + ' messagerie;'
            }
            if($_ -match 'business' -or $_ -match 'workforce' -or $_ -match 'onenote' -or $_ -match 'powerbi'){
                $_ = $_.Substring(0,$_.Length-1) + ' informations;'
            }
            if($_ -match 'export'){
                $_ = $_.Substring(0,$_.Length-1) + ' export;'
            }
            if($_ -match ' log' -or $_ -match 'events'){
                $_ = $_.Substring(0,$_.Length-1) + ' evenements;'
            }


            #write-host -ForegroundColor Cyan $_
            $metier += 1
        }else{
            $_ += 'Permissions;;'
            $majeur += 1
            if($_ -match 'approval' -or $_ -match 'consent'){
                $_ = $_.Substring(0,$_.Length-1) + ' approbation;'
            }
            if($_ -match 'security' -or $_ -match 'privilegied'){
                $_ = $_.Substring(0,$_.Length-1) + ' sécurité;'
            }
            if($_ -match 'policy'){
                $_ = $_.Substring(0,$_.Length-1) + ' gouvernance;'
            }
            if($_ -match 'print' -or $_ -match 'device' -or $_ -match 'hardware'){
                $_ = $_.Substring(0,$_.Length-1) + ' materiel;'
            }
            #type générique
            if( $_ -match 'Permissions;;'){
                $_ = $_.Substring(0,$_.Length-1) + 'Tenant' 
            }



        }

        $total += 1
        $_ >> $f
    }
    write-host "$bloquant -> bloquant" -ForegroundColor Magenta
    write-host "$critique -> critique" -ForegroundColor Yellow
    write-host "$majeur -> données" -ForegroundColor  Blue
    write-host "$metier -> metier"-ForegroundColor Cyan
    write-host "total : $total"
}

sort-graphApi $appli $outAppli
sort-graphApi $deleg $outDeleg
```

