onAttach = function(_, bufnr)
    -- NOTE: for sane defaults checkout the "lsp.on_attach.lua" file in nixCats example template
    -- https://github.com/BirdeeHub/nixCats-nvim/blob/main/templates/example/lua/myLuaConf/LSPs/on_attach.lua
    -- also shown in nixCats docs(lsp)

    -- TODO: dont know if this is the correct place to do this
    vim.diagnostic.config({
        -- hoide anoying underline on warnings or errors
        underline = false,
        -- use nerdfont symbols for diagnostics on left
        float = {
            style = 'minimal',
            border = "rounded",
            source = 'if_many',
            header = '',
            prefix = '',
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = " ",

                -- [vim.diagnostic.severity.ERROR] = '󰅚',
                -- [vim.diagnostic.severity.WARN] = '⚠',
                -- [vim.diagnostic.severity.INFO] = 'ⓘ',
                -- [vim.diagnostic.severity.HINT] = '󰌶',
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                [vim.diagnostic.severity.WARN] = "WarningMsg",
            },
        },
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
        { desc = 'format buffer', buffer = bufnr })
    vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.open_float()<cr>',
        { desc = 'show diagnostic' })
    vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.lsp.buf.hover()<cr>',
        { desc = 'hover', buffer = bufnr })
    vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>',
        { desc = 'definition', buffer = bufnr })
    vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
        { desc = 'declaration', buffer = bufnr })
    vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>',
        { desc = 'implementation', buffer = bufnr })
    vim.keymap.set('n', '<leader>lo', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
        { desc = 'type definition', buffer = bufnr })
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>',
        { desc = 'references', buffer = bufnr })
    vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
        { desc = 'signature help', buffer = bufnr })
    vim.keymap.set('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>',
        { desc = 'rename', buffer = bufnr })
    vim.keymap.set('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<cr>',
        { desc = 'code actions', buffer = bufnr })
end


require('lze').register_handlers(require('lzextras').lsp)
require('lze').load {
    -- NOTE: for default lsp names and setting set by nvim-lspconfig visit https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    {
        "nvim-lspconfig",
        on_require = { "lspconfig" },

        lsp = function(plugin)
            vim.lsp.config(plugin.name, plugin.lsp or {})
            vim.lsp.enable(plugin.name)
        end,
        before = function(_)
            vim.lsp.config('*', {
                on_attach = onAttach,
            })
        end,
    },

    {
        "lazydev.nvim",
        cmd = { "LazyDev" },
        ft = "lua",
        after = function(_)
            require('lazydev').setup({
                library = {
                    { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
                },
            })
        end,
    },
    {
        "lua_ls",
        lsp = {
            -- if you provide the filetypes it doesn't ask lspconfig for the filetypes
            filetypes = { 'lua' },
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    formatters = {
                        ignoreComments = true,
                    },
                    signatureHelp = { enabled = true },
                    diagnostics = {
                        globals = { "nixCats", "vim", },
                        disable = { 'missing-fields' },
                    },
                    telemetry = { enabled = false },
                },
            },
        },
    },
    {
        "jdtls",
        lsp = {},
    },
    {
        "clangd",
        lsp = {
            filetypes = { 'c', 'cpp' },
            -- clangd has some defaults set by lspconfig so i need this extra line here
            -- it should always match the lsp-attach file that is sourced by lspconfig
            on_attach = onAttach,
            -- settings = {
            --     clangd = {
            --         formatting = {
            --             command = { "clang-format"}
            --         }
            --     }
            -- }
        },
    },
    {
        "rust_analyzer",
        lsp = {
            -- rust-analyzer has some defaults set by lspconfig so i need this extra line here
            -- it should always match the lsp-attach file that is sourced by lspconfig
            on_attach = onAttach,
        },
    },
    {
        "sqls",
        lsp = {},
    },
    {
        -- TODO: look into nixCats docs or example template for config
        "nixd",
        lsp = {
            filetypes = { 'nix' },
            cmd = { "nixd" },
            settings = {
                nixd = {
                    formatting = {
                        command = { "alejandra" },
                    },
                    -- nixpkgs = {
                    --     expr = "import <nixpkgs> { }",
                    --     expr = 'import (builtins.getFlake "/home/tim/nixos").inputs.nixpkgs {}',
                    -- },
                    -- options = {
                    --     --If you integrated with your system flake,
                    --     --you should use inputs.self as the path to your system flake
                    --     -- that way it will ALWAYS work, regardless
                    --     -- of where your config actually was.
                    --     nixos = {
                    --         -- expr = '(builtins.getFlake "github:zimtech/nixos").nixosConfigurations.PC.options',
                    --         expr = '(builtins.getFlake "/home/tim/nixos").nixosConfigurations.PC.options',
                    --     },
                    --     home_manager = {
                    --         expr = '(builtins.getFlake "/home/tim/nixos").homeConfigurations.tim.options',
                    --     },
                    -- }
                },
            },
        },
    },
}
