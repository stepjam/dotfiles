-- vim: foldmethod=marker
local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec([[
augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    -- Vanity {{{
    use 'wbthomason/packer.nvim'
    use 'mhinz/vim-startify'
    use 'akinsho/nvim-bufferline.lua'
    use 'hoob3rt/lualine.nvim'
    use 'gruvbox-community/gruvbox'
    use 'arcticicestudio/nord-vim'
    use 'joshdick/onedark.vim'
    use 'sheerun/vim-polyglot'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'kyazdani42/nvim-web-devicons'
    use {'RRethy/vim-hexokinase', run = 'make hexokinase'}
    -- }}}

    -- IDE-like features {{{
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
    use 'junegunn/fzf.vim'
    use 'voldikss/vim-floaterm'
    use 'liuchengxu/vista.vim'
    use 'pechorin/any-jump.vim'
    use 'rhysd/git-messenger.vim'
    use 'tpope/vim-fugitive'
    use 'folke/which-key.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }
    -- }}}

    -- Tmux integration {{{
    use 'tmux-plugins/vim-tmux'
    use 'urbainvaes/vim-tmux-pilot'
    -- }}}

    -- Text editing features {{{
    use 'mbbill/undotree'
    use 'wellle/targets.vim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    -- }}}

    -- " Languages/LSP {{{
    use {'fatih/vim-go', ft = {'go', 'gomod'}}
    use {'andrejlevkovitch/vim-lua-format', ft = {'lua'}}
    use 'hashivim/vim-terraform'
    use {'neoclide/coc.nvim', branch = 'release'}
    use {'antoinemadec/coc-fzf', branch = 'release'}
    use 'godlygeek/tabular' -- required to format Markdown tables
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end
    }
    -- }}}
end)

require('custom/settings')
require('custom/mappings')
require('custom/theme')

require('plugin/lualine')
require('plugin/nvim-bufferline')
require('plugin/nvim-treesitter')
require('plugin/telescope')
require('plugin/which-key')
