Param(
  [string]$Inputfile
)

 Import-CSV $Inputfile | ForEach {


		Write-Host $_.Name
		$Calendar = $_.Name 
		$Calendar += ":\予定表"  
		get-MailboxFolderPermission -Identity $Calendar -User "既定" 
		
		}



  