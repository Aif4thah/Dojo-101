# powershell basics: Initiation au scripting powershell

## clavier en français

```powershell
Set-WinUserLanguageList -Force 'fr-FR'
```

## commentaires

```powershell
#commentaire
<#
commentaires
#>
```

## installation sous linux

```bash
apt install powershell
pwsh 
```

## version

```powershell
$PsVersionTable
$PsVersionTable.PSVersion
```

## variables

```powershell
$var = 'chaine de charactères'
$var.gettype() #obtenir le type
$var |gm #lister les membres (proprietés et fonctions)
```

# tableau

```powershell
$var = @( 1,2,3 )
```

## hashtable

```powershell
$hash = @{ Number = 1; Shape = "Square"; Color = "Blue"}
```

## afficher

```powershell
write-host "coucou $a" -foregroundColor Cyan
write-host 'coucou $a' -foregroundColor Cyan
write-host ("[!] ceci est la valeur de ma variable : {0}" -f $var) -ForegroundColor Cyan
```

## saisies utilisateurs

```powershell
$var = Read-Host "saisissez une valeur"
$var = (read-host ">>>").ToString()
```

### stocker une saisie de manière sécurisée

```powershell
$Secure = Read-Host "saisissez un secret" -AsSecureString
Get-Credential
```

## conditions et booléens

```powershell
if($var.Contains('a')){ $true }else{ $false }
```

## condition ternaire (pwsh => 7)

```powershell
$var.Contains('a') ? $true : $false
```

## la boucle (quick and dirty)

```powershell
foreach( $a in $var ){ write-host $a -ForegroundColor grey }
1..100 |%{ $_  }
ls |%{ $_.FullName }
```

## chercher une commande

```powershell
gcm *bitlocker*
help Unlock-BitLocker
alias %
```

## formater un resultat

```powershell
get-date
get-date |ft *
get-date |fl *
```

## comparer un resultat

```powershell
$a = ps; code ; $b = ps
Compare-Object -ReferenceObject $a -DifferenceObject $b

## Transformer un objet

```powershell
get-date | ConvertTo-Csv
get-date | ConvertTo-html
```

## Manipuler les fichiers et les objets

```powershell
Get-PSDrive |ConvertTo-Json > test.json
cat .\test.json | ConvertFrom-Json
```

## Storage

```powershell
get-disk
get-volume
get-psdrive
Get-SmbShare
```

## IP

```powershell
Get-NetIPAddress
(Get-NetIPAddress).IPAddress
Get-NetIPAddress |select -Property Ipaddress,AddressFamily |? AddressFamily -eq "IPV4"
```

## cartes réseaux 

```powershell
Get-NetAdapter
Get-NetAdapter -ifIndex 21 |Get-NetConnectionProfile
```

### test de connection 

```powershell
Test-NetConnection -Port 443 google.fr
Test-NetConnection google.fr -TraceRoute
442..443 |%{Test-NetConnection -Port $_ google.fr  } | where -Property "TcpTestSucceeded" -eq $true
```

## Web

```powershell
Invoke-WebRequest https://google.fr
iwr https://raw.githubusercontent.com/Aif4thah/dojo-101/main/LICENSE -outfile .\LICENSE
```

## API

### headers

```powershell
$headers = @{'x-apikey' = $VTApiKey }
Invoke-RestMethod -Headers $headers "https://www.virustotal.com/api/v3/search?query=$hash"
```

### body

```powershell
Invoke-RestMethod -method Post -uri https://localhost:3000/Auth -Body '{"user":"test", "passwd":"test"}' -ContentType application/json
```

### url decode

```powershell
Add-Type -AssemblyName System.Web
[System.Web.HttpUtility]::UrlDecode("%27%20or%20%271%27%3D%271")
```

### base 64

```powershell
[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("write coucou"))
[System.Text.Encoding]::Unicode.GetString([convert]::FromBase64String("dwByAGkAdABlACAAYwBvAHUAYwBvAHUA"))
```

### execution de base 64 directement

```powershell
powershell -encodedCommand dwByAGkAdABlACAAYwBvAHUAYwBvAHUA
```

## Ecrire, lire

```powershell
write "write-host 'coucou' -foregroundColor Cyan" > test.ps1
gc test.ps1
gc test.ps1 | Format-Hex
```

en cas de pbm d'encodage:

```powershell
$content |Set-Content -Path $urlsFfuffed -Encoding utf8
$content | Add-Content -Path $urlsFfuffed -Encoding ascii
```
## regex

```powershell
$regex =  "(http|https)://([A-Za-z0-9._%-]*)(/([A-Za-z0-9._%-]*)*)?"
$urls = gc ./resultats/*  | Select-String -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value }
```

## Lire les permissions

### NTFS

```powershell
get-acl .\test.ps1 |fl
(Get-Acl .\test.ps1).Access
```

### copier des permissions

```powershell
Get-Acl -Path ".\test1.txt" | Set-Acl -Path ".\test2.txt"
```

### SMB

```powershell
Get-SmbShare c$ |Get-SmbShareAccess
```

## Execution policy

```powershell
Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy Restricted
```

## Contournement de l'executionPolicy

```powershell
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File test.ps1
gc .\test.ps1 |iex
```

## services

```powershell
Get-Service |% { if($_.status -eq "running"){ $_.name } }
Get-Service | where Status -eq "running"
Get-Service -name bthserv | select -property name,status,starttype
```

## processus

```powershell
get-process |ft *
```

## users locaux

```powershell
Get-LocalUser
Get-LocalGroup Admin* |Get-LocalGroupMember
```

## logs

```powershell
Get-EventLog -List
Get-EventLog -LogName "Security"
```

## volume registry

```powershell
get-psdrive
Get-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0
```

## sécurité de la mémoire

```powershell
Get-Processmitigation
Set-Processmitigation -System -Enable DEP,BottomUp,SEHOP #pas d'autres options pour limiter les effets de bord ; pose pbm avec virtualbox ? 
Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 
```

## désactivation des « null sessions » :

```powershell
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2
```

## Rescriction NTLM

```powershell
New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2
```

## désactivation WDigest (désactivé par défaut on écrase juste la valeur si elle éxiste)

```powershell
Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -ea SilentlyContinue
```

## Configuration SMB :

```powershell
get-SmbShare
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force
```

## Désactivation du protocole netbios

```powershell
$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces" 
Get-ChildItem $r |ForEach-Object{ Set-ItemProperty -Path "$r\$($_.pschildname)" -Name NetbiosOptions -Value 2 }
```

## Désactivation du protocole LLMNR - DNS multicast

```powershell
New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0
```

## Désactivation du protocole WPAD

```powershell
New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1
```

## Suppréssion du PageFile lors de l’arret du systèm

```powershell
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -name ClearPageFileAtShutdown -Value 1
```

## Désactivation du sous-sytème linux

```powershell
Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove
```

## Désactivation du partage de connection SharedAccess

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4
```

## Désactivation de WinRM

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4
```

## désactivation RDP

```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1
```

## désactivation de powershellv2

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
```

## Configuration Pare-feu

```powershell
Get-NetFirewallProfile 
Get-NetConnectionProfile 
gcm *Firewall*
```

## Configuration de Windows Defender

```powershell
Get-MpComputerStatus
Get-MpPreference
```

#configuration de l'UAC au niveau 3

```powershell
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "ConsentPromptBehaviorAdmin" -Value 2 
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "PromptOnSecureDesktop" -Value 1
```

# verification que le "always install with elevated" est désactivé

```powershell
remove-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer -name AlwaysInstallElevated -ea SilentlyContinue
```

## activation des logs powershells

```powershell
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value 1
cd 'C:\Program Files\PowerShell\7'
.\RegisterManifest.ps1
```

## déclarer une fonction

```powershell
function Get-NimporteQuoi
{
    <#
    .SYNOPSIS
        Demo

    .DESCRIPTION
        Demo

    .PARAMETER Parametre1
        string

    .PARAMETER Parametre2
        string

    .OUTPUTS
        Parametre1+Parametre2

    .EXAMPLE
        Get-NimporteQuoi -parametre1 aaaaa -parametre2 bbbbb

    #>
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $parametre1,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $parametre2   
    )
    begin
    {
        write-host "début"
    }
    Process
    {
        write-host $parametre1 $parametre2 
    }
    end
    { 
        write-host "fin"
    }
}
```

### appeler une fonction

```powershell
Copier coller la fonction ou faire `. .\fichier.ps1`
Help Get-NimporteQuoi
Get-NimporteQuoi -parametre1 aaaaa -parametre2 bbbbb
Get-NimporteQuoi
```

### intefrité

```powershell
"F68E37DC9CABF2EE8B94D6A5D28AD04BE246CCC2E82911F8F1AC390DCF0EE364" -eq (Get-FileHash .\test -Algorithm SHA256).Hash
```

### certificats (quick and dirty)

```powershell
New-SelfSignedCertificate -DnsName Ucshiwa.lan -CertStoreLocation Cert:\CurrentUser\My\  -KeyAlgorithm RSA -KeyLength 4096 -NotAfter $(Get-Date).AddYears(30)
certmgr.msc # export the generated certificate as password protected .pfx file 
```

### requete wmi

```powershell
Get-CimInstance -ClassName Win32_BIOS
```

### requete cim

```powershell
Get-CimInstance -ClassName Win32_Service 
```

### compiler et utiliser une dll

```powershell
$Source = @"
public class BasicTest
{
  public static int Add(int a, int b)
    {
        return (a + b);
    }
  public int Multiply(int a, int b)
    {
    return (a * b);
    }
}
"@

Add-Type -TypeDefinition $Source
[BasicTest]::Add(4, 3)
$BasicTestObject = New-Object BasicTest
$BasicTestObject.Multiply(5, 2)
```

### thread avec get-job

```powershell
$job = Start-Job -ScriptBlock { Get-WinEvent -Log System }
$job | Select-Object -Property *
Stop-Job $job
```

### firewall, exemple avec suppression des règles en doublon

```powershell
Get-NetFirewallRule | select -Property DisplayName | % {
    if ((Get-NetFirewallRule -DisplayName $_.DisplayName | measure).Count -gt 1) {
        $r1 = (Get-NetFirewallRule -DisplayName $_.DisplayName)[0]
        $r2 = (Get-NetFirewallRule -DisplayName $_.DisplayName)[1]
        if ($null -eq (Compare-Object $r1 $r2 -Property Profile, Enabled, Direction, Action, Group)) {
            if ($null -eq (Compare-Object ($r1 | Get-NetFirewallPortFilter) ($r2 | Get-NetFirewallPortFilter) -Property Protocol, LocalPort, RemotePort)) {
                if ($null -eq (Compare-Object ($r1 | Get-NetFirewallAddressFilter) ($r2 | Get-NetFirewallAddressFilter) -Property RemoteAddress, LocalAddress)) {
                    if ($null -eq (Compare-Object ($r1 | Get-NetFirewallApplicationFilter) ($r2 | Get-NetFirewallApplicationFilter) -Property Program )) {
                        write-host "$r2" -ForegroundColor Cyan
                        if ($null -eq (Compare-Object ($r1 | Get-NetFirewallServiceFilter) ($r2 | Get-NetFirewallServiceFilter) -Property Service )) {
                            if ($null -eq (Compare-Object ($r1 | Get-NetFirewallInterfaceFilter) ($r2 | Get-NetFirewallInterfaceFilter) -Property InterfaceAlias )) {
                                if ($null -eq (Compare-Object ($r1 | Get-NetFirewallSecurityFilter) ($r2 | Get-NetFirewallSecurityFilter) -Property LocalUser, Authentication, RemoteUser, RemoteMachine, Encryption )) {
                                    $r2 
                                    $r2 | Disable-NetFirewallRule -Confirm
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
```