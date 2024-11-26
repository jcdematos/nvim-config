-- Extenal tools: ShellCheck shfmt bash-language-server fzf
-- jedi-language-server (pip)
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




local luasnip = require 'luasnip'


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


-- LSP 
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- LSP - Python Language Server
require'lspconfig'.jedi_language_server.setup{}


-- LSP - Bash Language Server
lspconfig.bashls.setup{}

-- LSP - Lua Language Server
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}





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
