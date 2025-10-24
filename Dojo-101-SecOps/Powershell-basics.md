# powershell basics

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

## Logs et historique

```powershell
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational"
Get-Content ~\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```

## installation sous linux

```bash
apt install powershell
pwsh 
```

## Variable d'environnement

```powershell
$pwd
$env:COMPUTERNAME
$env:USERNAME
$env:USERDOMAIN
$PsVersionTable
$PsVersionTable.PSVersion
$pid
ls variable:
```

## variables

```powershell
$var = 'chaine de charactères'
$var.gettype() #obtenir le type
$var |gm #lister les membres (proprietés et fonctions)
```

## tableau

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
for($i=0; $i -le 5;$i++){ write "`$i vaut : $i" }
foreach( $a in $var ){ write-host $a -ForegroundColor grey }
1..100 |%{ $_  }
ls |%{ $_.FullName }
```

## chercher une commande

```powershell
gcm *bitlocker*
help Unlock-BitLocker
help Unlock-BitLocker -ShowWindow
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
Set-ExecutionPolicy -ExecutionPolicy Restricted # en admin
```

## Contournement de l'executionPolicy

```powershell
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File test.ps1
gc .\test.ps1 |iex
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
```

## Update

```powershell
Get-Hotfix
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

## activation des logs powershells

```powershell
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value 1
cd 'C:\Program Files\PowerShell\7'
.\RegisterManifest.ps1
```

### succès et echecs d'authent

En tant qu'Admin :

```powershell
Get-WinEvent -FilterHashtable @{
  LogName='Security'
  Id=4624,4625
  StartTime = [datetime]::Now.AddDays(-7)
} -MaxEvents 10
```

## sécurité de la mémoire

```powershell
Get-Processmitigation
Set-Processmitigation -System -Enable DEP,BottomUp,SEHOP #pas d'autres options pour limiter les effets de bord ; pose pbm avec virtualbox ? 
Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 
```

## Registry

```powershell
get-psdrive
Get-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0
```

## Features

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
```

## Pare-feu

```powershell
Get-NetFirewallProfile 
Get-NetConnectionProfile 
gcm *Firewall*
```

## Windows Defender

```powershell
Get-MpComputerStatus
Get-MpPreference
```

## Installer et utiliser un module vu sur powershell Gallery

```powershell
Import-Module PowerShellGet
Install-Module -Name AOVPNTools
gcm -Module AOVPNTools
Get-TlsCertificate -Hostname taisen.fr
```

## intefrité

Calculer et vérifier un hash

```powershell
"F68E37DC9CABF2EE8B94D6A5D28AD04BE246CCC2E82911F8F1AC390DCF0EE364" -eq (Get-FileHash .\test -Algorithm SHA256).Hash
```

Vérifier la signature des binaires :

```powershell
 Get-AuthenticodeSignature C:\Windows\System32\cmd.exe
```

### certificats (quick and dirty)

```powershell
New-SelfSignedCertificate -DnsName Ucshiwa.lan -CertStoreLocation Cert:\CurrentUser\My\  -KeyAlgorithm RSA -KeyLength 4096 -NotAfter $(Get-Date).AddYears(30)
certmgr.msc # export the generated certificate as password protected .pfx file 
```

### Signature

```pwsh
#$cert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -Subject "CN=ScriptSigningCert" -KeyUsage DigitalSignature -Type CodeSigningCert
$Cert = Get-ChildItem Cert:\CurrentUser\My | Where-Object { $_.Subject -like "*ScriptSigningCert*" }
Set-AuthenticodeSignature -FilePath "script.ps1" -Certificate $cert
```

## requete wmi

```powershell
Get-CimInstance -ClassName Win32_BIOS
```

## requete cim

```powershell
Get-CimInstance -ClassName Win32_Service 
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

appeler la fonction

```powershell
Copier coller la fonction ou faire `. .\fichier.ps1`
Help Get-NimporteQuoi
Get-NimporteQuoi -parametre1 aaaaa -parametre2 bbbbb
Get-NimporteQuoi
```

## compiler et utiliser une dll

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

### lancement de thread avec get-job

```powershell
$job = Start-Job -ScriptBlock { Get-WinEvent -Log System }
$job | Select-Object -Property *
Stop-Job $job
```
