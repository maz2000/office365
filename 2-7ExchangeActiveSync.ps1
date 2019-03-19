########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、ActiveSyncの設定の設定を行う
#　
#　＞設定するパラメーターは、"ActiveSync"の1種類
#　　
########################################################################################

Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { `

		<#IF文で、"ActiveSyn"が"True"の時で条件分岐#>

 			if ( $_.ActiveSync -eq "True" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-ActiveSyncEnabled $True `

		<#IF文で、"ActiveSyn"が"False"の時で条件分岐#>

			}elseif ( $_.ActiveSync -eq "False" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-ActiveSyncEnabled $False `

		<#上記以外の時は、エラーメッセージが出力される#>

			}else{ `

				Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red
	
			}

	}