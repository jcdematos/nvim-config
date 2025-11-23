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
-- ======================--
-- == EDITOR SETTINGS == --
-- ======================--

-- Consider moving options to an options.lua file
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

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

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

