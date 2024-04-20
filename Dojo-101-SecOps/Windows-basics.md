# Windows basics


## Principaux processus

| Nom | Description |
|-----|-------------|
| IDLE | Ce processus ne sert qu’à comptabiliser le temps d’inactivité du CPU |
| System | process Contient la majorité de l’espace d’adressage du kernel |
| Session manager | Smss.Exe |
| Windows subsystem | Csrss.exe |
| Session 0 init | Wininit.exe |
| Logon | Winlogon.exe |
| Gestionnaire services | Services.Exe |
| Local security Authentication Service | Lsass.Exe | 


## Security components (liste non exhaustive)

* Gestionnaire d'identification (applications et compte microsoft)

* SRM – Security Reference Monitor

* Lsass – Local Security Authority Subsystem Service 

* SAM – Security Accounts Manager (comptes locaux)

* Winlogon / credential providers

* Netlogon 

* KSecDD – Kernel Security Device Driver

* Applocker

* Next Generation Creds Folder


## TPM

Settings > Update & Security > Windows Security > Device Security

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

## Boot

Uniquement pour partition MBR
commande pour shooter grub / reparer le bootmgr / bcd :
`bootsect /nt60 <drive name>: /mbr`

### Pour réparer l'enregistrement de démarrage :

	Saisissez et exécutez la commande :
	cd <partition system>:\EFI\Microsoft\Boot\
	Saisissez et exécutez la commande :
	bootrec /FixBoot
	Léétape suivante est alors identique sur tous les systèmes d'exploitation :
	Reconstruisez le magasin BCD.
	Commencez par exécuter la commande ci-dessous pour sauvegarder l' ancien BCD :
	ren BCD BCD.old
	Recréez-le ensuite é l' aide de la commande suivante :
	bcdboot c:\Windows /l en-us /s : All

## Startup Folders

Autostart for currently logged-on user:
shell:startup = %appdata%\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
And startup folder all users:
shell:common startup = %programdata%\Microsoft\Windows\Start Menu\Programs\Startup 

### TIP:

shell:start menu = start menu in Windows-10
shell:common start menu =All user start menu in Windows-10 

## Roles AD:

Contrôleur de domaine
PdC (synchro heure)
Global-Catalog (contient tout les objects des domaines AD)
RID (gère les Security ID)
Infrastructure master (unicité des noms)


## Vérifier si nom machine dispo:

* AD
* DNS
* remote desktop

## Vérifier si une IP est dispo:

* zone forward du serveur DNS (cocher Associated pointer pour créer automatiquement dans la reverse)
* ping et nslokup (zone reverse DNS)
* remote desktop (au cas ou le firewall empêche la réponse ICMP)

	
## Moyens d'accès à distance:

* remote desktop `mstsc.exe`
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

	
## Ajouter un user d'un autre domaine dans un groupe:

Onglet "General" des propriétés du groupe: passé le groupe à "universal" puis "domain local"
	
## Attribuer un privilège a un user:

Stratégie de sécurité du contrôleur de domaine -> Paramètres de sécurité/Stratégies locales/Attribution des droits d'utilisateurs

	
## Commande net use pour monter un lecteur partagé en local (historique):

`net use Y: \\serveur\dossier-public  passwd /user:domaine\account /PERSISTENT:YES`
passwd peut etre remplacé par * pour masquer le mot de passe qui sera demandé

## Commande pour créer un partage (historique):

`net share myshare=C:\Users\Myname`
	
	
## Ajouter un script au démarrage:

dans les GPO: computer configuration -> windows setting -> script 
	
Tous les programmes présents dans l'onglet démarrage de MSconfig sont inscrits dans votre base de registre dans les clés

* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices
* cf. aussi les HKCU
		
* taskscheduler: déclenché au logon
		
	
## Connaitre le groupe d'un users:


`dsquery user -name "michael" | dsget user -memberof -expand |findstr /I croadmins`
	
## Lister les user d'un group:

`dsquery group -name "group" | dsget group -members -expand`

			
## Config IP powershell

`New-NetIPAddress -InterfaceAlias -Wired Ethernet-Connection -IPv4Address 192.168.0.1 -PrefixLength 24 -DefaultGateway 192.168.0.254`
	
## Teaming/Biding NIC 

pour Windows server: aller dans le server manager, et configurer en mode: active/stanby
		
## Lier un groupe de machine sur un Cluster:

1. sur le cluster: edit setting -> DRS
2. chaque groupe correspond é une salle, il faut répartir les VM entres ses groupes pour assurer une redondance.
	- ATTENTION il faut s'assurer que la VM soit déjà sur le bon datastore avant de lui attribuer un groupe car la migration ne sera pas automatique

## Voir qui est connecté en RDP sur une machine depuis l'AD:

Outils d'administration > Remote Desktop service Manager
	

## Vérifier qu'un compte existe sur une machine:

	Net use \\target\IPC$ /user:admav ---> le partage administratif IPC$
	
	null session:
	net use \\target\ipc$ "" /user:""
	
## Recuperer la Poubelle:

`c:\$recycle.bin`
	
## Fermer une session en batch:

`query session` puis `tsdiscon`


## Étendue des groupes:	
	
	Local ou domaine : 
	Utilisable uniquement dans le domaine local. Un groupe avec une étendue de domaine peut contenir des groupes locaux, globaux ou universels.	
	Ils sont également utilisables sur des machines membres du domaine.
	
	Global :
	Un groupe global peut être intégré dans tous les domaines approuvés quelques en soit la nature (Domaine Active Directory, Domaine WINNT,
	autres forétsé). Un groupe global ne peut contenir que des objets du domaine.

	Universel :
	Un groupe universel peut contenir des membres de n’importe quel domaine de la forêt et être utilisé dans tout domaine de la forêt. 
	La particularité des groupes universels est qu'ils sont stockés directement sur le catalogue global cependant seulement s'ils sont de type sécurité.

## changement de version Windows:
	
`dism /online /set-edition:serverenterprise /productkey:<key>`


## empêcher Windows de passer en adresse APIPA

`new-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters -Name "IPAutoconfigurationEnabled" -value 0`

## GPO

`rsop.msc` -> ATTENTION apres changement d'OU les parametre de l'ancienne GPO ne disparaisse pas forcement !
`gpresult /z`

## Gerer les objets AD: 

`adsiedit.msc`

## Tester la connection avec le controleur de domaine:

`nltest /sc_query:<domain>`

## changement clavier:

`Set-WinUserLanguageList -LanguageList [en-US |fr-FR]`

## Niveau d'authentification remote desktop:

GPO locale (si pas appliqué par GPO) -> Security Options -> Network Security: LAN manager


## Analyser les performances:

demarrer -> executer -> perfmon 


## copier les ACL:

`Get-Acl -Path C:\Folder1 | Set-Acl -Path C:\Folder2`

## Lister les listener WinRM:

`winrm enumerate winrm/config/listener`

## WINRM hors du domaine 

Côté serveur:
	set-netfirewallrule -name complusnetworkaccess-dcom-in éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-in-tcp éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-np-in-tcp éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-rpcss-in-tcp éenabled true 
	eanble-psremoting -force 

Côté client:
	Set-item wsman:\localhost\client\trustedhosts "IP"
	new-pssession -computername name -credential -\username

## fichier hosts 

c:\windows\system32\drivers\etc\hosts

## Misc / Production

* [PowerToys](https://learn.microsoft.com/fr-fr/windows/powertoys/install)
