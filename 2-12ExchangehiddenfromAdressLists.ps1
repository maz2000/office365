#####################################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、MailBoxのGALへの表示非表示の設定を行う
#
#　＞設定するパラメーターは、"共有アドレス帳への表示"の１つ
#
# コメント追加
#
#####################################################################################################


Param(
  [string]$Inputfile
)


	Import-CSV $Inputfile | ForEach-Object { 
 			if ( $_.共有アドレス帳への表示 -eq "True" ){ 
#				Write-Host $_.ユーザー名 -foregroundColor Blue 
				Set-Mailbox -Identity $_.ユーザー名 `
					-HiddenFromAddressListsEnabled $True 	

			}elseif ( $_.共有アドレス帳への表示 -eq "False" ){ 
				Write-Host $_.ユーザー名 -foregroundColor Blue 
				Set-Mailbox -Identity $_.ユーザー名 `
					-HiddenFromAddressListsEnabled $False `

			}else{ 
				Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red
			}
	}


