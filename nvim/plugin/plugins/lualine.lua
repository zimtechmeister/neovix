require('lze').load {
    {
        "lualine.nvim",
        event = "DeferredUIEnter",
        after = function(plugin)
            require('lualine').setup({
                options = {
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = { { 'filename', path = 1, }, "macro_recording", "%S" },
                },
            })
        end,
    },
    {
        "lualine-macro-recording",
        dep_of = "lualine.nvim",
    },
}
