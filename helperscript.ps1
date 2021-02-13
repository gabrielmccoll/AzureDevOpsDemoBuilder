# Azure Subscription - Owner Perms
# Azure DevOps Organisation - Project Admin perms
# Azure Service Principal
$subid = (Get-AzContext).Subscription.Id
$subName = (Get-AzContext).Subscription.Name
$tenant = (Get-AzContext).Subscription.TenantId
Install-module VSTeam -Force -Verbose
$organization = ""
$project = ""
$token = Get-Credential -UserName ADOPat -Title "I need you to paste your PAT from Azure Devops in below"
Set-VSTeamAccount -Account $organization -SecurePersonalAccessToken $token.Password
Get-VSTeamProject
$sp = New-AzADServicePrincipal -DisplayName "ADOSP123" -EndDate (get-date).AddDays(1)

$sp = New-AzADServicePrincipal -DisplayName "ADOSP123" -EndDate (get-date).AddDays(1)
$spkey = $sp.Secret | ConvertFrom-SecureString -AsPlainText
Add-VSTeamAzureRMServiceEndpoint -subscriptionName $subName -subscriptionId $subid `
-SubscriptionTenantId $tenant -endpointName "AzureVSPro" -ProjectName $project `
-ServicePrincipalId $sp.id -servicePrincipalKey $spkey
# Need a service principal now to cratej
