########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、IMAPの設定を行う
#　
#　＞設定するパラメーターは、"IMAP"の1種類
#　　
########################################################################################


Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { `

		<#IF文で、"IMAP"が"True"の時で条件分岐#>

	 		if ( $_.IMAP -eq "True" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-IMAPEnabled $True `

		<#IF文で、"OWA表示"が"False"の時で条件分岐#>

			}elseif ( $_.IMAP -eq "False" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-CASMailbox -Identity $_.ユーザー名 `

					-IMAPEnabled $False `

		<#上記以外の時は、エラーメッセージが出力される#>

			}else{ `

				Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red `
	
			}

	}