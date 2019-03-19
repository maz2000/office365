#####################################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、MailBoxのGALへの表示非表示の設定を行う
#
#　＞設定するパラメーターは、"共有アドレス帳への表示"の１つ
#
#
#####################################################################################################


Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach-Object { `

		<#IF文で、"共有アドレス帳への表示"の設定が"True"で条件分岐#>

		 	if ( $_.共有アドレス帳への表示 -eq "True" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `
	
				Set-MailContact -identity $_.Alias `

				-HiddenFromAddressListsEnabled $True `

		<#IF文で、"共有アドレス帳への表示"の設定が"False"で条件分岐#>	


			}elseif ( $_.共有アドレス帳への表示 -eq "False" ){

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-MailContact -identity $_.Alias `
		
				-HiddenFromAddressListsEnabled $False `


		<#上記以外の時は、エラーメッセージが出力される#>	

			}else{ `

				Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red
	
			}

	}
