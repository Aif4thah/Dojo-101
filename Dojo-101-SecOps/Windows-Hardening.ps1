<#
    Windows Workstation Hardening Script 
en complement de la politique de sécurité local (SecPol.msc)
#>

#taille des logs
Limit-EventLog -LogName "Security" -MaximumSize (4*1024*1024*1024)

#execution policy
Set-ExecutionPolicy -ExecutionPolicy Restricted

#Protection de la mémoire
Set-Processmitigation -System -Enable DEP,ForceRelocateImages,BottomUp,CFG,SEHOP
Set-Processmitigation -Name keepass.exe -Enable DEP,ForceRelocateImages,BottomUp,CFG,SEHOP
Get-ProcessMitigation |select processname |%{ Set-Processmitigation -Name $_ -Enable DEP,BottomUp,SEHOP }
Set-Processmitigation -Name chrome.exe -Enable DEP,BottomUp,CFG,SEHOP
Set-Processmitigation -Name msedge.exe -Enable DEP,BottomUp,CFG,SEHOP

# pour reset: #Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 

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
Set-NetFirewallProfile -Profile * -Enabled True
netsh advfirewall set currentprofile logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log
netsh advfirewall set currentprofile logging maxfilesize 4096
netsh advfirewall set currentprofile logging droppedconnections enable
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
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 2 
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Value 1 

# verification que le "always install with elevated" est désactivé
remove-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer" -name AlwaysInstallElevated -ea SilentlyContinue

#activation des logs powershells
Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -value 1
cd 'C:\Program Files\PowerShell\7'
.\RegisterManifest.ps1

# suppression et desactivation de hyberfile
powercfg /hibernate off

# remove pagefile.sys at shutdown
set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name ClearPageFileAtShutdown -Value 1

# enable Memory integrity / virtualization-based security (VBS)
New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1

New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1

New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0

New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1

New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0

get-CimInstance –ClassName Win32_DeviceGuard –Namespace root\Microsoft\Windows\DeviceGuard