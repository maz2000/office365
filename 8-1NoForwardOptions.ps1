#メールの転送を禁止する設定
#$PolicyName ポリシー名
#$IsDefault 既定のポリシーにする




Param([string]$PolicyName,[Switch]$IsDefault)


#[MyBaseOptions] という既存の役割項目をもとに 
#[NoForwardMyBaseOptions] という新規の役割項目を作成します。

New-ManagementRole -Parent MyBaseOptions -Name NoForwardMyBaseOptions 

#[接続されているアカウント] 画面にて設定できる転送機能を、[NoForwardMyBaseOptions] から削除します。 
Set-ManagementRoleEntry NoForwardMyBaseOptions\Set-Mailbox -Parameters DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress -RemoveParameter 

#[NoForwardMyBaseOptions] を含めた役割の割り当てポリシー [$PolicyName] を作成します。
New-RoleAssignmentPolicy -Name $PolicyName -Roles NoForwardMyBaseOptions,MyContactInformation,MyRetentionPolicies,MyTextMessaging, MyVoiceMail,MyDistributionGroupMembership,MyDistributionGroups, Myprofileinformation,MyMailSubscriptions,MyTeamMailboxes,"My Marketplace Apps"

if ( $IsDefault -eq $true) {

Write-Host "Default"

Set-RoleAssignmentPolicy -Identity $PolicyName -IsDefault

}

Get-RoleAssignmentPolicy -Identity $PolicyName




<#
———————————————————————————————————— 
2-3. 作成したポリシーをユーザーに適用する 
———————————————————————————————————— 
2-3-A. 組織内のメールボックスを持つユーザー全員に一括で適用する 
Get-Mailbox | Set-Mailbox -RoleAssignmentPolicy NoDisplayForwardSetting 

———————————————————————————————————— 
2-3-A. 組織内のメールボックスを持つユーザー全員に一括で適用する 
Get-Mailbox | Set-Mailbox -RoleAssignmentPolicy NoDisplayForwardSetting 
2-3-B. 各ユーザーへ個別に適用する 
Set-Mailbox ＜対象ユーザーのメールアドレス＞ -RoleAssignmentPolicy NoDisplayForwardSetting 
※ Microsoft Online ポータルにて、管理者権限を付与されているユーザーには、上記ポリシーのアサインが有効になりませんので、一旦ユーザー権限に変更してから、ポリシーのアサイン作業をしていただく必要がございます。 

#>