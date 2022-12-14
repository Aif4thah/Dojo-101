# Azure AD

## Auth:
    SAML
    Oauth
    Open ID
    WS Federation


An Azure AD directory can be associated with multiple subscriptions, but a subscription is always tied to a single directory.

Azure AD Connect is a separate service that allows you to synchronize a traditional Active Directory with your Azure AD instance


## Azure AD connection:

Connect-AzAccount
When run, this cmdlet will present a token string. To sign in, copy this string and paste it into https://microsoft.com/devicelogin in a browser. Your PowerShell session will be authenticated to connect to Azure.




## Create user:

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

## Create Group:
    New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"

ROLE = Colection of permission
    role definition lists the operations that can be performed, such as read, write, and delete.
   
    Built-in Roles for Azure Resources (USES POWERSHELL)
        Owner, which has full access to all resources, including the right to delegate access to others.
        Contributor, which can create and manage all types of Azure resources but can’t grant access to others.
        Reader, which can view existing Azure resources.

        Get-AzureRmRoleDefinition -Name Owner

        ex role definition:
            {
            "Name": "Contributor",
            "Id": "b24988ac-6180-42a0-ab88-20f7382dd24c",
            "IsCustom": false,
            "Description": "Lets you manage everything except access to resources.",
            "Actions": [
                "*"
            ],
            "NotActions": [
                "Microsoft.Authorization/*/Delete",
                "Microsoft.Authorization/*/Write",
                "Microsoft.Authorization/elevateAccess/Action"
            ],
            "DataActions": [],
            "NotDataActions": [],
            "AssignableScopes": [
                "/"
            ]
            }

    TABLE 1
    Name	Description
    Id	Unique identifier for the role, assigned by Azure.
    IsCustom	True if this is a custom role, False if this is a built-in role.
    Description	A readable description of the role.
    Actions []	Allowed permissions, * indicates all.
    NotActions []	Denied permissions.
    DataActions []	Specific allowed permissions as applied to data, for example Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read
    NotDataActions []	Specific denied permissions as applied to data.
    AssignableScopes []	Scopes where this role


    Actions and NotActions

        You can tailor the Actions and NotActions properties to grant and deny the exact permissions you need. 
        These are always in the format: {Company}.{ProviderName}/{resourceType}/{action}.
    
    DataActions and NotDataActions

       Data operation	Description
        Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete	Delete blob data
        Microsoft.Compute/virtualMachines/login/action	Log in to a VM as a regular user
        Microsoft.EventHub/namespaces/messages/send/action	Send messages on an event hub
        Microsoft.Storage/storageAccounts/fileServices/fileshares/files/read	Return a file/folder or list of files/folders
        Microsoft.Storage/storageAccounts/queueServices/queues/messages/read	Read a message from a queue 

## Delete account:
    Remove-AzureADUser

    (pourra etre restoré sous 30 jours)

## Role:
    Administrator roles:
        User Administrator
        Global Administrator
    
    Member users: user standard, impossible de manager les autres users

    Guest users: restreint, utilisé pour la collaboration avec d'autres organisation

        By default, users and administrators in Azure AD can invite guest users. But this ability can be limited or disabled by the Global Administrator.

Access management in Azure AD
    Azure AD roles: Use Azure AD roles to manage Azure AD-related resources like users, groups, billing, licensing, application registration, and more.
    Role-based access control (RBAC) for Azure resources: Use RBAC roles to manage access to Azure resources like virtual machines, SQL databases, or storage. For example, you could assign an RBAC role to a user to manage and delete SQL databases in a specific resource group or subscription.


There are different ways you can assign access rights:

    Direct assignment: Assign a user the required access rights by directly assigning a role that has those access rights.
    Group assignment: Assign a group the required access rights, and members of the group will inherit those rights.
    Rule-based assignment: Use rules to determine a group membership based on user or device properties. For a user account or device's group membership to be valid, the user or device must meet the rules. If the rules aren't met, the user account or device's group membership is no longer valid. The rules can be simple. You can select prewritten rules or write your own advanced rules.



OpenID: standart pour l'authent, couche au dessus de Oauth pour la vérification des identitiés
Token: JWT, identity providers sign the token

    When you implement OpenID Connect, you must obtain a client ID for your application by creating an application registration in Azure AD. You then copy the client ID into the application's configuration files. In the application registration, you will also include the URI of the web application so that Azure AD can redirect the client successfully.

Azure AD tenant: instance of Azure AD. chaque tenant est indépendant

Pour utilser OpenID:
    - Create Azure AD tenant
    - Register Web application:
            Name. This value identifies the registration and application.
            Application type. Use the Web app/API type for websites or web APIs that are accessed through the HTTP protocol. Use the Native type for applications that are installed on a user's device or computer.
            Sign-on URL. This value is the location of the sign-on page in the published application.
            Application ID. This generated GUID is unique to the registration. Configure your application to send the same GUID to Azure AD whenever it authenticates a user.
    - Configure App authentication ( avec les ID donnés lors de l'enregistrement)
            <domain-name>	Your Azure AD tenant name
            <TenantID-GUID>	The directory (tenant) ID that you noted in the previous exercise
            <ClientID-GUID>	The application (client) ID that you noted in the previous exercise


Password complexity rules. This will force users to generate hard(er)-to-guess passwords.

Password expiration rules. You can force users to change their passwords on a periodic basis (and avoid using previous-used passwords).

Self-service password reset (SSPR). This allows users to self-serve and reset their password if they have forgotten it without involving an IT department.

Azure AD Identity Protection. To help protect your organization's identities, you can configure risk-based policies that automatically respond to risky behaviors. These policies can either automatically block the behaviors or initiate remediation, including requiring password changes.

Azure AD password protection. You can block commonly used and compromised passwords via a globally banned-password list.

Azure AD smart lockout. Smart lockout helps lock out malicious hackers who are trying to guess your users’ passwords or use brute-force methods to get in. It recognizes sign-ins coming from valid users and treats them differently than the ones of malicious hackers and other unknown sources.

Azure AD Application Proxy. You can provision security-enhanced remote access to on-premises web applications.

Single sign-on (SSO) access to your applications. This includes thousands of pre-integrated SaaS apps.

Azure AD Connect. Create and manage a single identity for each user across your hybrid enterprise, keeping users, groups, and devices in sync.


## Azure MFA:
    Something you know - which might be a password or the answer to a security question.
    Something you possess - which might be a mobile app that receives a notification or a token-generating device.
    Something you are - which typically is a biometric property, such as a fingerprint or face scan used on many mobile devices.

    Multi-Factor Authentication comes as part of the following offerings:

    Azure Active Directory Premium or Microsoft 365 Business - Both of these offerings support Azure Multi-Factor Authentication using Conditional Access policies to require multi-factor authentication.

    Azure AD Free or standalone Office 365 licenses - Use pre-created Conditional Access baseline protection policies to require multi-factor authentication for your users and administrators.

    Azure Active Directory Global Administrators - A subset of Azure Multi-Factor Authentication capabilities are available as a means to protect global administrator accounts.

    Option MFA:
    Mobile App Verification code 
    Call to a phone
    Text message to a phone


    Pour configurer MFA: Azure directory -> Security -> MFA
    Pour crée un Conditional Access: Azure Active Directory > Security > Conditional access Puis Group + Apps/Action + condition
    
    Ou selectionner un User puis Multi-Factor Authentication



## Device Identity:
    - AAD Registred: BYOD - Pas forcement Managé mais configuration des appli, ex Exchange
    - AAD Joined: owned by the organisation, device indenty only in the cloud
    - Hybrid AAD joined:  device on-premise and in the cloud


    Configuration: Security -> Conditional Access


## MDM:
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

### SSPR steps:
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


## DNS (add domain name to AAD)
    AAD -> custom domain name, à faire verifier par Azure, les sous domaine aussi
        pour cela Azure fourni un MX ou TXT à ajouter via le providers

    Le default domain sera <nom>.onmicrosoft.com (si pas custom DNS)

    Un domaine = 1 AD
    1 AD = 900 Domaines