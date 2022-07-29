$AADgroups = Get-AzureAdGroup -All $true # -Top 10 # -SearchString "Group_MDM_Iain.Mclaren"

$totalGroups = ($AADgroups | Measure-Object).count

"" | Out-File ".\AADGroups\index.txt"

$i = 0
$p = 0

foreach ($group in $AADgroups) {

    $i++
    $p = ($i / $totalGroups) * 100

    Write-Progress -Activity "Backing up AAD groups and memberships" -Status "$i of $totalGroups" -PercentComplete $p

    "$($group.DisplayName),$($group.ObjectId)" | Out-File ".\AADGroups\index.txt" -Append

    $group | ConvertTo-Json | Out-File ".\AADGroups\$($group.ObjectId).group"

    $group | Get-AzureADGroupMember | ConvertTo-Json | Out-File ".\AADGroups\$($group.ObjectId).members"

}