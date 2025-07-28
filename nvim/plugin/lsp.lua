-- defaut config provided by nvim-lspconfig
-- for reference https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('jdtls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('nixd')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- NOTE: this is build in completion but i'm currently using blink
        -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        --     vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup', 'preview' }
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        --     vim.keymap.set('i', '<C-Space>', function()
        --         vim.lsp.completion.get()
        --     end)
        -- end

        -- here i dont check for given capabilities anymore
        vim.keymap.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { desc = 'format buffer', buffer = ev.buf })
        vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.open_float()<cr>',
            { desc = 'show diagnostic' })
        vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>',
            { desc = 'definition', buffer = ev.buf })
        vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
            { desc = 'declaration', buffer = ev.buf })
        vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            { desc = 'signature help', buffer = ev.buf })
    end,
})

vim.diagnostic.config({
    -- hide anoying underline on warnings or errors
    underline = false,
    -- use nerdfont symbols for diagnostics on left
    float = {
        border = 'rounded',
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
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
