########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、UsageLocation(使用地域)の設定を行う
#　
#　＞設定するパラメーターは、UsageLocationの1種類
#　　
#　＞本SCriotsでは、"JP"の設定のみを行う
#
# Comment
########################################################################################


Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-Csv $Inputfile | foreach{ 

		<#IF文で、UsageLocationが"JP"の時を条件分岐#>

			if ( $_.UsageLocation -eq "JP" ){ 
				Write-Host $_.ユーザー名 
				Set-msolUser -UserPrincipalName $_.ユーザー名 -UsageLocation JP 
	
		<#上記以外の時は、エラーメッセージが出力される#>

			}else{ 

				Write-Host $_.ユーザー名 個別設定して下さい。 -foregroundColor Red
			}

	}
