return {
    "neovim/nvim-lspconfig",
    dependencias = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        vim.lsp.enable('pylsp')
        vim.lsp.enable('bashls')
    end,
}
