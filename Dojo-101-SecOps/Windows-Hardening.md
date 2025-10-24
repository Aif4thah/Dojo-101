# Audit et Durcissement / Hardening Windows et AD

## Windows AD

* [Guide ANSSI AD](https://cyber.gouv.fr/publications/recommandations-pour-ladministration-securisee-des-si-reposant-sur-ad)

* [PingCastle](https://www.pingcastle.com/)

* [bloodhound](https://github.com/SpecterOps/BloodHound)
* [Sharphound](https://github.com/BloodHoundAD/SharpHound)

* [AdCheck](https://github.com/CobblePot59/ADcheck)

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

Mode audit :

```powershell
Invoke-HardeningKitty -Mode Audit -Log -Report
```

Backup avant application (fichier list à mettre à jour avant d'éxecuter le script) :

```powershell
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_Machine.csv" -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv"
Invoke-HardeningKitty -Mode Config -Backup -BackupFile ".\Backup_$($env:COMPUTERNAME)_$(Get-Date -Format yyyyMMdd-hhmm)_User.csv" -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv"
```

Durcissement :

```powershell
Invoke-HardeningKitty -Mode HailMary -FileFindingList "./lists/finding_list_msft_security_baseline_windows_11_24h2_user.csv" -Log -Report
```

## PingCastle

```powershell
./PingCastle.exe --healthcheck --server <domain.lan>
```

## Automatisation

* GPO
* Ansible
* Powershell DSC

## Manuellement

`Gpedit.msc` ou `SecPol.msc`

### Tips Registry

désactivation des null sessions

```powershell
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2
```

Rescriction NTLM

```powershell
New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2
```

désactivation WDigest (désactivé par défaut on écrase juste la valeur si elle éxiste)

```powershell
Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -ea SilentlyContinue
```

Configuration SMB

```powershell
get-SmbShare
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force
```

Désactivation du protocole netbios

```powershell
$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces" 
Get-ChildItem $r |ForEach-Object{ Set-ItemProperty -Path "$r\$($_.pschildname)" -Name NetbiosOptions -Value 2 }
```

Désactivation du protocole LLMNR - DNS multicast

```powershell
New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0
```

Désactivation du protocole WPAD

```powershell
New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1
```

Suppréssion du PageFile lors de l’arret du systèm

```powershell
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -name ClearPageFileAtShutdown -Value 1
```

Désactivation du sous-sytème linux

```powershell
Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove
```

Désactivation du partage de connection SharedAccess

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4
```

Désactivation de WinRM

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4
```

désactivation RDP

```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1
```

configuration de l'UAC au niveau 3

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "ConsentPromptBehaviorAdmin" -Value 2 
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "PromptOnSecureDesktop" -Value 1
```

verification que le "always install with elevated" est désactivé

```powershell
remove-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer -name AlwaysInstallElevated -ea SilentlyContinue
```

### Tips Features

désactivation de powershellv2

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
```
