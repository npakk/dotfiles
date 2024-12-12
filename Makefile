.PHONY: all
all: install

install: ./scripts/install.sh ./scripts/gitconfig.local.sh
	@chmod +x ./scripts/install.sh ./scripts/gitconfig.local.sh
	@./scripts/install.sh
	@./scripts/gitconfig.local.sh

update:
	@brew update
	@brew upgrade
	@brew cleanup

import: Brewfile
	@brew bundle --file Brewfile

export:
	@brew bundle dump -f
