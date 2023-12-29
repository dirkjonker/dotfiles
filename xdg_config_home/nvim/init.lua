if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_theme = 'auto'
  vim.opt.guifont = "Iosevka Term:h14"
end

if vim.g.vscode then
  require('plugins-vscode')
else
  require('plugins')
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

-- search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "

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

-- color stuff
if vim.g.vscode then
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  map("n", "<leader>ca", "<cmd>call VSCodeNotify('editor.action.quickFix')<CR>", opts)
  map("n", "<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>", opts)
else
  require "neovimcfg"
end -- if not vim.g.vscode then
