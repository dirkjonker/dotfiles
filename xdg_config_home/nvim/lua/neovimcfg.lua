require("telescope").load_extension("fzf")

vim.opt.cursorline = true
-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- let's try this
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
-- vim.opt.colorcolumn = "80"

vim.opt.mouse = "a"

-- vim.opt.background = "light"
vim.opt.termguicolors = true

-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<Tab>",
--   dismiss_keymap = "<C-]>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt", "NvimTree"},
--   log_file_path = nil, -- absolute path to Tabnine log file
-- })

local cmp = require("cmp")

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  },
  sources = {
    { name = "cody" },
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
}

require("catppuccin").setup {
  flavour = "latte",

  -- I want the cursorline to be lighter on dark background
  -- and darker on light background
  -- the dark colors are in between base and surface0
  highlight_overrides = {
    latte = function(colors)
      return { CursorLine = { bg = colors.mantle } }
    end,
    frappe = function()
      return { CursorLine = { bg = "#383c4f" } }
    end,
    macchiato = function()
      return { CursorLine = { bg = "#2d3044" } }
    end,
    mocha = function()
      return { CursorLine = { bg = "#272839" } }
    end,
  }
}

vim.api.nvim_command("colorscheme catppuccin")

require("lualine").setup {
  options = {
    --theme = "catppuccin",
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

-- ALE config
-- CHECK LOCAL FILES IN ~/.config/nvim/ftplugin
-- since those override whatever is here
vim.g.ale_fix_on_save = true
vim.g.ale_fixers = {
  css             = { "prettier", "remove_trailing_lines", "trim_whitespace" },
  groovy          = { "remove_trailing_lines", "trim_whitespace" },
  hcl             = { "terraform", "trim_whitespace", "remove_trailing_lines" },
  javascript      = { "prettier" },
  javascriptreact = {},
  json            = { "prettier", "remove_trailing_lines", "trim_whitespace" },
  lua             = { "remove_trailing_lines", "trim_whitespace" },
  markdown        = { "remove_trailing_lines", "trim_whitespace" },
  ocaml           = { "remove_trailing_lines", "trim_whitespace", "ocp-indent" },
  -- ruby            = { "rubocop", "remove_trailing_lines", "trim_whitespace" },
  -- rust            = { "trim_whitespace" },
  sass            = { "remove_trailing_lines", "trim_whitespace" },
  scss            = { "prettier" },
  slim            = { "remove_trailing_lines", "trim_whitespace" },
  sql             = { "remove_trailing_lines", "trim_whitespace" },
  svelte          = {},
  typescript      = { "prettier" },
  typescriptreact = {},
  yaml            = { "remove_trailing_lines", "trim_whitespace" },
}

-- vim.g.ale_ruby_rubocop_executable = "bundle"

vim.g.ale_linters = {
  eruby           = { "erblint" },
  ruby            = { "rubocop" },
  rust            = {},
  javascript      = {},
  typescript      = {},
  typescriptreact = {},
  svelte          = {},
}

vim.g.user_emmet_settings = {
  typescriptreact = {
    extends = "html",
    attribute_name = {
      class = "class",
      ["for"] = "for",
      empty_element_suffix = " />",
    },
  },
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<C-P>", telescope.find_files, opts)
vim.keymap.set("n", "<leader>pf", telescope.find_files, opts)
vim.keymap.set("n", "<leader>pg", telescope.live_grep, opts)
vim.keymap.set("n", ";", telescope.buffers, opts)

vim.keymap.set("n", "<leader>tn", ":tabnew", opts)
vim.keymap.set("v", "<leader>sr", ":s", opts)

map("n", "{", ":tabprevious<CR>", opts)
map("n", "}", ":tabnext<CR>", opts)

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- treesitter config
require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "css",
    "html",
    "javascript",
    "lua",
    "ruby",
    "rust",
    "svelte",
    "typescript",
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  ts_context_commentstring = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
}

-- Language Server Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

function ToggleBackground()
  if vim.api.nvim_get_option("background") == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

map("n", "<leader>bd", "<cmd>set background=dark<CR>", opts)
map("n", "<leader>bl", "<cmd>set background=light<CR>", opts)
map("n", "<leader>bb", "<cmd>lua ToggleBackground()<CR>", opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
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
    -- run formatting on save
    -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    -- local fmt_cmd_id = vim.api.nvim_create_autocmd('BufWritePre', {
    --   buffer = ev.buf,
    --   callback = function()
    --     vim.lsp.buf.format()
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd('LspDetach', {
    --   callback = function()
    --     vim.api.nvim.nvim_del_autocmd(fmt_cmd_id)
    --   end,
    -- })
  end,
})


local lsp = require("lspconfig")
-- vim.lsp.set_log_level("debug")

require('fidget').setup()

lsp.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
}

-- textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

lsp.ruby_ls.setup {
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end
}

lsp.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true
      },
      files = {
        excludeDirs = { "tmp", "node_modules", "frontend", "frontend/node_modules", "tmp/node_modules" }
      }
    },
  }
}

lsp.denols.setup {
  root_dir = lsp.util.root_pattern("deno.json"),
}

lsp.svelte.setup {
  root_dir = lsp.util.root_pattern("svelte.config.js"),
  filetypes = { "svelte" }
}

lsp.tsserver.setup {
}

require("typespec")
lsp.typespec.setup {
}

require("sg").setup {
}
