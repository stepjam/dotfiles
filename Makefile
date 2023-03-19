.DEFAULT_GOAL := all

.PHONY: help
help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: pkg fish exa bat tmux fzf nvim

.PHONY: pkg-install
pkg-install:
	@./scripts/pkg.sh install

.PHONY: pkg
pkg: pkg-install

.PHONY: git-install
git-install: ## Install git
	@./scripts/git.sh install

.PHONY: bat-install
bat-install: ## Install bat
	@./scripts/bat.sh install

.PHONY: bat-configure
bat-configure: ## Configure bat
	@./scripts/bat.sh configure

.PHONY: bat
bat: bat-install bat-configure

.PHONY: tmux-install
tmux-install: ## Install tmux
	@./scripts/tmux.sh install

.PHONY: tmux-configure
tmux-configure: ## Configure tmux
	@./scripts/tmux.sh configure

.PHONY: tmux
tmux: tmux-install tmux-configure

.PHONY: fzf-install
fzf-install:
	@./scripts/fzf.sh install

.PHONY: fzf
fzf: fzf-install

.PHONY: exa-install
exa-install:
	@./scripts/exa.sh install

.PHONY: exa
exa: exa-install

.PHONY: fish-install
fish-install:
	@./scripts/fish.sh install

.PHONY: fish-configure
fish-configure:
	@./scripts/fish.sh configure

.PHONY: fish
fish: fish-install fish-configure

.PHONY: nvim-install
nvim-install:
	@./scripts/nvim.sh install

.PHONY: nvim-configure
nvim-configure:
	@./scripts/nvim.sh configure

.PHONY: nvim
nvim: nvim-install nvim-configure

