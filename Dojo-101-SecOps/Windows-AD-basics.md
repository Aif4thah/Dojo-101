# Active Directory (AD) Basics


## FSMO:

* Contrôleur de domaine
* PdC (synchro heure)
* Global-Catalog (contient tous les objets des domaines AD)
* RID (gère les Security ID)
* Infrastructure master (unicité des noms)

## Authentification

- Kerberos - The default authentication service for Active Directory uses ticket-granting tickets and service tickets to authenticate users and give users access to other resources across the domain.
- NTLM - default Windows authentication protocol uses an encrypted challenge/response protocol


## Composants

- Domain Controllers
- Forests, Trees, Domains
- Users + Groups 
- Trusts
- Policies 
- Domain Services

## Domain Controllers

- holds the AD DS data store 
- handles authentication and authorization services 
- replicate updates from other domain controllers in the forest
- Allows admin access to manage domain resources


## creds storage

name: **NTDS.dit**

- Stored by default in `%SystemRoot%\NTDS`
- accessible only by the domain controller


## Forest

- Trees - A hierarchy of domains in Active Directory Domain Services
- Domains - Used to group and manage objects 
- Organizational Units (OUs) - Containers for groups, computers, users, printers and other OUs
- Trusts - Allows users to access resources in other domains
- Objects - users, groups, printers, computers, shares
- Domain Services - DNS Server, LLMNR, IPv6
- Domain Schema - Rules for object creation


## Groups  

- Security Groups - These groups are used to specify permissions for a large number of users
- Distribution Groups - These groups are used to specify email distribution lists. As an attacker these groups are less beneficial to us but can still be beneficial in enumeration

### Connaitre le groupe d'un users:

`dsquery user -name "michael" | dsget user -memberof -expand |findstr /I croadmins`
	
### Lister les user d'un group:

`dsquery group -name "group" | dsget group -members -expand`

## Étendue des groupes:	
	
### Local ou domaine

Utilisable uniquement dans le domaine local. Un groupe avec une étendue de domaine peut contenir des groupes locaux, globaux ou universels.	
Ils sont également utilisables sur des machines membres du domaine.
	
### Global :

Un groupe global peut être intégré dans tous les domaines approuvés quelques en soit la nature (Domaine Active Directory, Domaine WINNT,
autres forétsé). Un groupe global ne peut contenir que des objets du domaine.

### Universel :

Un groupe universel peut contenir des membres de n’importe quel domaine de la forêt et être utilisé dans tout domaine de la forêt. 
La particularité des groupes universels est qu'ils sont stockés directement sur le catalogue global cependant seulement s'ils sont de type sécurité.

## Ajouter un user d'un autre domaine dans un groupe:

Onglet "General" des propriétés du groupe: passé le groupe à "universal" puis "domain local"
	
## Attribuer un privilège a un user:

Stratégie de sécurité du contrôleur de domaine -> Paramètres de sécurité/Stratégies locales/Attribution des droits d'utilisateurs



## Default Security Groups - 

- Domain Controllers - All domain controllers in the domain
- Domain Guests - All domain guests
- Domain Users - All domain users
- Domain Computers - All workstations and servers joined to the domain
- Domain Admins - Designated administrators of the domain
- Enterprise Admins - Designated administrators of the enterprise
- Schema Admins - Designated administrators of the schema
- DNS Admins - DNS Administrators Group
- DNS Update Proxy - DNS clients who are permitted to perform dynamic updates on behalf of some other clients (such as DHCP servers).
- Allowed RODC Password Replication Group - Members in this group can have their passwords replicated to all read-only domain controllers in the domain
- Group Policy Creator Owners - Members in this group can modify group policy for the domain
- Denied RODC Password Replication Group - Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain
- Protected Users - Members of this group are afforded additional protections against authentication security threats. See http://go.microsoft.com/fwlink/?LinkId=298939 - for more information.
- Cert Publishers - Members of this group are permitted to publish certificates to the directory
- Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the domain
- Enterprise Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the enterprise
- Key Admins - Members of this group can perform administrative actions on key objects within the domain.
- Enterprise Key Admins - Members of this group can perform administrative actions on key objects within the forest.
- Cloneable Domain Controllers - Members of this group that are domain controllers may be cloned.
- RAS and IAS Servers - Servers in this group can access remote access properties of users

## Domain Trusts

- Directional - The direction of the trust flows from a trusting domain to a trusted domain
- Transitive - The trust relationship expands beyond just two domains to include other trusted domains

## Domain Policies

- Disable Windows Defender - Disables windows defender across all machine on the domain
- Digitally Sign Communication (Always) - Can disable or enable SMB signing on the domain controller

## GPO

> ATTENTION âpre changement d'OU les paramètres de l'ancienne GPO ne disparaisse pas forcement !

`rsop.msc`
`gpresult /z`

## Gerer les objets AD: 

`adsiedit.msc`

## Tester la connexion avec le contrôleur de domaine:

`nltest /sc_query:<domain>`
