.DEFAULT_GOAL := all

.PHONY: help
help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# all: pkg zsh exa git bat tmux fzf ohmyzsh vim miniconda
all: zsh exa bat tmux fzf ohmyzsh vim

.PHONY: pkg-install
pkg-install: ## Install Ubuntu packages
	@./scripts/pkg.sh install

.PHONY: pkg
pkg: pkg-install ## pkg-install

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
bat: bat-install bat-configure ## bat-install bat-configure

.PHONY: tmux-install
tmux-install: ## Install tmux
	@./scripts/tmux.sh install

.PHONY: tmux-configure
tmux-configure: ## Configure tmux
	@./scripts/tmux.sh configure

.PHONY: tmux
tmux: tmux-install tmux-configure ## tmux-install tmux-configure

.PHONY: fzf-install
fzf-install: ## Install fzf
	@./scripts/fzf.sh install

.PHONY: fzf
fzf: fzf-install ## fzf-install

.PHONY: exa-install
exa-install: ## Install exa
	@./scripts/exa.sh install

.PHONY: exa
exa: exa-install ## exa-install

.PHONY: zsh-install
zsh-install: ## Install zsh
	@./scripts/zsh.sh install

.PHONY: zsh-configure
zsh-configure: ## Configure zsh
	@./scripts/zsh.sh configure

.PHONY: zsh
zsh: zsh-install zsh-configure ## zsh-install zsh-configure

.PHONY: ohmyzsh-install
ohmyzsh-install: ## Install Oh My Zsh
	@./scripts/ohmyzsh.sh install

.PHONY: ohmyzsh-configure
ohmyzsh-configure: ## Configure Oh My Zsh
	@./scripts/ohmyzsh.sh configure

.PHONY: ohmyzsh
ohmyzsh: ohmyzsh-install ohmyzsh-configure ## ohmyzsh-install ohmyzsh-configure

.PHONY: vim-install
vim-install: ## Install vim
	@./scripts/vim.sh install

.PHONY: vim-configure
vim-configure: ## Configure vim
	@./scripts/vim.sh configure

.PHONY: vim
vim: vim-install vim-configure ## vim-install vim-configure

