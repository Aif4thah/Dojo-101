# Durcissement / Hardening Windows

## Microsoft Security Compliance Toolkit (A privilégier)

Permets appliquer une GPO localement (même sans domaine AD, grace à LGPO.exe) avec les recommandations de Microsoft. 
On peut ensuite analyzer et comparer les GPO.

https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10

https://www.microsoft.com/en-us/download/details.aspx?id=55319

## Editer la politique de sécurité local

`Gpedit.msc` ou `SecPol.msc`

## Script (mode dégradé)

```Powershell
<#Windows Workstation Hardening Script 
en complement de la politique de sécurité local (SecPol.msc)
#>

#taille des logs

Limit-EventLog -LogName "Security" -MaximumSize (4*1024*1024*1024)

#execution policy (powershell -ep bypass t'façon)
Set-ExecutionPolicy -ExecutionPolicy Restricted

#Protection de la mémoire
#Set-Processmitigation -System -Enable DEP,BottomUp,SEHOP #pas d'autres options pour limiter les effets de bord ; pose pbm avec virtualbox ? 
#Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 

#désactivation des « null sessions » :
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1
Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2

#Rescriction NTLM
New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2

#désactivation WDigest (désactivé par défaut on écrase juste la valeur si elle éxiste)
Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -ea SilentlyContinue

#désactivation de l’autorun et de l’autoplay :
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoAutorun" -Type DWord -Value 1
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoDriveTypeAutoRun" -Type DWord -Value 255

#Configuration SMB :
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force

#Désactivation du protocole netbios
$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces" 
Get-ChildItem $r |ForEach-Object{ Set-ItemProperty -Path "$r\$($_.pschildname)" -Name NetbiosOptions -Value 2 }

#Désactivation du protocole LLMNR - DNS multicast
New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0

#Désactivation du protocole WPAD
New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1

#Suppréssion du PageFile lors de l’arret du systèm
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -name ClearPageFileAtShutdown -Value 1

#Désactivation du sous-sytème linux:
Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove

#Désactivation du partage de connection SharedAccess
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4

#Désactivation de WinRM
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4

#Désactivation FTP
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FTPSVC -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue #erreur si non installé

#Désactivation SSHD
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sshd -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue #erreur si non installé

#Désactivation SNMP
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue #erreur si non installé

#désactivation RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1

#désactivation de powershellv2
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart

#Configuration Pare-feu
netsh advfirewall reset
Set-NetFirewallProfile -Profile * -Enabled True
netsh advfirewall set currentprofile logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log
netsh advfirewall set currentprofile logging maxfilesize 4096
netsh advfirewall set currentprofile logging droppedconnections enable
netsh advfirewall set publicprofile firewallpolicy blockinboundalways,allowoutbound
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Public
Netsh advfirewall firewall add rule name="Block notepad.exe netconns" program="%systemroot%\system32\notepad.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block regsvr32.exe netconns" program="%systemroot%\system32\regsvr32.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block calc.exe netconns" program="%systemroot%\system32\calc.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block mshta.exe netconns" program="%systemroot%\system32\mshta.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block wscript.exe netconns" program="%systemroot%\system32\wscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block cscript.exe netconns" program="%systemroot%\system32\cscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block runscripthelper.exe netconns" program="%systemroot%\system32\runscripthelper.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh advfirewall firewall add rule name="Block hh.exe netconns" program="%systemroot%\system32\hh.exe" protocol=tcp dir=out enable=yes action=block profile=any

#Configuration de Windows Defender
setx /M MP_FORCE_USE_SANDBOX 1 #sandboxing
Set-MpPreference -DisablePrivacyMode $true -DisableRealtimeMonitoring $false -DisableIntrusionPreventionSystem $false 
Set-MpPreference -UnknownThreatDefaultAction Quarantine -HighThreatDefaultAction Quarantine -SevereThreatDefaultAction Quarantine -ModerateThreatDefaultAction Quarantine  -LowThreatDefaultAction NoAction 
Set-MpPreference -EnableNetworkProtection Enabled
Set-MpPreference -QuarantinePurgeItemsAfterDelay 0
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -DisableAutoExclusions $false
Set-MpPreference -SubmitSamplesConsent 1
Set-MpPreference -ControlledFolderAccessAllowedApplications 'C:\Users\michael\AppData\Local\Programs\Microsoft VS Code\Code.exe', 'C:\Windows\System32\Robocopy.exe', 'C:\Windows\explorer.exe', 'C:\Program Files\PowerShell\7\pwsh.exe'
Set-MpPreference -ControlledFolderAccessProtectedFolders 'C:\Users\michael\OneDrive' #document déja présent
Set-MpPreference -EnableControlledFolderAccess 1

#configuration de l'UAC au niveau 3
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "ConsentPromptBehaviorAdmin" -Value 2 
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name "PromptOnSecureDesktop" -Value 1 

# verification que le "always install with elevated" est désactivé
remove-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer -name AlwaysInstallElevated -ea SilentlyContinue

#activation des logs powershells
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value 1
cd 'C:\Program Files\PowerShell\7'
.\RegisterManifest.ps1

#services
stop-service -name bthserv 
Set-Service -name bthserv -StartupType Disabled
whoami; hostname ; Get-Service -name bthserv | select -property name,status,starttype

stop-service -name browser 
Set-Service -name browser -StartupType Disabled
whoami; hostname ; Get-Service -name browser | select -property name,status,starttype

stop-service -name MapsBroker
Set-Service -name MapsBroker -StartupType Disabled
whoami; hostname ; Get-Service -name MapsBroker | select -property name,status,starttype

stop-service -name lfsvc
Set-Service -name lfsvc -StartupType Disabled
whoami; hostname ; Get-Service -name lfsvc | select -property name,status,starttype

stop-service -name sharedaccess
Set-Service -name sharedaccess -StartupType Disabled
whoami; hostname ; Get-Service -name sharedaccess | select -property name,status,starttype

stop-service -name lltdsvc
Set-Service -name lltdsvc -StartupType Disabled
whoami; hostname ; Get-Service -name lltdsvc | select -property name,status,starttype

stop-service -name MSiSCSI
Set-Service -name MSiSCSI -StartupType Disabled
whoami; hostname ; Get-Service -name MSiSCSI | select -property name,status,starttype

stop-service -name InstallService
Set-Service -name InstallService -StartupType Disabled
whoami; hostname ; Get-Service -name InstallService | select -property name,status,starttype

stop-service -name PNRPsvc
Set-Service -name PNRPsvc -StartupType Disabled
whoami; hostname ; Get-Service -name PNRPsvc | select -property name,status,starttype

stop-service -name p2psvc
Set-Service -name p2psvc -StartupType Disabled
whoami; hostname ; Get-Service -name p2psvc | select -property name,status,starttype

stop-service -name p2pimsvc
Set-Service -name p2pimsvc -StartupType Disabled
whoami; hostname ; Get-Service -name p2pimsvc | select -property name,status,starttype

stop-service -name PNRPAutoReg
Set-Service -name PNRPAutoReg -StartupType Disabled
whoami; hostname ; Get-Service -name PNRPAutoReg | select -property name,status,starttype

stop-service -name wercplsupport
Set-Service -name wercplsupport -StartupType Disabled
whoami; hostname ; Get-Service -name wercplsupport | select -property name,status,starttype

stop-service -name RasAuto
Set-Service -name RasAuto -StartupType Disabled
whoami; hostname ; Get-Service -name RasAuto | select -property name,status,starttype

stop-service -name SessionEnv
Set-Service -name SessionEnv -StartupType Disabled
whoami; hostname ; Get-Service -name SessionEnv | select -property name,status,starttype

stop-service -name TermService
Set-Service -name TermService -StartupType Disabled
whoami; hostname ; Get-Service -name TermService | select -property name,status,starttype

stop-service -name UmRdpService
Set-Service -name UmRdpService -StartupType Disabled
whoami; hostname ; Get-Service -name UmRdpService | select -property name,status,starttype

stop-service -name RpcLocator
Set-Service -name RpcLocator -StartupType Disabled
whoami; hostname ; Get-Service -name RpcLocator | select -property name,status,starttype

stop-service -name RemoteRegistry
Set-Service -name RemoteRegistry -StartupType Disabled
whoami; hostname ; Get-Service -name RemoteRegistry | select -property name,status,starttype

stop-service -name RemoteAccess
Set-Service -name RemoteAccess -StartupType Disabled
whoami; hostname ; Get-Service -name RemoteAccess | select -property name,status,starttype

stop-service -name LanmanServer -force
Set-Service -name LanmanServer -StartupType Disabled
whoami; hostname ; Get-Service -name LanmanServer | select -property name,status,starttype

stop-service -name SSDPSRV -force
Set-Service -name SSDPSRV -StartupType Disabled
whoami; hostname ; Get-Service -name SSDPSRV | select -property name,status,starttype

stop-service -name upnphost -force
Set-Service -name upnphost -StartupType Disabled
whoami; hostname ; Get-Service -name upnphost | select -property name,status,starttype

stop-service -name WerSvc -force
Set-Service -name WerSvc -StartupType Disabled
whoami; hostname ; Get-Service -name WerSvc | select -property name,status,starttype

stop-service -name Wecsvc -force
Set-Service -name Wecsvc -StartupType Disabled
whoami; hostname ; Get-Service -name Wecsvc | select -property name,status,starttype

stop-service -name WMPNetworkSvc -force
Set-Service -name WMPNetworkSvc -StartupType Disabled
whoami; hostname ; Get-Service -name WMPNetworkSvc | select -property name,status,starttype

stop-service -name icssvc -force
Set-Service -name icssvc -StartupType Disabled
whoami; hostname ; Get-Service -name icssvc | select -property name,status,starttype

stop-service -name WpnService -force
Set-Service -name WpnService -StartupType Disabled
whoami; hostname ; Get-Service -name WpnService | select -property name,status,starttype

stop-service -name PushToInstall -force
Set-Service -name PushToInstall -StartupType Disabled
whoami; hostname ; Get-Service -name PushToInstall | select -property name,status,starttype

stop-service -name WinRM -force
Set-Service -name WinRM -StartupType Disabled
whoami; hostname ; Get-Service -name WinRM | select -property name,status,starttype

stop-service -name XboxGipSvc -force
Set-Service -name XboxGipSvc -StartupType Disabled
whoami; hostname ; Get-Service -name XboxGipSvc | select -property name,status,starttype

stop-service -name XblAuthManager -force
Set-Service -name XblAuthManager -StartupType Disabled
whoami; hostname ; Get-Service -name XblAuthManager | select -property name,status,starttype


stop-service -name XblGameSave -force
Set-Service -name XblGameSave -StartupType Disabled
whoami; hostname ; Get-Service -name XblGameSave | select -property name,status,starttype

stop-service -name XboxNetApiSvc -force
Set-Service -name XboxNetApiSvc -StartupType Disabled
whoami; hostname ; Get-Service -name XboxNetApiSvc | select -property name,status,starttype
```
