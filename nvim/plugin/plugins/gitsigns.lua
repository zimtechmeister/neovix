require('lze').load {
    {
        "gitsigns.nvim",
        event = "DeferredUIEnter",
        after = function()
            require('gitsigns').setup()
        end,
    }
}
