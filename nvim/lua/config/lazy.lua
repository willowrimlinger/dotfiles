-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.ruler = false
vim.o.showcmd = false
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.autoindent = true
vim.o.fixeol = false
vim.o.relativenumber = true
vim.o.number = true
vim.o.cc = "80"
vim.o.timeout = true
vim.o.timeoutlen = 3000
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.keymap.set("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", {desc="Switch between C source and header file"})
vim.keymap.set("n", "<c-v>", "<cmd>vert sb#<cr>", {desc="Open last buffer vertically split"})
vim.o.splitright = true
vim.o.splitbelow = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "H", "^", {desc="BOL"})
vim.keymap.set("n", "L", "$", {desc="EOL"})
vim.keymap.set("n", "<leader>rf", ":checktime<CR>", {desc="Refresh buffers for external changes"})
vim.keymap.set("n", "<C-s>", ":w<CR>", {desc="Write"})
vim.cmd.cabbrev("Conf", "tabnew | lcd ~/.config/nvim/lua/config/plugins | e ~/.config/nvim/lua/config/lazy.lua")
vim.cmd.cabbrev("Notes", "tabnew | lcd ~/sync/notes/school/fourth_yr/fall/ | NvimTreeOpen")
vim.cmd([[
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
]])
vim.keymap.set("n", "<leader>sce", "<cmd>setlocal spell spelllang=en_us<cr>", {desc="Enable spellcheck"})
vim.keymap.set("n", "<leader>scd", "<cmd>setlocal nospell<cr>", {desc="Disable spellcheck"})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	command = "setlocal shiftwidth=4 tabstop=4"
})
vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz", {desc="Move to next item in quickfix list"})
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz", {desc="Move to prev item in quickfix list"})

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
    {import = "config.plugins"},
    {import = "config.plugins.lsp"},
    {import = "config.colorschemes"} })

vim.cmd [[colorscheme gruvbox]]
