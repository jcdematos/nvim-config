-- Extenal tools: ShellCheck shfmt bash-language-server fzf
-- =========================== --
-- == SOURCE CONFIGURATIONS == --
-- =========================== --
require "config"
require "remaps"
require "git"
require "user_functions"

-- ======================--
-- == EDITOR SETTINGS == --
-- ======================--


-- Consider moving options to an options.lua file
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

-- LSP 
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

-- LSP - Bash Language Server
require'lspconfig'.bashls.setup{}

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

local luasnip = require 'luasnip'

-- BINDINGS --
-- Terminal Bindings
vim.keymap.set('t', '<Leader><ESC>', '<C-\\><C-n>', {noremap = true}) -- Exit terminal
vim.keymap.set('n', '<Leader>tm', '5<C-w>_') -- Minimize terminal
vim.keymap.set('n', '<Leader>ts', '<C-w>s<C-w>j:terminal<CR>i') -- Open terminal in split mode

-- Text Editing
vim.keymap.set('', '-', 'ddp')
vim.keymap.set('', '_', 'ddkP')

-- EDITOR CONFIGURATION
vim.opt.tabstop = 4      -- visual space for tab
vim.opt.shiftwidth = 4	 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs as spaces

vim.opt.showmode = true

-- Searching
-- vim.opt.incsearch = true            -- search as characters are entered
-- vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- LINTING AND CODE CHECKING
vim.g.ale_linters = {
  csh = { "language_server" },
}


---------------------------- 
vim.g.ale_completion_enable = 1
vim.g.netwr_liststyle = 4


-- command! Scratch lua require'tools'.makeScratch()
