# Windows basics


## Pincipaux processus

| Nom | Description |
---------------------
| IDLE | Ce processus ne sert qu’à comptabiliser le temps d’inactivité du CPU |
| System | process Contient la majorité de l’espace d’adressage du kernel |
| Session manager | Smss.Exe |
| Windows subsystem | Csrss.exe |
| Session 0 init | Wininit.exe |
| Logon | Winlogon.exe |
| Gestionnaire services | Services.Exe |
| Local security Authentication Service | Lsass.Exe | 


## security components


* SRM – Security Reference Monitor

* Lsass – Local Security Authority Subsystem Service 

* SAM – Security Accounts Manager 

* Winlogon / credential providers

* Netlogon 

* KSecDD – Kernel Security Device Driver

* Applocker

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

## tool pour les taches rebarbatives

`powertoys` et `devtoys`

### Pour réparer léenregistrement de démarrage :

	Saisissez et exécutez la commande :
	cd <partition system>:\EFI\Microsoft\Boot\
	Saisissez et exécutez la commande :
	bootrec /FixBoot
	Léétape suivante est alors identique sur tous les systémes déexploitation :
	Reconstruisez le magasin BCD.
	Commencez par exécuter la commande ci-dessous pour sauvegarder léancien BCD :
	ren BCD BCD.old
	Recréez-le ensuite é léaide de la commande suivante :
	bcdboot c:\Windows /l en-us /s : All

## Startup Folder

The best way to open the Startup folder in Windows 10 is with the address shell:startup, you can enter this path in address bar of MS Explorer. 
Or use the Run-Dialog Box [Windows-logo] + [R] in Windows-10 and enter the command shell:startup (... see Image-1 Arrow-1) 
The second startup folder in Windows 10-shell:common startup-is responsible for all users, when here, an entry is created, or deleted, this is valid for all users on the Windows-10 PC. (... see Image-2 Arrow-1) 
Here is the alternative addresses, this can you use to create a new Windows 10 desktop shortcut.

Autostart for currently logged-on user:
shell:startup = %appdata%\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
And startup folder all users:
shell:common startup = %programdata%\Microsoft\Windows\Start Menu\Programs\Startup 

### TIP:

shell:start menu = start menu in Windows-10
shell:common start menu =All user start menu in Windows-10 

## Role AD:

Controleur de domaine
PdC (synchro heure)
Global-Catalog (contient tout les objects des domaines AD)
RID (gere les Security ID)
Infrastructure master (unicité des noms)


## Verifier si nom machine dispo:

* AD
* DNS
* remote desktop

	

## Verifier si une IP est dispo:

* zone forward du serveur DNS (cocher Associated pointer pour créer automatiquement dans la reverse)
* ping et nslokup (zone reverse DNS)
* remote desktop (au cas ou firewall empeche reponse ICMP)

	
## Moyen d'acces a distance:

* remote desktop
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
* proprieté de l'objet / sécurité /audits
* auditpol.exe

	
## Ajouter un user d'un autre domaine dans un groupe:

onglet "General" des proprietés du groupe: passé le groupe a "universal" puis "domain local"
	
## Attribuer un privilege a un user:

Stratégie de sécurité du contréleur de domaine -> Paramétres de sécurité/Stratégies locales/Attribution des droits d'utilisateurs

	
## Commande net use pour monter un lecteur partagé en local (historique):

`net use Y: \\serveur\dossier-public  passwd /user:domaine\account /PERSISTENT:YES`
passwd peut etre remplacé par * pour masquer le mot de passe qui sera demandé

## Commande pour creer un partage (historique):

`net share myshare=C:\Users\Myname`
	
	
## Ajouter un script au démarrage:

dans les GPO: computer configuration -> windows setting -> script 
	
Tous les programmes présents dans l'onglet démarrage de MSconfig sont inscrits dans votre base de registre dans les clés

* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce 
* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices
* cf. aussi les HKCU
		
* taskscheduler: déclanché au logon
		
	
## Connaitre le groupe d'un users:


`dsquery user -name "michael" | dsget user -memberof -expand |findstr /I croadmins`
	
## Lister les user d'un group:

`dsquery group -name "group" | dsget group -members -expand`

			
## Config IP powershell

`New-NetIPAddress -InterfaceAlias -Wired Ethernet-Connection -IPv4Address 192.168.0.1 -PrefixLength 24 -DefaultGateway 192.168.0.254`
	
## Teaming/Biding NIC 

sur ILO installer l'outils HP Network Config Utility est teamer les carte depuis l'utilitaire
		- attention l'utilitaire ne démarre pas si les cartes sont déja configuré (adresse static etc...)
		- dans properties ->teaming controls choisir Network Fault Tolerance Only (NFT)

pour windows 2012 aller dans le server manager, et configurer en mode: active/stanby
		
## Lier un groupe de machine sur un Cluster:

1. sur le cluster: edit setting -> DRS
2. chaque groupe correspond é une salle, il faut répartir les VM entres ses groupes pour assurer une redondance.
	- ATTENTION il faut s'assurer que la VM soit déja sur le bon datastore avec de lui attribuer un groupe (la migration ne seras pas automatiqe)

## Voir qui est connecté en RDP sur une machine depuis l'AD:

Outils d'administration > Remote Desktop service Manager
	

## Verifier qu'un compte existe sur une machine:

	Net use \\qfast01\IPC$ /user:admav ---> le partage administratif IPC$
	
	null session:
	net use \\target\ipc$ "" /user:""
	
## Recuperer la Poubelle:

	c:\$recycle.bin
	
## Fermer une sessions en batch:

`query session` puis `tsdiscon`


## Etendue des groupes:	
	
	Local ou domaine : 
	Utilisable uniquement dans le domaine local. Un groupe avec une étendue de domaine peut contenir des groupes locaux, globaux ou universels.	
	Ils sont également utilisables sur des machines membres du domaine.
	
	Global :
	Un groupe global peut étre intégré dans tous les domaines approuvés quelques en soit la nature (Domaine Active Directory, Domaine WINNT,
	autres forétsé). Un groupe global ne peut contenir que des objets du domaine.

	Universel :
	Un groupe universel peut contenir des membres de néimporte quel domaine de la forét et étre utilisé dans tout domaine de la forét. 
	La particularité des groupes universels est quéils sont stockés directement sur le catalogue global cependant seulement séils sont de type sécurité.

## changement de version Windows:
	
`dism /online /set-edition:serverenterprise /productkey:<key>`


## empecher windows de passer en adresse APIPA

`new-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters -Name "IPAutoconfigurationEnabled" -value 0`

## GPO

`rsop.msc` -> ATTENTION apres changement d'OU les parametre de l'ancienne GPO ne disparaisse pas forcement !
`gpresult /z`

## Gerer les objet AD: 

`adsiedit.msc`

## Tester la connection avec le controleur de domaine:

`nltest /sc_query:<domain>`

## changement clavier:

`Set-WinUserLanguageList -LanguageList [en-US |fr-FR]`

## Niveau d'authentification remote desktop:

GPO locale (si pas appliqué par GPO) -> Security Options -> Network Security: LAN manager

## remote desktop: 

mstsc.exe

## desactiver autorun:

Method 1
1.Click Start -> Run type Gpedit.msc and then press ENTER. 
2.Under Computer Configuration, expand Administrative Templates, expand Windows Components, and then click Autoplay Policies. 
3. In the Details pane, double-click Turn off Autoplay. 
4.Click Enabled, and then select All drives in the Turn off Autoplay box to disable Autorun on all drives. 
5.Restart the computer. 
Method 2
1.Click Start -> Run type Gpedit.msc and then press ENTER. 
2.Under Computer Configuration, expand Administrative Templates, expand Windows Components, and then click Autoplay Policies. 
3.In the Details pane, double-click Default Behavior for AutoRun. 
4.Click Enabled, and then select Do not execute any autorun commands in the Default Autorun behavior box to disable Autorun on all drives. 
5.Restart the computer. 

## Analyser les performances:

demarrer -> executer -> perfmon 



## copier les ACL:

`Get-Acl -Path C:\Folder1 | Set-Acl -Path C:\Folder2`

## tester WINRM:

winrm enumerate winrm/config/listener

## WINRM hors du domaine 

Coté serveur:
	set-netfirewallrule -name complusnetworkaccess-dcom-in éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-in-tcp éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-np-in-tcp éenabled true 
	set-netfirewallrule -name remoteeventlogsvc-rpcss-in-tcp éenabled true 
	eanble-psremoting -force 

Coté cilent:
	Set-item wsman:\localhost\client\trustedhosts "IP"
	new-pssession -computername name -credential -\username


## fichier hosts 

c:\windows\system32\drivers\etc\hosts


