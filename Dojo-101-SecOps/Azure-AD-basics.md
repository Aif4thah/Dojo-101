# Azure AD Basics

## Auth:

* SAML
* Oauth
* Open ID
* WS Federation
* Azure AD Connect is a separate service that allows you to synchronize a traditional Active Directory with your Azure AD instance

## Subscription et tenant

* Azure AD tenant: instance of Azure AD. chaque tenant est indépendant
* An Azure AD directory can be associated with multiple subscriptions, but a subscription is always tied to a single directory.

## Azure AD connection:

`Connect-AzAccount`


## Create user:

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

## Create Group:

```powershell
    New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"
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


## Delete account:

```powershell
Remove-AzureADUser
```
(pourra etre restoré sous 30 jours)

## Pricipaux Roles:

Administrator roles:
* User Administrator
* Global Administrator
    
Member users: user standard, impossible de manager les autres users

Guest users: restreint, utilisé pour la collaboration avec d'autres organisation

By default, users and administrators in Azure AD can invite guest users. But this ability can be limited or disabled by the Global Administrator.

## Access management in Azure AD

Azure AD roles: Use Azure AD roles to manage Azure AD-related resources like users, groups, billing, licensing, application registration, and more.

Role-based access control (RBAC) for Azure resources: Use RBAC roles to manage access to Azure resources like virtual machines, SQL databases, or storage. 
For example, you could assign an RBAC role to a user to manage and delete SQL databases in a specific resource group or subscription.


There are different ways you can assign access rights:

* Direct assignment: Assign a user the required access rights by directly assigning a role that has those access rights.
* Group assignment: Assign a group the required access rights, and members of the group will inherit those rights.
* Rule-based assignment: Use rules to determine a group membership based on user or device properties.

## session management

* OpenID: standart pour l'authent, couche au dessus de Oauth pour la vérification des identitiés
* Token: JWT, identity providers sign the token

## Open ID

Pour utilser OpenID:
1. Create Azure AD tenant
2. Register Web application:
            Name. This value identifies the registration and application.
            Application type. Use the Web app/API type for websites or web APIs that are accessed through the HTTP protocol. Use the Native type for applications that are installed on a user's device or computer.
            Sign-on URL. This value is the location of the sign-on page in the published application.
            Application ID. This generated GUID is unique to the registration. Configure your application to send the same GUID to Azure AD whenever it authenticates a user.
3. Configure App authentication ( avec les ID donnés lors de l'enregistrement)
            <domain-name>	Your Azure AD tenant name
            <TenantID-GUID>	The directory (tenant) ID that you noted in the previous exercise
            <ClientID-GUID>	The application (client) ID that you noted in the previous exercise


## Azure MFA:


* Mobile App Verification code 
* Call to a phone
* Text message to a phone


## Device Identity:

Configuration: Security -> Conditional Access

* AAD Registred: BYOD - Pas forcement Managé mais configuration des appli, ex Exchange
* AAD Joined: owned by the organisation, device indenty only in the cloud
* Hybrid AAD joined:  device on-premise and in the cloud


## Mobile Device management:

    AAD join uses MDM, 2 approches:
        - MDM only: ex intune
        - Co management: SCCM + MDM

    Provisioning options:
            Self Service / OOBE
            Windows Autopilot
            Bulk Enrollment: via a provisionning package that applies to a large number of devices
    
    Settings:
        Azure Active Directory > Devices > Device settings.

    Ajouter d'autres solution MDM:
        Azure Active Directory > Mobility (MDM and MAM) > Add application.

    ! un device peu joindre Azure AD sans etre managé par un MDM

### Basics of Enterprise State Roaming

    With Enterprise State Roaming, users' settings and application data follow them when they switch devices.
    Azure Active Directory > Devices > Enterprise State Roaming.
    Stale Data= 1year
    deleted retention= 90jours

## Self-service password reset steps:

    Localization: The portal checks the browser's locale setting and renders the SSPR page in the appropriate language.
    Verification: The user enters their username and passes a captcha to ensure that it's a user and not a bot.
    Authentication: The user enters the required data to authenticate their identity. They might, for example, enter a code or answer security questions.
    Password reset: If the user passes the authentication tests, they can enter a new password and confirm it.
    Notification: A message is usually sent to the user to confirm the reset.

### SSPR methods:

    Mobile App notification
    Mobile App code
    Email (external)
    Mobile phone
    Office phone
    Security Questions

### Configure SSPR:

    Active Directory > Password reset
