########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、新規ユーザー登録の為の各パラメーターを
#　登録する
#　＞登録するパラメーターは、ユーザー名・表示名・名・性・役職・部署・事業所番号・
#　会社番号・携帯番号・ＦＡＸ番号・住所・市区町村・都道府県・郵便番号・国地域・
#　の15種類
#
########################################################################################

Param(
[string]$Inputfile
)
	Import-CSV $Inputfile | ForEach { 
		Write-Output  $_.ユーザー名
			New-MsolUser -UserPrincipalName $_.ユーザー名 -DisplayName $_.表示名 `
				-FirstName $_.名 `
				-Lastname $_.姓 `
				-Title $_.役職 `
				-Department $_.部署 `
				-Office $_.事業所番号 `
				-PhoneNumber $_.会社電話 `
				-MobilePhone $_.携帯電話  `
				-Fax $_."FAX 番号" `
				-StreetAddress $_.住所 `
				-City $_.市区町村 `
				-State $_.都道府県 `
				-PostalCode $_.郵便番号 `
				-Country $_.国地域 
	} 

