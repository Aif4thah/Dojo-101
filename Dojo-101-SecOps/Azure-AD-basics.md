# Azure AD Basics (Entra ID)

## Accès

* [Portal](https://portal.azure.com/#home)

* [Cloud Shell](https://portal.azure.com/#cloudshell/)

* [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)


## Authentification

* SAML
* Oauth
* Open ID
* WS Federation
* Azure AD Connect is a separate service that allows you to synchronize a traditional Active Directory with your Azure AD instance


## Subscription et tenant

* Azure AD tenant: instance of Azure AD. chaque tenant est indépendant

* An Azure AD directory can be associated with multiple subscriptions, but a subscription is always tied to a single directory.

## Azure AD compte et connexion:

* Utiliser `Azure Cloud Shell` du Terminal Windows avec le lien et code fourni au lancement.

* Utiliser `Connect-AzAccount` du module `Az` :


```powershell
Set-ExecutionPolicy bypass
Import-Module powershellGet
Install-Module -Name Az -AllowClobber
$Credential = Get-Credential
Connect-AzAccount -Credential $Credential
Get-AzContext
```

## Création d'un nouvel utilisateur

```powershell
    # Create a password object
    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

    # Assign the password
    $PasswordProfile.Password = "<Password>"

    # Create the new user
    New-AzureADUser -AccountEnabled $True -DisplayName "Abby Brown" -PasswordProfile $PasswordProfile -MailNickName "AbbyB" -UserPrincipalName "AbbyB@contoso.com"


    az ad user create --display-name "Abby Brown" \
                    --password "<password>" \
                    --user-principal-name "AbbyB@contoso.com" \
                    --force-change-password-next-login true \
                    --mail-nickname "AbbyB"

```

## Création de Groupe

```powershell
    New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"
```

## Delete account:

```powershell
Remove-AzureADUser #pourra être restauré sous 30 jours
```

## Roles

ROLE = Colection of permission

```powershell
 Get-AzureRmRoleDefinition -Name Owner
```

| Name | Description |
|----|----|
| Id | Unique identifier for the role, assigned by Azure. |
| IsCustom | True if this is a custom role, False if this is a built-in role. |
| Description | A readable description of the role. |
| Actions [] | Allowed permissions, * indicates all. |
| NotActions [] | Denied permissions. |
| DataActions [] |	Specific allowed permissions as applied to data, for example Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read |
| NotDataActions [] | Specific denied permissions as applied to data. |
| AssignableScopes [] | Scopes where this role |

### Pricipaux Roles:

* **User Administrator** : Gère les utilisateurs et les groupes dans Azure Active Directory (Azure AD)

* **Global Administrator** : A un accès complet à toutes les fonctionnalités administratives dans Azure AD et aux services qui utilisent des identités Azure AD.

* Member users: user standard, impossible de manager les autres users

* Guest users: restreint, utilisé pour la collaboration avec d'autres organisations

By default, users and administrators in Azure AD can invite guest users. But this ability can be limited or disabled by the Global Administrator.

### Access management

Azure AD rôles: Use Azure AD roles to manage Azure AD-related resources like **users, groups, billing, licensing, application registration, and more**.

**Role-based access control** (RBAC) for Azure resources: Use RBAC roles to manage access to Azure resources like virtual machines, SQL databases, or storage. 
For example, you could assign an RBAC role to a user to manage and delete SQL databases in a specific resource group or subscription.

There are different ways you can assign access rights:

* **Direct assignment**: Assign a user the required access rights by directly assigning a role that has those access rights.

* **Group assignment**: Assign a group the required access rights, and members of the group will inherit those rights. *cas le plus fréquent*

* **Rule-based assignment**: Use rules to determine a group membership based on user or device properties.

## session management

* **OpenID**: standard pour l'authent, couche au-dessus de Oauth pour la vérification des identités

* **Token**: JWT, identity providers sign the token

## Open ID

Pour utiliser OpenID:

1. Create Azure AD tenant

2. Register Web application:

    * Name : This value identifies the registration and application.
    * Application type : Use the Web app/API type for websites or web APIs that are accessed through the HTTP protocol. Use the Native type for applications that are installed on a user's device or computer.
    * Sign-on URL : This value is the location of the sign-on page in the published application.
    * Application ID:  This generated GUID is unique to the registration. Configure your application to send the same GUID to Azure AD whenever it authenticates a user.

3. Configure App authentication ( avec les ID donnés lors de l'enregistrement)

    * <domain-name>	Your Azure AD tenant name
    * <TenantID-GUID>	The directory (tenant) ID that you noted in the previous exercise
    * <ClientID-GUID>	The application (client) ID that you noted in the previous exercise


## Azure MFA:

* Mobile App Verification code -> **MS Authenticator à privilégier**

* Call to a phone

* Text message to a phone


## Device Identity:

Configuration: Security -> Conditional Access

* AAD Registred: BYOD - pas forcement managé, mais configuration des applis, *ex : utilisation d'Exchange depuis un BYOD*.

* AAD Joined: owned by the organisation, device indenty only in the cloud, cas le plus fréquent dans une organisation

* Hybrid AAD joined:  device on-premise and in the cloud


## Mobile Device management:

> un device peut joindre Azure AD sans être managée par un MDM

Settings : `Azure Active Directory > Devices > Device settings`

AAD joins uses MDM, 2 approches:

* MDM only: avec la solution microsoft `Intune` ou une autre
* Co-management (hybrid): SCCM + MDM

Provisioning options:

* Self Service / OOBE
* Windows Autopilot
* Bulk Enrollment: via a provisionning package that applies to a large number of devices
    
Ajouter d'autres solutions MDM: `Azure Active Directory > Mobility (MDM and MAM) > Add application`

### Fonctionalité Intune

* Mobile Threat Defense (Microsoft Defender ou autres Anti virus)
* Built in reporting
* Intune Admin Center : `Policies` (security rules, App protection, Device Configuration, Compliances, Conditional Access...)


## Basics of Enterprise State Roaming

With Enterprise State Roaming, users' settings and application data follow them when they switch devices : `Azure Active Directory > Devices > Enterprise State Roaming`

* Stale Data= 1year
* deleted retention= 90jours

## Self-service password reset steps

Configuration : `Active Directory > Password reset`

* Localization: The portal checks the browser's locale setting and renders the SSPR page in the appropriate language.
* Verification: The user enters their username and passes a captcha to ensure that it's a user and not a bot.
* Authentication: The user enters the required data to authenticate their identity. They might, for example, enter a code or answer security questions.
* Password reset: If the user passes the authentication tests, they can enter a new password and confirm it.
* Notification: A message is usually sent to the user to confirm the reset.

### SSPR methods

* Mobile App notification
* Mobile App code
* Email (external)
* Mobile phone
* Office phone
* Security Questions

## Protocoles et outils en cloud hybride (co-managé)

> Attention aux risques de pivots en cas d'intrusion.

| Windows Server AD	 | Azure AD / Entra ID |
|--------------------|----------|
| LDAP | Rest APIs |
| NTLM | OAuth/SAML |
| Kerberos | OpenID |
| OU Tree | Flat Structure |
| Domains and Forests | Tenants |
| Trusts | Guests |

Dans le cas **hybride** il existe plusieurs solutions de synchronisation 

* Microsoft Entra Connect (Azure AD Connect) 
* Microsoft Entra Cloud Sync.

Côté local on utilise toujours l'`AD` et les solutions tels que `Configuration Manager`

Coté Azure on à le `centre d’administration Microsoft Entra` et le `MDM (Intune)`,

Les clients restent alors managés via l' `AD local` **et** ont joint `l'AAD / Entra ID`
