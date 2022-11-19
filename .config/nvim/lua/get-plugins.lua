local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require("packer").startup(function()
  use "wbthomason/packer.nvim"

  if packer_bootstrap then
    require('packer').sync()
  end

  use 'lewis6991/impatient.nvim'

  use "bronson/vim-trailing-whitespace" -- https://github.com/bronson/vim-trailing-whitespace

  use 'phaazon/hop.nvim'
  use 'kien/ctrlp.vim'
  use {
    'lukas-reineke/indent-blankline.nvim',
  }
  use 'NvChad/nvim-colorizer.lua'

  -- Themes
  use 'nanotech/jellybeans.vim'
  use "lunarvim/Onedarker.nvim"
  use { "ellisonleao/gruvbox.nvim" }
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"
  use 'sainnhe/everforest'
  use 'dracula/vim'
  use 'navarasu/onedark.nvim'


  use 'tpope/vim-surround'
  use 'tpope/vim-speeddating'

  -- git
  use 'tpope/vim-fugitive'
  use 'godlygeek/tabular'

  use 'mattn/emmet-vim'
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use 'rmagatti/auto-session'
  use 'leafOfTree/vim-matchtag'
  use 'andymass/vim-matchup'

  use 'mhinz/vim-grepper'
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  use 'kevinhwang91/promise-async'
  use 'kevinhwang91/nvim-ufo'
  use 'rcarriga/nvim-notify'

  use 'L3MON4D3/LuaSnip'
  -- use 'neoclide/coc-snippets'
  use 'rafamadriz/friendly-snippets'
  -- If you're using coc.nvim, you can use:
  -- CocInstall https://github.com/rafamadriz/friendly-snippets@main

  use 'tomtom/tlib_vim'
  use 'xolox/vim-misc'

  use 'luochen1990/rainbow'
  use 'preservim/tagbar'
  use 'mbbill/undotree'

  use 'junegunn/vim-easy-align'
  use 'tpope/vim-tbone'
  use 'aserowy/tmux.nvim'

  use 'windwp/nvim-spectre'
  use 'gennaro-tedesco/nvim-peekup'
  use 'gbprod/yanky.nvim'
  use 'b3nj5m1n/kommentary'

  -- use 'justinmk/vim-sneak'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use 'rhysd/conflict-marker.vim'
  use 'chentoast/marks.nvim'

  -- prefer coc diagnostics + ???
  -- use 'folke/trouble.nvim'

  use 'mg979/vim-visual-multi'

  use 'farmergreg/vim-lastplace'

  use 'mileszs/ack.vim'
  use 'hashivim/vim-hashicorp-tools'
  use 'hashivim/vim-terraform'

  use 'junegunn/fzf'
  use 'averms/black-nvim'

  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'
  use 'fatih/vim-go'
  use 'mfussenegger/nvim-dap'

  use "rhysd/vim-clang-format"          -- https://github.com/rhysd/vim-clang-format
  use 'dense-analysis/ale' -- prefer Coc

  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use {
      "nvim-treesitter/nvim-treesitter",      -- https://github.com/nvim-treesitter/nvim-treesitter
  }
  use 'nvim-treesitter/tree-sitter-query'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  -- :CocInstall coc-pairs
  -- :CocInstall coc-pyright
  -- Install coc-diagnostic -
  -- :CocInstall coc-diagnostic.
  -- This extension will automatically install diagnostic-languageserver for you.
end)
