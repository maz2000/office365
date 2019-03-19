
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
	"EXCHANGE_S_ARCHIVE_ADDON" = "Exchange OnlineArchive"	
}
		
$LogFile = "Office_365_Licenses.csv"

#$licensetype = Get-MsolAccountSku | Where {$_.AccountSkuId -ne "keihinJP:ATP_ENTERPRISE"}
$licensetype = Get-MsolAccountSku 


Write-Host "LisenceType=" $licensetype[0]
Write-Host "LisenceType=" $licensetype[1]
Write-Host "LisenceType=" $licensetype[2]



foreach ($license in $licensetype) 
{	
	
	foreach ($row in $($license.ServiceStatus)) 
	{
		
		# Build header string
Write-Host "!:" $row.ServicePlan.servicename

		switch -wildcard ($($row.ServicePlan.servicename))
		{
			"EXC*" { $thisLicence = "Exchange Online" }
			"MCO*" { $thisLicence = "Lync Online" }
			"LYN*" { $thisLicence = "Lync Online" }
			"OFF*" { $thisLicence = "Office Profesional Plus" }
			"SHA*" { $thisLicence = "Sharepoint Online" }
			"*WAC*" { $thisLicence = "Office Web Apps" }
			"WAC*" { $thisLicence = "Office Web Apps" }
                        "ATP*" { $thisLicence = "Avanced Thread Protection" }
			default { $thisLicence = $row.ServicePlan.servicename }
		}
		
		$headerstring = ($headerstring + "," + $thisLicence)
	}
}
	
	Out-File -FilePath $LogFile -InputObject $headerstring -Encoding UTF8 -append
	
	write-host ("Gathering users with the following subscription: " + $license.accountskuid)

	# Gather users for this particular AccountSku
	$users = Get-MsolUser -all | where {$_.isLicensed -eq "True"}

    Write-Host "UserCount=" $users.Length

	# Loop through all users and write them to the CSV file
	foreach ($user in $users) {
		
		write-host ("Processing " + $user.displayname)
                
                try{ $datastring = ($user.displayname + "," + $user.userprincipalname + "," + $Sku.Item($user.licenses[1].AccountSku.SkuPartNumber))  }
                catch {$datastring = ($user.displayname + "," + $user.userprincipalname + "," + $Sku.Item($user.licenses[0].AccountSku.SkuPartNumber)) }

            if($user.licenses[1].AccountSku.SkuPartNumber -eq $null) {
  				foreach ($row in $($user.licenses[0].servicestatus)) {
					$datastring = ($datastring + "," + $($row.provisioningstatus))
  				}
			} else{ 
                foreach ($row in $($user.licenses[1].servicestatus)) {
					$datastring = ($datastring + "," + $($row.provisioningstatus))
                }
			}


		
		Out-File -FilePath $LogFile -InputObject $datastring -Encoding UTF8 -append
		
}			

write-host ("Script Completed.  Results available in " + $LogFile)