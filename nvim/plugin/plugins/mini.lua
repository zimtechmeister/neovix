require('lze').load {
    {
        "mini.ai",
        event = "DeferredUIEnter",
        after = function()
            require('mini.ai').setup()
        end,
    },
    {
        "mini.comment",
        event = "DeferredUIEnter",
        after = function()
            require('mini.comment').setup()
        end,
    },
    {
        "mini.pairs",
        event = "DeferredUIEnter",
        after = function()
            require('mini.pairs').setup()
        end,
    },
    {
        "mini.surround",
        event = "DeferredUIEnter",
        after = function()
            require('mini.surround').setup({
                mappings = {
                    add = '<leader>sa',            -- Add surrounding in Normal and Visual modes
                    delete = '<leader>sd',         -- Delete surrounding
                    find = '<leader>sf',           -- Find surrounding (to the right)
                    find_left = '<leader>sF',      -- Find surrounding (to the left)
                    highlight = '<leader>sh',      -- Highlight surrounding
                    replace = '<leader>sr',        -- Replace surrounding
                    update_n_lines = '<leader>sn', -- Update `n_lines`

                    suffix_last = 'l',             -- Suffix to search with "prev" method
                    suffix_next = 'n',             -- Suffix to search with "next" method
                },
            })
        end,
    },
    {
        "mini.files",
        event = "DeferredUIEnter",
        keys = {
            -- { '<leader>e', mode = { "n" }, function() MiniFiles.open() end, { desc = 'Open Mini Files' } },

            -- open MiniFiles in cwd
            { "<leader>e", mode = { "n" }, function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                MiniFiles.reveal_cwd()
            end,
                desc = 'Open Mini Files'
            },
        },
        after = function()
            require('mini.files').setup()
        end,
    },
    {
        "mini.icons",
        event = "DeferredUIEnter",
        after = function()
            require('mini.icons').setup()
        end,
    },
}
