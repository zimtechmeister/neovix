require('conform').setup({
    formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
    },
})
