require('lze').load {
    {
        "conform.nvim",
        event = "DeferredUIEnter",
        after = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                },
            })
        end,
    }
}
