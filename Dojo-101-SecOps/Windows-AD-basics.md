# Active Directory (AD) Basics

Notes faites à partir de TryHackMe et Microsoft Learn

## Domain Services 
 
- LDAP - Lightweight Directory Access Protocol; provides communication between applications and directory services
- Certificate Services - allows the domain controller to create, validate, and revoke public key certificates
- DNS, LLMNR, NBT-NS - Domain Name Services for identifying IP hostnames
- Domain Authentication Overview - 

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

name: NTDS.dit

- Stored by default in %SystemRoot%\NTDS
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


## Hybrid with Azure

| Windows Server AD	 | Azure AD |
|--------------------|----------|
| LDAP | Rest APIs |
| NTLM | OAuth/SAML |
| Kerberos | OpenID |
| OU Tree | Flat Structure |
| Domains and Forests | Tenants |
| Trusts | Guests |

