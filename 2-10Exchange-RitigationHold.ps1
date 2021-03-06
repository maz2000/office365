########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、訴訟ホールドの設定を行う
#　
#　＞設定するパラメーターは、"訴訟ホールド"の1種類
#　　
########################################################################################

Param(
  [string]$Inputfile
)

	Import-CSV $Inputfile | ForEach { 
			if ( $_.訴訟ホールド -eq "True" ){
				Write-Host $_.ユーザー名 
				Set-Mailbox -Identity $_.ユーザー名 `
					-LitigationHoldEnabled $true 
			}else{ 
				Write-Host $_.ユーザー名 訴訟ホールド設定はしていません。 -foregroundColor Red 	
			}
	}