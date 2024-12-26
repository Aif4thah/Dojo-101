# Windows basics

## Kernel modes

| Kernel mode | User Mode |
|-------------|-----------|
| NTOS Kernel executive : System Call Interface, Security reference monitor, Object/Conf/IO/Process/Memory/Advanced local procedure Managers | Les applications utilisateurs |
| Drivers ||
| Code Integrity ||


## Principaux processus

| Nom | Description |
|-----|-------------|
| IDLE | Ce processus ne sert qu’à comptabiliser le temps d’inactivité du CPU |
| System | Ce processus contient la majorité de l’espace d’adressage du kernel |
| Session manager | Smss.Exe |
| Windows subsystem | Csrss.exe |
| Session 0 init | Wininit.exe |
| Logon | Winlogon.exe |
| Gestionnaire services | Services.Exe |
| Local security Authentication Service | Lsass.Exe | 


## Security components (liste non exhaustive)

* Gestionnaire d'identification (applications et compte Microsoft)

* SRM – Security Reference Monitor

* Lsass – Local Security Authority Subsystem Service 

* SAM – Security Accounts Manager (comptes locaux)

* Winlogon / credential providers

* Netlogon 

* KSecDD – Kernel Security Device Driver

* Applocker

* Next Generation Creds Folder


## Tokens (Security Access Token)

* Utilisé par le `Security Reference Monitor` et `LSASSexe` il contient : 

- user SIDs(security identifier)
- group SIDs
- privileges

###  Primary token 

assigné à chaque process, pour que le SRM connaisse les permissions

### Impersonnation token 

Pour certains services, pour prendre d'autres identités.

* SecurityAnonymous: current user/client cannot impersonate another user/client
* SecurityIdentification: current user/client can get the identity and privileges of a client, but cannot impersonate the client
* SecurityImpersonation: current user/client can impersonate the client's security context on the local system
* SecurityDelegation: current user/client can impersonate the client's security context on a remote system

## Privilèges

Détenu ou hérité par un compte, par exemple

* SeImpersonatePrivilege
* SeAssignPrimaryPrivilege
* SeTcbPrivilege
* SeBackupPrivilege
* SeRestorePrivilege
* SeCreateTokenPrivilege
* SeLoadDriverPrivilege
* SeTakeOwnershipPrivilege
* SeDebugPrivilege

## permissions NTFS

lecture historique des permissions :

```txt
   permission is a permission mask and can be specified in one of two forms:
        a sequence of simple rights:
                D - Delete access
                F - Full access (Edit_Permissions+Create+Delete+Read+Write)
                N - No access
                M - Modify access (Create+Delete+Read+Write)
                RX - Read and eXecute access
                R - Read-only access
                W - Write-only access
        a comma-separated list in parentheses of specific rights:
                DE - Delete
                RC - read control
                WDAC - write DAC
                WO - write owner
                S - synchronize
                AS - access system security
                MA - maximum allowed
                GR - generic read
                GW - generic write
                GE - generic execute
                GA - generic all
                RD - read data/list directory
                WD - write data/add file
                AD - append data/add subdirectory
                REA - read extended attributes
                WEA - write extended attributes
                X - execute/traverse
                DC - delete child
                RA - read attributes
                WA - write attributes
        inheritance rights can precede either form and are applied
        only to directories:
                (OI) - object inherit
                (CI) - container inherit
                (IO) - inherit only
                (NP) - don’t propagate inherit
                (I)  - Permission inherited from parent container
```


## Trusted Plateform module (TPM)

Settings > Update & Security > Windows Security > Device Security

## SAM

Stockage (historique) des comptes locaux : `C:\Windows\system32\config\SAM` ou `HKEY_LOCAL_MACHINE\SAM\`

## Vault

credential Manager ou Gestionnaire d'identification: utiliser la barre de recherche ou la commande `rundll32.exe keymgr.dll,KRShowKeyMgr`

Les fichiers correspondants sont dans `C:\Users\<username>\AppData\Local\Microsoft\Vault\`


## Windows Hello (PIN)

Next generation creds folder: `C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc`


## changer la langue:

```powershell
Set-WinUserLanguageList fr-FR -Force
Set-Culture fr-FR
Set-WinHomeLocation -GeoId 94
Set-WinsystemLocale fr-FR
```

### Pour réparer l'enregistrement de démarrage :

```powershell
cd <partition system>:\EFI\Microsoft\Boot\
bootrec /FixBoot
ren BCD BCD.old
bcdboot c:\Windows /l en-us /s : All
```

### Images de boot 

> Les images distribuées par Microsoft n'ont pas de partition gpt, il n'est pas possible de booter sur une clé USB en copiant l'image (ok pour un DVD ou une VM). Il faut créer la partition gpt manuellement ou avec un outil (rufus) et désactiver le secureboot pour booter sur la clé (secureboot=produit commercial=Microsoft=pas de signature des logiciels GPLv3)

### Dual boot

* Uniquement pour partition MBR
* commande pour shoote le grub et réparer le bootmgr / bcd : `bootsect /nt60 <drive name>: /mbr`


## Startup Folders

Autostart for currently logged-on user:

* shell:startup = %appdata%\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

And startup folder all users:

* shell:common startup = %programdata%\Microsoft\Windows\Start Menu\Programs\Startup 
* shell:start menu = start menu in Windows-10
* shell:common start menu = All user start menu in Windows-10 


## Vérifier si nom machine dispo:

* AD
* DNS
* remonté desktop

## Vérifier si une IP est dispo:

* zone forward du serveur DNS (cocher Associated pointer pour créer automatiquement dans la reverse)
* ping et nslokup (zone reverse DNS)
* remonté desktop (au cas ou le firewall empêche la réponse ICMP)

	
## Moyens d'accès à distance:

* remonté desktop `mstsc.exe`
* winRM
* Console

## administration distante:

* GPO
* local policy
* droits share 
* droits NTFS
* Firewall


## mise en place audit:

* GPO:Computer Configuration / Policies / Windows Settings / Security Settings / Local Policies / Audit Policy 
* local policy
* propriété de l'objet / sécurité /audits
* auditpol.exe

	
## Commande net use pour monter un lecteur partagé en local (historique):

`net use Y: \\serveur\dossier-public passwd /user:domaine\account /PERSISTENT:YES`

> passwd peut etre remplacé par * pour masquer le mot de passe qui sera demandé

## Commande pour créer un partage (historique):

`net share myshare=C:\Users\Myname`
	
	
## Ajouter un script au démarrage:

Depuis les GPO: `computer configuration` -> `windows setting` -> `script` 
	
Tous les programmes présents dans l'onglet démarrage de MSconfig sont inscrits dans votre base de registre dans les clés

* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices
* idem avec `HKCU`	
* `taskscheduler`: déclenché au logon

			
## Config IP 

`New-NetIPAddress -InterfaceAlias -Wired Ethernet-Connection -IPv4Address 192.168.0.1 -PrefixLength 24 -DefaultGateway 192.168.0.254`
	
### Teaming/Biding NIC 

Pour *Windows Server* : aller dans le `server manager`, et configurer en mode: active/stanby


## Voir qui est connecté en RDP sur une machine depuis l'AD:

Outils d'administration > `Remote Desktop service Manager`
	

## Vérifier qu'un compte existe sur une machine:

via le administratif IPC$ :

```powershell
Net use \\target\IPC$ /user:admav 
```

### null session:

```powershell
net use \\target\ipc$ "" /user:""
```

## Fermer une session en batch:

`query session` puis `tsdiscon`


## changement de version Windows :
	
`dism /online /set-edition:serverenterprise /productkey:<key>`


## empêcher Windows de passer en adresse APIPA

`new-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters -Name "IPAutoconfigurationEnabled" -value 0`


## changement clavier:

`Set-WinUserLanguageList -LanguageList [en-US |fr-FR]`

## Niveau d'authentification remonté desktop:

`GPO locale` -> `Security Options` -> `Network Security`: `LAN manager`


## Analyser les performances:

* perfmon.exe

## copier les ACL:

`Get-Acl -Path C:\Folder1 | Set-Acl -Path C:\Folder2`

## Lister les listeners WinRM:

`winrm enumerate winrm/config/listener`

## WINRM hors du domaine 

Côté serveur:

```powershell
set-netfirewallrule -name complusnetworkaccess-dcom-in éenabled true 
set-netfirewallrule -name remoteeventlogsvc-in-tcp éenabled true 
set-netfirewallrule -name remoteeventlogsvc-np-in-tcp éenabled true 
set-netfirewallrule -name remoteeventlogsvc-rpcss-in-tcp éenabled true 
eanble-psremoting -force 
```

Côté client:

```powershell
Set-item wsman:\localhost\client\trustedhosts "IP"
new-pssession -computername name -credential -\username
```

## fichier hosts 

Chemin : `c:\windows\system32\drivers\etc\hosts`

## Outils divers

* [PowerToys](https://learn.microsoft.com/fr-fr/windows/powertoys/install)

## Tests

Prolonger la licence d'éssai (3*30 jours)

```powershell
slmgr.vbs -rearm
```