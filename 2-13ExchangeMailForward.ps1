########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、転送設定を行う
#　
#　＞設定するパラメーターは、転送設定と転送元にメールを残すか残さないかで
#　　分ける。
#　　
########################################################################################


Param(
[string]$Inputfile
)

<#テンプレートファイルのインポート#>

	Import-CSV $Inputfile | ForEach { `

		<#IF文で、"転送元のメールボックスにもメールを残す"が"True"の時で条件分岐#>

			if ( $_.転送元のメールボックスにもメールを残す -eq "True" ){

				Write-Host $_.ユーザー名 -foregroundColor Blue

				Set-Mailbox -Identity $_.ユーザー名 `

					-DeliverToMailboxAndForward $True `

					-ForwardingAddress $_.転送先メールアドレス `

		<#IF文で、"転送元のメールボックスにもメールを残す"が"False"の時で条件分岐#>

			}elseif ( $_.転送元のメールボックスにもメールを残す -eq "False" ){ `

				Write-Host $_.ユーザー名 -foregroundColor Blue `

				Set-Mailbox -Identity $_.ユーザー名 `

					-DeliverToMailboxAndForward $False `

					-ForwardingAddress $_.転送先メールアドレス `

	}




			}
