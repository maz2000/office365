#予定表のアクセス権を一括設定します。
#CSVファイルフォーマット
#EmailAddress,User,AccessRights
#



Param(
  [string]$Inputfile
)

 Import-CSV $Inputfile | ForEach {


		Write-Host $_.EmailAddress 
		$Calendar = $_.EmailAddress
		$Calendar += ":\予定表"  
		Set-MailboxFolderPermission -Identity $Calendar -User $_.User -AccessRights $_.AccessRights
		
		}



  