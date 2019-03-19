# Define Hashtables for lookup
$Sku = @{
	"DESKLESSPACK" = "Office 365 (Plan K1)"
	"DESKLESSWOFFPACK" = "Office 365 (Plan K2)"
	"LITEPACK" = "Office 365 (Plan P1)"
	"EXCHANGESTANDARD" = "Office 365 Exchange Online Only"
	"STANDARDPACK" = "Office 365 (Plan E1)"
	"STANDARDWOFFPACK" = "Office 365 (Plan E2)"
	"ENTERPRISEPACK" = "Office 365 (Plan E3)"
	"ENTERPRISEPACKLRG" = "Office 365 (Plan E3)"
	"ENTERPRISEWITHSCAL" = "Office 365 (Plan E4)"
	"STANDARDPACK_STUDENT" = "Office 365 (Plan A1) for Students"
	"STANDARDWOFFPACKPACK_STUDENT" = "Office 365 (Plan A2) for Students"
	"ENTERPRISEPACK_STUDENT" = "Office 365 (Plan A3) for Students"
	"ENTERPRISEWITHSCAL_STUDENT" = "Office 365 (Plan A4) for Students"
	"STANDARDPACK_FACULTY" = "Office 365 (Plan A1) for Faculty"
	"STANDARDWOFFPACKPACK_FACULTY" = "Office 365 (Plan A2) for Faculty"
	"ENTERPRISEPACK_FACULTY" = "Office 365 (Plan A3) for Faculty"
	"ENTERPRISEWITHSCAL_FACULTY" = "Office 365 (Plan A4) for Faculty"
	"ENTERPRISEPACK_B_PILOT" = "Office 365 (Enterprise Preview)"
	"STANDARD_B_PILOT" = "Office 365 (Small Business Preview)"
        "ATP_ENTERPRISE" = "Advanced Thread Protection"
	"EXCHANGEARCHIVE_ADDON" = "Exchange Onlne Archive"
	}
		


	# Loop through all users and write them to the CSV file
     #   $user = Get-MsolUser -UserPrincipalName daisuke2-watanabe@keihin-corp.co.jp
     #  $user = Get-MsolUser -UserPrincipalName tomohiro-sato@keihin-corp.co.jp
 


		
		write-host ("Processing " + $user.displayname)

try{ $datastring = ($user.displayname + "," + $user.userprincipalname + "," + $Sku.Item($user.licenses[1].AccountSku.SkuPartNumber))  }
  catch {$datastring = ($user.displayname + "," + $user.userprincipalname + "," + $Sku.Item($user.licenses[0].AccountSku.SkuPartNumber)) }



                Write-Host "1:"$datastring 
                if($user.licenses[1].AccountSku.SkuPartNumber -eq $null) {
                               
		
		foreach ($row in $($user.licenses[0].servicestatus)) {
			
			Write-Host "row.provisioningstatus:" $row.provisioningstatus
			$datastring = ($datastring + "," + $($row.provisioningstatus))
			}
                } else {
                foreach ($row in $($user.licenses[1].servicestatus)) {
			Write-Host "row.provisioningstatus:" $row.provisioningstatus
			$datastring = ($datastring + "," + $($row.provisioningstatus))
			}

 

                }                
		
   Write-Host "2:"$datastring 