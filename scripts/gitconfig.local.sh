#!/bin/zsh

GIT_CONFIG_LOCAL="$HOME/.gitconfig.local"

if [ ! -e "$GIT_CONFIG_LOCAL" ]; then
  echo -n ".gitconfig user.name?> "
  read GIT_AUTHOR_NAME

  echo -n ".gitconfig user.email?> "
  read GIT_AUTHOR_EMAIL

  cat << EOF > "$GIT_CONFIG_LOCAL"
[user]
	name = $GIT_AUTHOR_NAME
	email = $GIT_AUTHOR_EMAIL
EOF

  if grep -qi microsoft /proc/version 2>/dev/null; then
    WIN_USER=$(cmd.exe /C "echo %USERNAME%" 2>/dev/null | tr -d '\r')

    cat << EOF >> "$GIT_CONFIG_LOCAL"

[credential]
    helper = /mnt/c/Users/$WIN_USER/scoop/apps/git/current/ucrt64/bin/git-credential-manager.exe
EOF
  fi
fi
