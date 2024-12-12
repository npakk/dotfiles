#!/bin/zsh

GIT_CONFIG_LOCAL=~/.gitconfig.local
if [ ! -e $GIT_CONFIG_LOCAL ]; then
  echo -n ".gitconfig user.name?> "
  read GIT_AUTHOR_NAME

  echo -n ".gitconfig user.email?> "
  read GIT_AUTHOR_EMAIL

  cat << EOF > $GIT_CONFIG_LOCAL
[user]
		name = $GIT_AUTHOR_NAME
		email = $GIT_AUTHOR_EMAIL
EOF
fi
