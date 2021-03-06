if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) 
{
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

$site = New-Object Microsoft.SharePoint.SPSite("http://sp2016")
$web = $site.RootWeb
$companyList = $web.Lists.TryGetList("Company Contacts")

if ($companyList -eq $null)
{
	$companyListTemplate = $web.ListTemplates["Contacts"]
	if ($companyListTemplate)
	{
		$web.Lists.Add("Company Contacts", "Contains main Company Contact information for site", $companyListTemplate);
		Write-Host "Creating List"
	}
	else
	{
		Write-Host "List Template does not exist"
	}
}
else
{
	Write-Host "List already exists"
}