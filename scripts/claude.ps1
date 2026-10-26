$sourcePath = Join-Path (Convert-Path .) "ai"
$configPath = Join-Path $HOME ".claude"

New-Item $configPath -ItemType Directory -Force | Out-Null
Copy-Item (Join-Path $sourcePath "AGENTS.md") (Join-Path $configPath "CLAUDE.md") -Force
Copy-Item (Join-Path $sourcePath ".claude\settings.json") (Join-Path $configPath "settings.json") -Force
exit
