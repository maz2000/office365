########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、ResourceMailBoxの登録を行う
#
#　＞設定するパラメーターは、名称・電子メールアドレス
#
#
########################################################################################


Param(
  [string]$Inputfile
)

Import-Csv $Inputfile | %{


Write-Host  $_.電子メールアドレス
Write-host $_.名称			
New-Mailbox -name $_.名称 -PrimarySmtpAddress $_.電子メールアドレス -Equipment

#	"設備"   {New-Mailbox -name $r.名称 -PrimarySmtpAddress $r.電子メールアドレス -Equipment}
#	default {Write-host "$_ is other value"}
	
}

