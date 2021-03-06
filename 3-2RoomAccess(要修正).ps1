#このスクリプトは既存の会議室、設備のアクセス権と予約時のタイトルの処理方法の変更を一括で行うものです。


$r = Get-Mailbox | where { $_.RecipientTypeDetails -eq "RoomMailbox" }
$e = Get-Mailbox | where { $_.RecipientTypeDetails -eq "EquipmentMailbox" }


foreach($Room in $r) {

$Upn = [String]$Room + ":\Calendar"
Write-Host $Upn
Set-MailboxFolderPermission -identity $Upn -AccessRights Reviewer -User Default 

}

foreach($Equip in $e) {

$Upn = [String]$Equip + ":\Calendar"
Write-Host $Upn
Set-MailboxFolderPermission -identity $Upn -AccessRights Reviewer -User Default 

}



foreach($Room in $r) {

$Upn = [String]$Room

Get-MailBoxFolderPermission -Identity $Upn -User Default | Select Identity,AccessRights 
Set-CalendarProcessing -Identity $Upn -DeleteSubject $false  -AddOrganizerToSubject $false -AutomateProcessing AutoAccept 
get-CalendarProcessing -Identity $Upn | Select Identity,DeleteSubject,AddOrganizerToSubject
}



foreach($Equip in $e) {

$Upn = [String]$Equip

Get-MailboxFolderPermission -identity $Upn -User Default | Select Identity,AccessRights
Set-CalendarProcessing -Identity $Upn -DeleteSubject $false  -AddOrganizerToSubject $false -AutomateProcessing AutoAccept
get-CalendarProcessing -Identity $Upn | Select Identity,DeleteSubject,AddOrganizerToSubject
}


