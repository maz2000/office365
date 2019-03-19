Param(
  [string]$Inputfile
)

Import-Csv $Inputfile | foreach { $MemberList = $_.メンバー -split ";"

	New-DistributionGroup -Name $_.表示名 `
	-Alias $_.Alias `
	-PrimarySmtpAddress $_.メールアドレス `
	-Members $MemberList 

}