require('lze').load {
    "nvim-scrollbar",
    event = "DeferredUIEnter",
    after = function()
        require('scrollbar').setup()
    end,
}
