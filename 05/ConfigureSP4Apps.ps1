if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

# Configure Subscription Settings

$account = Get-SPManagedAccount "spdom\spservice" 

$appPoolSubSvc = New-SPServiceApplicationPool -Name SettingsServiceAppPool -Account $account
$appSubSvc = New-SPSubscriptionSettingsServiceApplication –ApplicationPool $appPoolSubSvc –Name SettingsServiceApp –DatabaseName "SubscriptionDB"
$proxySubSvc = New-SPSubscriptionSettingsServiceApplicationProxy –ServiceApplication $appSubSvc

# Configure App Management Service

$appPoolAppSvc = New-SPServiceApplicationPool -Name AppServiceAppPool -Account $account
$appAppSvc = New-SPAppManagementServiceApplication -ApplicationPool $appPoolAppSvc -Name AppServiceApp -DatabaseName "AppServiceDB"
$proxyAppSvc = New-SPAppManagementServiceApplicationProxy -ServiceApplication $appAppSvc