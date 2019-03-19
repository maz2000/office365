$input = Read-Host "動物の名前を入力してください"
 
switch($input)
{
  "penguin" {Write-Output ("ペンギンが入力されました。")}
  "dog" {Write-Output ("犬が入力されました。")}
  "cat" {Write-Output ("猫が入力されました。")}
  "bear" {Write-Output ("くまが入力されました。")}
  default {Write-Output ("登録されている以外の名前が入力されました。")}
}