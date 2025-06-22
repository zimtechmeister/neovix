require('lze').load {
    {
        "noice.nvim",
        event = "DeferredUIEnter",
        after = function(plugin)
            require('noice').setup()
        end
    },
}
-- NOTE: you can also load plugins without lze (lze does more than lazyloading)
-- vim.cmd.packadd('noice.nvim')
-- require('noice').setup()
