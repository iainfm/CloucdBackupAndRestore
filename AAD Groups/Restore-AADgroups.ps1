$restore = Get-Content(".\AADGroups\Group_MDM_Iain.Mclaren.group") | ConvertFrom-Json

Write-Output "Restoring $($restore.DisplayName)"

$newGroup = New-AzureADGroup -Description $restore.Description -DisplayName $restore.DisplayName -MailEnabled $restore.MailEnabled -MailNickName $restore.MailNickName -SecurityEnabled $restore.SecurityEnabled

$members = Get-Content(".\AADGroups\Group_MDM_Iain.Mclaren.members") | ConvertFrom-Json

foreach ($member in $members) {

    write-output "Adding $($member.UserPrincipalName)"

    Add-AzureADGroupMember -ObjectId $newGroup.ObjectId -RefObjectId $member.ObjectId
    
}