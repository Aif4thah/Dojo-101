# Audit et Durcissement / Hardening Windows et AD


## Windows AD

* [Guide ANSSI AD](https://cyber.gouv.fr/publications/recommandations-pour-ladministration-securisee-des-si-reposant-sur-ad)

* [PingCastle](https://www.pingcastle.com/)

* [bloodhound](https://github.com/SpecterOps/BloodHound)
* [Sharphound](https://github.com/BloodHoundAD/SharpHound)

* [Nuclei](https://github.com/projectdiscovery/nuclei)

* [SharpView](https://github.com/tevora-threat/SharpView)

* [ADRecon](https://github.com/adrecon/ADRecon)

* [Goup3r](https://github.com/Group3r/Group3r)


## Windows StandAlone

* [HardeningKitty)](https://github.com/scipag/HardeningKitty)

* [Privesc](https://github.com/carlospolop/PEASS-ng)

* [Privesc bins](https://lolbas-project.github.io/)

* [Persistance snipper](https://github.com/last-byte/PersistenceSniper)


## Microsoft Security Compliance Toolkit (MSCT)

* [MSCT](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10)

* [Download](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

* Permets d'appliquer une **baseline** par GPO localement (même sans domaine AD, grâce à LGPO.exe) avec les recommandations de Microsoft. 

* On peut ensuite **Auditer** en comparant la GPO actuelle et la GPO recommandée.

* Des scripts pour MS365 et Edge sont également disponibles.


### Prérequis 

* RSAT et module GroupPolicy

### Comparer les GPOs

**PolicyAnalyzer** permet la comparaison des GPO :

* L'import de GPO se fait via `Add -> File -> Import Via GPOs`, les dossiers GPOs se trouvent dans chaque dossier de **Baseline**

* La **GPO** peut être comparée avec l' **effective policy** en place sur la machine locale.


### Exemple pour un Windows 11 standalone 

* poser LGPO.exe dans `./Scripts/Tools/`

Avec "Windows 11 Security Baseline" et "LGPO" :

```powershell
.\Baseline-LocalInstall.ps1 -Win11NonDomainJoined
```

Une GPO locale sera importée, y compris sur une édition Famille.


### Exemple sur un Windows 2022 Contrôleur de domaine

Avec Windows Server 2022 Security Baseline

```powershell
.\Baseline-ADImport.ps1
```

Importe des GPO intitulées "MSFT*" dans "Objets de stratégie de groupe". Elles sont ensuite à appliquer.


## HardeningKitty

```powershell
Import-Module .\HardeningKitty.psm1
```

### Audit

```powershell
Invoke-HardeningKitty -Mode Audit -Log -Report
```

### backup avant application

Fichier list à mettre à jour avant d'éxecuter le script

```powershell
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_Machine.csv" -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv"
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_User.csv" -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv"
```

### Durcissement

```powershell
Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv"
```


## Manuellement

`Gpedit.msc` ou `SecPol.msc`

## Automatisation

* GPO

* Ansible

* Powershell DSC
