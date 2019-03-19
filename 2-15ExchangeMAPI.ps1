########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、MAPIの設定を行う
#　
#　＞設定するパラメーターは、"MAPI"の1種類
#　　
########################################################################################

Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { `

		<#IF文で、"MAPI"が"True"の時で条件分岐#>

 		if ( $_.MAPI -eq "True" ){ `

			Write-Host $_.ユーザー名 -foregroundColor Blue `

			Set-CASMailbox -Identity $_.ユーザー名 `

				-MAPIEnabled $True `
	
		<#IF文で、"MAPI"が"False"の時で条件分岐#>

		}elseif ( $_.MAPI -eq "False" ){ `

			Write-Host $_.ユーザー名 -foregroundColor Blue `

			Set-CASMailbox -Identity $_.ユーザー名 `

				-MAPIEnabled $False `

		<#上記以外の時は、エラーメッセージが出力される#>
	
		}else{ `

			Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red
	
		}

	}