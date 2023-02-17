# Initiation au scripting powershell

## clavier en français


Set-WinUserLanguageList -Force 'fr-FR'


## version


$PsVersionTable.PSVersion


## variables

$var = 'chaine de charactères'
$var.gettype() #obtenir le type
$var |gm #lister les membres (proprietés et fonctions)


## saisies utilisateurs


$var = Read-Host "saisissez une valeur"
$var = (read-host ">>>").ToString()


### stocker une saisie de manière sécurisée


$Secure = Read-Host "saisissez un secret" -AsSecureString


## afficher


write-host ("[!] ceci est la valeur de ma variable : {0}" -f $var) -ForegroundColor Cyan


## conditions et booléens


if($var.Contains('a')){ $true }else{ $false }


## la boucle (quick and dirty)


1..100 |%{ $_  }
ls |% { $_.FullName }


## chercher une commande


gcm *bitlocker*


## formater un resultat


get-date
get-date |ft *
get-date |fl *

## Transformer un resultat


get-date |ConvertTo-Csv
get-date |ConvertTo-Json
get-date |ConvertTo-html


## Transformer en objet


$json = get-date |ConvertTo-Json
$json |ConvertFrom-Json


## Réseau

Test-NetConnection -Port 443 google.fr
Test-NetConnection google.fr -TraceRoute
iwr https://google.fr
iwr https://raw.githubusercontent.com/Aif4thah/CShidori/main/LICENSE -outfile .\LICENSE

## Excrite, lire


write "write-host 'coucou' -foregroundColor Cyan" > test.ps1
gc test.ps1


## Lire les permission

get-acl .\test.ps1 |fl


## Execution policy

Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy Restricted


## Contournement de l'executionPolicy


powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File test.ps1
gc .\test.ps1 |iex


## services

Get-Service |% { if($_.status -eq "running"){ $_.name } }
Get-Service | where Status -eq "running"
Get-Service -name bthserv | select -property name,status,starttype


## process

ps


## user

Get-LocalUser


## logs


Get-EventLog -LogName *


## registry


get-psdrive
Get-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0




## sécurité de la mémoire


Get-Processmitigation
Set-Processmitigation -System -Enable DEP,BottomUp,SEHOP #pas d'autres options pour limiter les effets de bord ; pose pbm avec virtualbox ? 
Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 



## désactivation des « null sessions » :

Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2


## Rescriction NTLM

New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2


## désactivation WDigest (désactivé par défaut on écrase juste la valeur si elle éxiste)

Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -ea SilentlyContinue


## Configuration SMB :

get-SmbShare
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force


## Désactivation du protocole netbios

$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces" 
Get-ChildItem $r |ForEach-Object{ Set-ItemProperty -Path "$r\$($_.pschildname)" -Name NetbiosOptions -Value 2 }


## Désactivation du protocole LLMNR - DNS multicast

New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0

## Désactivation du protocole WPAD

New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1


## Suppréssion du PageFile lors de l’arret du systèm

Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -name ClearPageFileAtShutdown -Value 1


## Désactivation du sous-sytème linux:

Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove


## Désactivation du partage de connection SharedAccess

Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4


## Désactivation de WinRM

Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4


## désactivation RDP

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1


## désactivation de powershellv2

Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart


## Configuration Pare-feu

Get-NetFirewallProfile 
Get-NetConnectionProfile 
gcm *Firewall*



## Configuration de Windows Defender

Get-MpPreference


#configuration de l'UAC au niveau 3


Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "ConsentPromptBehaviorAdmin" -Value 2 
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "PromptOnSecureDesktop" -Value 1


# verification que le "always install with elevated" est désactivé

remove-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer -name AlwaysInstallElevated -ea SilentlyContinue


## activation des logs powershells

Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value 1
cd 'C:\Program Files\PowerShell\7'
.\RegisterManifest.ps1


## creer une fonction et l'importer



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


### appeler une fonction
Copier coller la fonction ou faire `. .\fichier.ps1`


Help Get-NimporteQuoi
Get-NimporteQuoi -parametre1 aaaaa -parametre2 bbbbb
Get-NimporteQuoi


### intefrité


"F68E37DC9CABF2EE8B94D6A5D28AD04BE246CCC2E82911F8F1AC390DCF0EE364" -eq (Get-FileHash .\test -Algorithm SHA256).Hash


### signature


        $message = "<votre message"
        $hmacsha = New-Object System.Security.Cryptography.HMACSHA256
        $hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secret)
        $signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($message))
        $signature = [Convert]::ToBase64String($signature)
        write-host -ForegroundColor Cyan $signature


### certificat (quick and dirty)

New-SelfSignedCertificate -DnsName Ucshiwa.lan -CertStoreLocation Cert:\CurrentUser\My\  -KeyAlgorithm RSA -KeyLength 4096 -NotAfter $(Get-Date).AddYears(30)
certmgr.msc # export the generated certificate as password protected .pfx file 


### requete wmi


Get-CimInstance -ClassName Win32_BIOS

### requete cim

Get-CimInstance -ClassName Win32_Service 

### compiler et utiliser une dll


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


### thread avec get-job

$job = Start-Job -ScriptBlock { Get-WinEvent -Log System }
$job | Select-Object -Property *


