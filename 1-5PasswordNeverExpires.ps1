########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、Password無期限化の設定を行う
#
#
#　＞設定するパラメーターは、"Password無期限化"１種類
#
#
########################################################################################

Param(
  [string]$Inputfile
)


<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach-Object { 
		Write-Host $_.Password無期限化
		<#Password無期限化"が"True"の時で条件分岐#>
		 	if ( $_.Password無期限化 -eq "TRUE" ){ `
				Write-Host $_.ユーザー名
				Set-msolUser -UserPrincipalName $_.ユーザー名 `
					-PasswordNeverExpires $True `
		<#Password無期限化"が"False"の時で条件分岐#>

			}elseif ( $_.Password無期限化 -eq "FALSE" ){ 
				Write-Host $_.ユーザー名
				Set-msolUser -UserPrincipalName $_.ユーザー名 `
					-PasswordNeverExpires $False `
			}else{ 
				 Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red `
			}

	}