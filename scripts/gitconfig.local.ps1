$homePath = [Environment]::GetFolderPath("UserProfile")

# .gitconfig本体（他のps1と同様にコピー）
$source = Join-Path (Convert-Path .) ".gitconfig"
Copy-Item $source (Join-Path $homePath ".gitconfig") -Force

# .gitconfig.local（未作成の場合のみ）
$gitConfigLocal = Join-Path $homePath ".gitconfig.local"
if (-not (Test-Path $gitConfigLocal)) {
  $name  = Read-Host ".gitconfig user.name?"
  $email = Read-Host ".gitconfig user.email?"

  git config --file $gitConfigLocal user.name  $name
  git config --file $gitConfigLocal user.email $email
}
exit
