# Durcissement / Hardening Windows

## Microsoft Security Compliance Toolkit (baseline)

* Permets d'appliquer une GPO localement (même sans domaine AD, grace à LGPO.exe) avec les recommandations de Microsoft. 
* On peut ensuite analyzer et comparer les GPO.
* Des scripts pour MS365 et Edge sont également disponibles.

[MSCT](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10)

[Download](https://www.microsoft.com/en-us/download/details.aspx?id=55319)


### exemple pour un windows 11 standalone 

Avec "Windows 11 Security Baseline" et "LGPO":

```powershell
.\Baseline-LocalInstall.ps1 -Win11NonDomainJoined
```
Une GPO locale sera importée, y compris sur une édition Famille.


### exemple sur un Windows 2022 Controleur de domaine

Avec Windows Server 2022 Security Baseline

```powershell
.\Baseline-ADImport.ps1
```
Importe des GPO intitulées "MSFT*" dans "Objets de strategie de groupe". Elle sont ensuite à appliquer.


## Alternative: éditer manuellement la politique de sécurité locale ou la GPO du domaine AD

à l'aide d'un guide ANSSI, CIS ou autre

`Gpedit.msc` ou `SecPol.msc`

