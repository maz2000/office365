Param( [String]$OutputFile)
  
$groups = get-distributiongroup
 
"FLG,配布リスト名,メンバー,メールアドレス,部署" | Out-File $OutputFile -encoding UTF8
foreach ($group in $groups)
{
 
Write-Host $group.displayName "を処理します"
Write-Host "メールアドレスは" $group.PrimarySmtpAddress
	$members = get-distributiongroupmember -identity $group.PrimarySmtpAddress
		 
	foreach ($member in $members)
	{

Write-Host "メンバーのメールアドレスは" $member.PrimarySmtpAddress "です"
 
 
		$userinfo = new-object psobject 
		$userinfo | add-member -membertype noteproperty -name FLG -value ""
		$userinfo | add-member -membertype noteproperty -name 配布リスト名 -value $group.displayName
		$userinfo | add-member -membertype noteproperty -name メンバー -value $member.DisplayName
		$userinfo | add-member -membertype noteproperty -name メールアドレス -value $member.PrimarySmtpAddress
		$userinfo | add-member -membertype noteproperty -name 部署 -value $member.Department 
		$userinfo  | export-csv -Path $OutputFile -NoTypeInformation -Encoding UTF8 -Append 

	}
}
