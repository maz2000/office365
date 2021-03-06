########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、Password設定と、
#　　ForceChangePassword(初回Login時のPassword変更)の設定を行う
#
#　＞設定するパラメーターは、Passwordと初回Login時のPassword変更の2種類
#
#
########################################################################################



Param(
 [string]$Inputfile
 )


ここから日本語を入力します。


 日本語


	Import-CSV $Inputfile | ForEach-Object { `
			Write-Host $_.ユーザー名
			Write-Host $_.Password
			Write-Host $_.初回サインイン時のPassword変更			
			Write-Host $_.Password無期限化
		
		 	if ($_.初回サインイン時のPassword変更 -eq "TRUE") { 
			 	Write-Host $_.ユーザー名 -foregroundColor Blue 
				Set-MsolUserPassword –UserPrincipalName $_.ユーザー名 `
					-ForceChangePassword $True `
					-NewPassword $_.Password
		 	}elseif ($_.初回サインイン時のPassword変更 -eq "FALSE") { 
			 	Write-Host $_.ユーザー名
				Set-MsolUserPassword –UserPrincipalName $_.ユーザー名 `
					-ForceChangePassword $false `
					-NewPassword $_.Password 
			}else{ 
			Write-Host $_.ユーザー名 入力項目にエラーがあります。 -foregroundColor Red
			}



	}
