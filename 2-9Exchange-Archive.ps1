########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、アーカイブの設定を行う
#　
#　＞設定するパラメーターは、"アーカイブ"の1種類
#　　
########################################################################################

Param(
  [string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { 
 			if ( $_.アーカイブ -eq "True" ){ 
				Write-Host $_.ユーザー名 -foregroundColor Blue 
				enable-mailbox -Identity $_.ユーザー名 -archive
			}else{　
				Write-Host $_.ユーザー名 アーカイブ設定はしていません。 -foregroundColor Red 
			}
		
	}