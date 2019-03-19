########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、OWA表示非表示の設定を行う
#　
#　＞設定するパラメーターは、"OWA表示"の1種類
#　　
########################################################################################

Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { `

		<#IF文で、"OWA表示"が"True"の時で条件分岐#>

 			if ( $_.OWA表示 -eq "True" ) { `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-OWAEnabled $True `
	
		<#IF文で、"OWA表示"が"False"の時で条件分岐#>

			}elseif ( $_.OWA表示 -eq "False" ) { `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-OWAEnabled $False `

		<#上記以外の時は、エラーメッセージが出力される#>

			}else{ `

				Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red `

			}
	
	}