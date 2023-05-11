# status

Get-NetConnectionProfile
Get-NetFirewallRule |where -Property enabled -eq true |where -Property Direction -eq Inbound |select profile,DisplayName,direction,action,description
Get-NetFirewallRule |where -Property enabled -eq true |where -Property Direction -eq Outbound |select profile,DisplayName,direction,action,description

Write-host -ForegroundColor Cyan "$((Get-NetFirewallRule |measure).Count) rules"
Write-host -ForegroundColor Yellow "$((Get-NetFirewallRule |where -Property Enabled -eq $true |measure).Count) actives rules"
Write-host -ForegroundColor Yellow "profile $(Get-NetFirewallProfile)"

get-NetFirewallProfile |select Name, Enabled

# drop policy for inbound and notification

Get-NetFirewallProfile |% { Set-NetFirewallProfile -DefaultInboundAction Block -NotifyOnListen True }