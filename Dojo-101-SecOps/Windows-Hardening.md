# Durcissement / Hardening Windows

## Microsoft Security Compliance Toolkit (baseline)

* Permets appliquer une GPO localement (même sans domaine AD, grace à LGPO.exe) avec les recommandations de Microsoft. 
* On peut ensuite analyzer et comparer les GPO.
* Des scripts pour MS365 et Edge sont également disponibles.

[MSCT](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10)

[Download](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

### exemple pour un windows 11 standalone

```powershell
.\Baseline-LocalInstall.ps1 -Win11NonDomainJoined
```

## Alternative: Editer manuellement la politique de sécurité locale ou la GPO du domaine AD

`Gpedit.msc` ou `SecPol.msc`

