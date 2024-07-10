# Durcissement / Hardening Windows

## Ressources

* [Guide ANSSI AD](https://cyber.gouv.fr/publications/recommandations-pour-ladministration-securisee-des-si-reposant-sur-ad)
* [bloodhound](https://github.com/SpecterOps/BloodHound)
* [Sharphound](https://github.com/BloodHoundAD/SharpHound)
* [PingCastle](https://www.pingcastle.com/)
* [ORAD](https://github.com/ANSSI-FR/ORADAD)
* [Nuclei](https://github.com/projectdiscovery/nuclei)
* [Privesc](https://github.com/carlospolop/PEASS-ng)
* [Privesc bins](https://lolbas-project.github.io/)


## Microsoft Security Compliance Toolkit (MSCT)

* [MSCT](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10)

* [Download](https://www.microsoft.com/en-us/download/details.aspx?id=55319)


* Permets d'appliquer une **baseline** par GPO localement (même sans domaine AD, grâce à LGPO.exe) avec les recommandations de Microsoft. 

* On peut ensuite **Auditer** en comparant la GPO actuelle et la GPO recommandée.

* Des scripts pour MS365 et Edge sont également disponibles.


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


## Manuellement

`Gpedit.msc` ou `SecPol.msc`

## Automatisation

* GPO

* Ansible

* Powershell DSC
