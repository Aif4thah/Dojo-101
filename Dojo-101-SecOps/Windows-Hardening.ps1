<#
Windows Workstation Hardening Script 
#>

#taille des logs

if((Get-EventLog -List | where -Property Log -eq security).MaximumKilobytes -lt 20480){
    Limit-EventLog -LogName "Security" -MaximumSize (20*1024*1024) -verbose
}


#execution policy
if((Get-ExecutionPolicy) -ne "Restricted"){
    Set-ExecutionPolicy -ExecutionPolicy Restricted -verbose
}


#Protection du Disque

if(!(Get-BitLockerVolume -MountPoint "C:").VolumeStatus -eq "FullyEncrypted"){
    #Install-WindowsFeature BitLocker –IncludeAllSubFeature -IncludeManagementTools -Restart
    Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector -verbose
}

#Protection de la mémoire
Set-Processmitigation -System -Enable DEP,ForceRelocateImages,BottomUp,CFG,SEHOP -verbose
Get-ProcessMitigation |select ProcessName |%{ Set-Processmitigation -Name $_.ProcessName -Enable DEP,BottomUp,SEHOP} -verbose

if((Get-ProcessMitigation |where ProcessName -eq Chrome.exe) -eq $null){
    Set-Processmitigation -Name chrome.exe -Enable DEP,BottomUp,CFG,SEHOP -verbose
}

if((Get-ProcessMitigation |where ProcessName -eq msedge.exe) -eq $null){
    Set-Processmitigation -Name msedge.exe -Enable DEP,BottomUp,CFG,SEHOP -verbose
}

if((Get-ProcessMitigation |where ProcessName -eq Brave.exe) -eq $null){
    Set-Processmitigation -Name Brave.exe -Enable DEP,BottomUp,CFG,SEHOP -verbose
}

if((Get-ProcessMitigation |where ProcessName -eq code) -eq $null){
    Set-Processmitigation -Name Code.exe -Enable DEP,BottomUp,CFG,SEHOP -verbose
}

# pour reset: #Set-ProcessMitigation -System -Remove ; Set-ProcessMitigation -System -Reset #restauration de la conf par défaut 

#désactivation des « null sessions » :

if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters).RestrictNullSessAccess -ne 1){
    Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1 -verbose
}

if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA).restrictAnonymous -ne 2){
    Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2 -verbose
}

#Rescriction NTLM

if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0).RestrictSendingNTLMTraffic -ne 2){
    New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -verbose
    Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -verbose
}

Set-SMbClientConfiguration -BlockNTLM $true

#désactivation WDigest (désactivé par défaut on écrase juste la valeur si elle éxiste)
if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest).UseLogonCredential -ne 0){
    Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -verbose
}

#désactivation de l’autorun et de l’autoplay :

if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer).NoAutorun -ne 1){
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoAutorun" -Type DWord -Value 1
}

if((Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer).NoDriveTypeAutoRun -ne 255){
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
}

#Configuration SMB :
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force

#Désactivation du protocole netbios
$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
Get-ChildItem $r |%{
    $child = $_
    if((Get-ItemProperty -Path "$r\$($child.pschildname)").NetbiosOptions -ne 2){
        Set-ItemProperty -Path "$r\$($child.pschildname)" -Name NetbiosOptions -Value 2 -verbose
    }
}

#Désactivation du protocole LLMNR - DNS multicast
if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient").EnableMulticast -ne 0){
    New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
    New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -verbose
}


#Désactivation du protocole WPAD

if((Get-ItemProperty "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad").WpadOverride -ne 1){
    New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -verbose
}

#désactivation de powershellv2
if((Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2).State -ne "Disabled"){
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
}


#Désactivation du sous-sytème linux:
if((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -ne "Disabled"){
    Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove -verbose
}

#Désactivation du partage de connection SharedAccess
if((get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -ea SilentlyContinue).Start -ne 4){
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

#Désactivation de WinRM
if((get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -ea SilentlyContinue).Start -ne 4){
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4 -verbose
}

#Désactivation FTP
if((get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FTPSVC -ea SilentlyContinue).Start -ne 4){
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FTPSVC -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

#Désactivation SSHD
if((get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sshd -ea SilentlyContinue).Start -ne 4){
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sshd -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

#Désactivation SNMP
if((get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP -ea SilentlyContinue).Start -ne 4){
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

#désactivation RDP
if((get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -ea SilentlyContinue).fDenyTSConnections -ne 1){
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1 -verbose
}

#Configuration Pare-feu
Set-NetFirewallProfile -Profile * -Enabled True –NotifyOnListen True
netsh advfirewall set currentprofile logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log
netsh advfirewall set currentprofile logging maxfilesize 4096
netsh advfirewall set currentprofile logging droppedconnections enable
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Public

if((Get-NetFirewallRule -DisplayName "Block hh.exe netconns" | measure).count -le 0){
    Netsh advfirewall firewall add rule name="Block notepad.exe netconns" program="%systemroot%\system32\notepad.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block regsvr32.exe netconns" program="%systemroot%\system32\regsvr32.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block calc.exe netconns" program="%systemroot%\system32\calc.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block mshta.exe netconns" program="%systemroot%\system32\mshta.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block wscript.exe netconns" program="%systemroot%\system32\wscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block cscript.exe netconns" program="%systemroot%\system32\cscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block runscripthelper.exe netconns" program="%systemroot%\system32\runscripthelper.exe" protocol=tcp dir=out enable=yes action=block profile=any
    Netsh advfirewall firewall add rule name="Block hh.exe netconns" program="%systemroot%\system32\hh.exe" protocol=tcp dir=out enable=yes action=block profile=any
}




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
Set-MpPreference -EnableControlledFolderAccess 1

#configuration de l'UAC au niveau 3
if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")."ConsentPromptBehaviorAdmin" -ne 2){
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 2 
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Value 1
}

# verification que le "always install with elevated" est désactivé
if((get-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer" -ea SilentlyContinue).AlwaysInstallElevated -ne $null){
    remove-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer" -name AlwaysInstallElevated -verbose
}

# suppression et desactivation de hyberfile
powercfg /hibernate off

# remove pagefile.sys at shutdown
if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management").ClearPageFileAtShutdown -ne 1){
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name ClearPageFileAtShutdown -Value 1 -verbose
}

# enable Memory integrity / virtualization-based security (VBS)

#get-CimInstance –ClassName Win32_DeviceGuard –Namespace root\Microsoft\Windows\DeviceGuard

if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").EnableVirtualizationBasedSecurity -ne 1){
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1 -verbose
}

if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").RequirePlatformSecurityFeatures -ne 1){
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1 -verbose
}

if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").Locked -ne 0){
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0 -verbose
}

if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity").Enabled -ne 1){
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1 -verbose
}

if((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity").locked -ne 0){
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0 -verbose
}
