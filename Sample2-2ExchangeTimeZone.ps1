########################################################################################
#　　　Scripts概要
#
#　＞テンプレートファイルをインポートして、TimeZone等の設定を行う
#　
#　＞設定するパラメーターは、DateFormat・Language・Timeformat・TimeZone・
#　　WorkingHoursTimeZoneの５種類
#
#  ＞本SCriotsでは、DateFormat = "yyyy/MM/dd"・Language = "ja-JP"・
#    Timeformat = "H:mm"・TimeZone = "Tokyo Standard Time" ・
#    WorkingHoursTimeZone = "Tokyo Standard Time"として設定を行う
#　　
########################################################################################

Param(
  [string]$Inputfile
)

$DateFormat = "yyyy/MM/dd"	
$Language = "ja-JP"
$Timeformat = "H:mm"
$TimeZone = "Tokyo Standard Time" 
$WorkingHoursTimeZone = "Tokyo Standard Time"



	
	Import-CSV $Inputfile | ForEach { 
	
		Write-Host $_.UserPrincipalName
	
		Set-MailboxRegionalConfiguration -Identity $_.UserPrincipalName `
			-DateFormat $DateFormat `
			-Language $Language `
			-Timeformat $Timeformat `
			-TimeZone $TimeZone `
			-LocalizeDefaultFolderName:$True
		Set-MailboxCalendarConfiguration -Identity $_.UserPrincipalName -WorkingHoursTimeZone $WorkingHoursTimeZone 

			}
