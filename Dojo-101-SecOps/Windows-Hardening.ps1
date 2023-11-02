<#
Windows Workstation Hardening Script 
#>
write-host "[*] = Controle et modification uniquement si besoin"
write-host "[>] = Ecrasement de la configuration sans controle préalable"

write-host "[*]taille des logs"

if ((Get-EventLog -List | where -Property Log -eq security).MaximumKilobytes -lt 20480) {
    Limit-EventLog -LogName "Security" -MaximumSize (20 * 1024 * 1024) -verbose
}

write-host "[>]logs"
auditpol /set /category:"Système" /success:enable /failure:enable
auditpol /set /category:"Ouverture/Fermeture de session" /success:enable /failure:enable
auditpol /set /category:"Utilisation de privilège" /success:enable /failure:enable


write-host "[*]execution policy"
if ((Get-ExecutionPolicy) -ne "Restricted") {
    Set-ExecutionPolicy -ExecutionPolicy Restricted -verbose
}


write-host "[*]Protection du Disque / chiffrement de surface"
if (!(Get-BitLockerVolume -MountPoint "C:").VolumeStatus -eq "FullyEncrypted") {
    if ("Enabled" -ne (Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2).State) {
        Install-WindowsFeature BitLocker –IncludeAllSubFeature -IncludeManagementTools
    }
    Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector -verbose
}

write-host "[*]Protection de la mémoire"
Set-Processmitigation -System -Enable DEP, ForceRelocateImages, BottomUp, CFG, SEHOP -verbose
Get-ProcessMitigation | select ProcessName | % { Set-Processmitigation -Name $_.ProcessName -Enable DEP, BottomUp, SEHOP } -verbose

if ((Get-ProcessMitigation | where ProcessName -eq Chrome.exe) -eq $null) {
    Set-Processmitigation -Name chrome.exe -Enable DEP, BottomUp, CFG, SEHOP -verbose
}

if ((Get-ProcessMitigation | where ProcessName -eq msedge.exe) -eq $null) {
    Set-Processmitigation -Name msedge.exe -Enable DEP, BottomUp, CFG, SEHOP -verbose
}

if ((Get-ProcessMitigation | where ProcessName -eq Brave.exe) -eq $null) {
    Set-Processmitigation -Name Brave.exe -Enable DEP, BottomUp, CFG, SEHOP -verbose
}

if ((Get-ProcessMitigation | where ProcessName -eq code) -eq $null) {
    Set-Processmitigation -Name Code.exe -Enable DEP, BottomUp, CFG, SEHOP -verbose
}

write-host "[*]désactivation des « null sessions »"
if (1 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters).RestrictNullSessAccess) {
    Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters -name RestrictNullSessAccess -value 1 -verbose
}

if ( 2 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA).restrictAnonymous) {
    Set-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA -name restrictAnonymous -Value 2 -verbose
}

write-host "[*]Rescriction NTLM" #Devrait pouvoir etre emplacé bientot par : Set-SMbClientConfiguration -BlockNTLM $true
if ( 2 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0).RestrictSendingNTLMTraffic) {
    New-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -PropertyType "DWord" -verbose
    Set-ItemProperty -path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0 -name RestrictSendingNTLMTraffic -Value 2 -verbose
}


write-host "[*]désactivation WDigest"
if ( 0 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest).UseLogonCredential) {
    Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Type DWord -Value 0 -verbose
}

write-host "[*]désactivation de l’autorun et de l’autoplay :"
if ( 1 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer).NoAutorun) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoAutorun" -Type DWord -Value 1 -verbose
}
if (255 -ne (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer).NoDriveTypeAutoRun) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name "NoDriveTypeAutoRun" -Type DWord -Value 255 -verbose
}

write-host "[*]Configuration SMB :"
Set-SmbServerConfiguration -EnableSMB1Protocol $false -force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name DisableCompression -Type DWORD -Value 1 -Force

write-host "[*]Désactivation du protocole netbios"
$r = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
Get-ChildItem $r | % {
    $child = $_
    if ((Get-ItemProperty -Path "$r\$($child.pschildname)").NetbiosOptions -ne 2) {
        Set-ItemProperty -Path "$r\$($child.pschildname)" -Name NetbiosOptions -Value 2 -verbose
    }
}

write-host "[*]Désactivation du protocole LLMNR - DNS multicast"
if (0 -ne (Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient").EnableMulticast) {
    New-Item "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -ea SilentlyContinue
    New-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Windows NT\DNSClient" -name "EnableMulticast" -Value 0 -verbose
}


write-host "[*]Désactivation du protocole WPAD"
if ( 1 -ne (Get-ItemProperty "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad").WpadOverride) {
    New-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -verbose
}

write-host "[*]désactivation de powershellv2"
if ("Disabled" -ne (Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2).State) {
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
}


write-host "[*]Désactivation du sous-sytème linux:"
if ("Disabled" -ne (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State) {
    Disable-WindowsOptionalFeature -online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -Remove -verbose
}

write-host "[*]Désactivation du partage de connection SharedAccess"
if (4 -ne (get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -ea SilentlyContinue).Start) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

write-host "[*]Désactivation de WinRM"
if (4 -ne (get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -ea SilentlyContinue).Start) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM -Name "Start" -Type DWord -Value 4 -verbose
}

write-host "[*]Désactivation FTP"
if (4 -ne (get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FTPSVC -ea SilentlyContinue).Start) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FTPSVC -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

write-host "[*]Désactivation SSHD"
if (4 -ne (get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sshd -ea SilentlyContinue).Start) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sshd -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

write-host "[*]Désactivation SNMP"
if (4 -ne (get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP -ea SilentlyContinue).Start) {
    Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP -Name "Start" -Type DWord -Value 4 -ea SilentlyContinue -verbose
}

write-host "[*]désactivation RDP"
if (1 -ne (get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -ea SilentlyContinue).fDenyTSConnections) {
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 1 -verbose
}


write-host "[>]Configuration de Windows Defender"
setx /M MP_FORCE_USE_SANDBOX 1
Set-MpPreference -DisableRealtimeMonitoring $false -DisableIntrusionPreventionSystem $false 
Set-MpPreference -UnknownThreatDefaultAction Quarantine -HighThreatDefaultAction Quarantine -SevereThreatDefaultAction Quarantine -ModerateThreatDefaultAction Quarantine  -LowThreatDefaultAction NoAction 
Set-MpPreference -EnableNetworkProtection Enabled -AllowSwitchToAsyncInspection $true
Set-MpPreference -QuarantinePurgeItemsAfterDelay 30
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -DisableAutoExclusions $false
Set-MpPreference -SubmitSamplesConsent 1
Set-MpPreference -ControlledFolderAccessProtectedFolders (ls $HOME\p*nd*e).FullName -EnableControlledFolderAccess Enabled
Set-MpPreference -ControlledFolderAccessAllowedApplications "${HOME}\AppData\Local\Programs\Microsoft VS Code\Code.exe", 'C:\Windows\System32\Robocopy.exe', 'C:\Windows\explorer.exe',
Set-MpPreference -SignatureScheduleDay Everyday
Set-MpPreference -RemediationScheduleDay 0

write-host "[*]configuration de l'UAC au niveau 3"
if ( 2 -ne (Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")."ConsentPromptBehaviorAdmin") {
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 2 
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Value 1 -verbose
}

write-host "[*]verification que le 'always install with elevated' est désactivé"
if ( $null -ne (get-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer" -ea SilentlyContinue).AlwaysInstallElevated) {
    remove-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer" -name AlwaysInstallElevated -verbose
}

write-host "[>]suppression et desactivation de hyberfile"
powercfg /hibernate off

write-host "[*]remove pagefile.sys at shutdown"
if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management").ClearPageFileAtShutdown -ne 1) {
    Set-ItemProperty -Path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name ClearPageFileAtShutdown -Value 1 -verbose
}

write-host "[*]enable Memory integrity / virtualization-based security (VBS)"
if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").EnableVirtualizationBasedSecurity -ne 1) {
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "EnableVirtualizationBasedSecurity" -Value 1 -verbose
}

if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").RequirePlatformSecurityFeatures -ne 1) {
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "RequirePlatformSecurityFeatures" -Value 1 -verbose
}

if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard").Locked -ne 0) {
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard"  -name "Locked" -Value 0 -verbose
}

if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity").Enabled -ne 1) {
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Enabled" -Value 1 -verbose
}

if ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity").locked -ne 0) {
    New-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0 -PropertyType "DWord" -ea SilentlyContinue
    Set-ItemProperty -path "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -name "Locked" -Value 0 -verbose
}



write-host "[*]Configuration Pare-feu"
Set-NetFirewallProfile -Profile * -Enabled True –NotifyOnListen True -DefaultInboundAction Block -DefaultOutboundAction Allow
Set-NetFirewallProfile -Profile * -LogFileName %SystemRoot%\System32\LogFiles\Firewall\pfirewall.log -LogBlocked true -LogIgnored true -LogAllowed true -LogMaxSizeKilobytes 32767
Set-NetFirewallProfile -Profile * -AllowLocalFirewallRules True -AllowUnicastResponseToMulticast False -EnableStealthModeForIPsec True
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Public

if ((Get-NetFirewallRule -DisplayName "Block notepad.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block notepad.exe netconns" program="%systemroot%\system32\notepad.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block regsvr32.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block regsvr32.exe netconns" program="%systemroot%\system32\regsvr32.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block calc.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block calc.exe netconns" program="%systemroot%\system32\calc.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block mshta.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block mshta.exe netconns" program="%systemroot%\system32\mshta.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block wscript.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block wscript.exe netconns" program="%systemroot%\system32\wscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block cscript.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block cscript.exe netconns" program="%systemroot%\system32\cscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
}   
if ((Get-NetFirewallRule -DisplayName "Block runscripthelper.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block runscripthelper.exe netconns" program="%systemroot%\system32\runscripthelper.exe" protocol=tcp dir=out enable=yes action=block profile=any
}
if ((Get-NetFirewallRule -DisplayName "Block hh.exe netconns" | measure).count -le 0) {
    Netsh advfirewall firewall add rule name="Block hh.exe netconns" program="%systemroot%\system32\hh.exe" protocol=tcp dir=out enable=yes action=block profile=any
}

write-host "[*]Désactivation des règles en doublon dans le pare-feu (peux prendre un peu temps)"

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
