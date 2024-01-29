-- prevent space from moving cursor in normal mode
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.opt.cursorline = true
-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- let's try this - nope don't like it
vim.opt.smartindent = false

-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
-- vim.opt.colorcolumn = "80"

vim.opt.mouse = "a"

-- vim.opt.background = "light"
vim.opt.termguicolors = true

-- search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.neovide then
  require("neovidecfg")
end

vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall

    inoremap <C-S>= <%=<Space><Space>%><Esc>2hi
    inoremap <C-S>- <%<Space><Space>%><Esc>2hi
    inoremap <C-S>e <%<Space>end<Space>%><Esc>O
    inoremap <C-S>i <%<Space>if<Space>%><Esc>2hi
]])


vim.keymap.set("n", "K", function()
end)

-- move selected lines in visual mode up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor centered when moving/searching up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("", "<C-p>", "<cmd>Files<cr>")

vim.keymap.set("n", "H", "<cmd>tabprev<cr>")
vim.keymap.set("n", "L", "<cmd>tabnext<cr>")

-- settings for leap as it uses s/S by default which I use for vim-sandwich
vim.keymap.set("n", "f", "<Plug>(leap-forward)")
vim.keymap.set("n", "F", "<Plug>(leap-backward)")

function ToggleBackground()
  if vim.api.nvim_get_option("background") == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

vim.keymap.set("n", "<leader>bb", "<cmd>lua ToggleBackground()<CR>")

-- install lazy if not present (useful on newly installed OSes)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- then load it
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- load very first thing
    config = function()
      vim.cmd([[colorscheme tokyonight]])
      -- vim.opt.background = "light"
    end
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup {
        options = {
          -- theme = "gruvbox",
          component_separators = '',
          section_separators = '',
        },

        sections = {
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
            }
          },
          lualine_x = { 'encoding', 'filetype' },
        }
      }
    end
  },
  -- quick navigation
  {
    "ggandor/leap.nvim",
    lazy = false,
    -- config = function()
    --   vim.keymap.set("n", "<leader>f", "<Plug>(leap-forward)")
    --   vim.keymap.set("n", "<leader>F", "<Plug>(leap-backward)")
    -- end
  },
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 10000,
    },
  },
  { "machakann/vim-sandwich" },
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  {
    "tpope/vim-rails",
    ft = { "ruby", "erb" },
  },
  {
    "junegunn/fzf.vim",
    dependencies = {
      { "junegunn/fzf", build = "./install --all" },
    },
    config = function()
      -- stop putting a giant window over my editor
      vim.g.fzf_layout = { down = '~30%' }
      vim.api.nvim_create_user_command('Files', function(arg)
        vim.fn['fzf#vim#files'](arg.qargs, { source = "fd --type file --follow", options = '--tiebreak=index' }, arg
          .bang)
      end, { bang = true, nargs = '?', complete = "dir" })
    end
  },
  -- { -- when using this, disable rust_analyzer setup below in LSP
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   ft = { "rust" },
  -- },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")

      lsp.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            }
          }
        }
      }

      lsp.rust_analyzer.setup {
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
            diagnostics = {
              enable = true
            },
            files = {
              excludeDirs = { "tmp", "node_modules", "frontend", "frontend/node_modules", "tmp/node_modules" }
            }
          },
        }
      }

      lsp.svelte.setup {
        root_dir = lsp.util.root_pattern("svelte.config.js"),
        filetypes = { "svelte" }
      }

      lsp.tsserver.setup {}

      require("typespec")
      lsp.typespec.setup {}

      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          -- no because of nvim-cmp
          -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)

          -- local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
          -- *and* there's some way to make it only apply to the current line.
          -- if client.server_capabilities.inlayHintProvider then
          --     vim.lsp.inlay_hint(ev.buf, true)
          -- end

          -- Disabling semantics tokens will stop syntax highlighting from changing randomly.
          -- client.server_capabilities.semanticTokensProvider = nil
        end,
      })
    end
  },
  -- LSP-based code-completion
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'neovim/nvim-lspconfig',
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          -- REQUIRED by nvim-cmp ...
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Accept currently selected item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "cody" },
          { name = "nvim_lsp" },
          { name = "path" },
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Enable completing paths in :
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        })
      })
    end
  },
  -- svelte
  {
    "evanleck/vim-svelte",
    ft = { "svelte" },
  },
  -- sourcegraph cody
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },
    event = "InsertEnter",

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    -- build = "nvim -l build/init.lua",
    config = function()
      require("sg").setup {}
    end
  },
})
