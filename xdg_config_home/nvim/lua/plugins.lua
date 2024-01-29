--   -- fuzzy finder
--   { "ibhagwan/fzf-lua",             opt = true },
--   -- { "ratfactor/zf.vim",             opt = true },

vim.cmd [[packadd packer.nvim]]

-- vim.g.ale_disable_lsp = 1

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdateSync'
  }

  -- for svelte files that mix html, js and css
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- block matching
  -- use "andymass/vim-matchup"

  -- splitting and joining lines smartly gS gJ
  -- use "AndrewRadev/splitjoin.vim"

  use "simrat39/rust-tools.nvim"
  use "mfussenegger/nvim-dap"

  use 'dense-analysis/ale'
  use {
    "j-hui/fidget.nvim",
  }

  use "nvim-lua/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/nvim-cmp"

  use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' }
  -- use "github/copilot.vim"

  use "tpope/vim-commentary"
  use 'tpope/vim-fugitive'
  use "tpope/vim-rails"
  --  use "tpope/vim-surround"
  --  use "tpope/vim-repeat"
  use 'machakann/vim-sandwich'

  -- auto close parens and other surrounding characters
  use "cohama/lexima.vim"

  use "mattn/emmet-vim"

  use "nvim-tree/nvim-web-devicons"
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  }

  -- themes
  use "catppuccin/nvim"
  --  use "EdenEast/nightfox.nvim"
  --  use "folke/tokyonight.nvim"
  --  use "catppuccin/nvim"
  --  use "mcchrish/zenbones.nvim"
  --  use "rktjmp/lush.nvim"
  --  use "ellisonleao/gruvbox.nvim"
  --  use "savq/melange"
  --  use "shaunsingh/moonlight.nvim"
  --  use "shaunsingh/nord.nvim"
  --  use "shaunsingh/solarized.nvim"
end)
