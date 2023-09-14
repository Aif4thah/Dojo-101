# Durcissement / Hardening Windows

## Microsoft Security Compliance Toolkit (A privilégier)

Permets appliquer une GPO localement (même sans domaine AD, grace à LGPO.exe) avec les recommandations de Microsoft. 
On peut ensuite analyzer et comparer les GPO.

[MSCT](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10)

[Download](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

## Editer la politique de sécurité locale

`Gpedit.msc` ou `SecPol.msc`

## Script (mode dégradé)

cf. script hardening powershell