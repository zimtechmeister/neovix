vim.loader.enable()

--colors
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme 'gruvbox'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

--line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- this adds border to literally everythin (too much)
-- vim.opt.winborder = 'rounded'

-- in visual block mode move everywhere you want
vim.opt.virtualedit = 'block'

vim.opt.mouse = 'a'

-- in command mode press <tab> to get completion menu
-- vim.opt.wildmode = "noselect:full"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.hlsearch = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how Neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·', nbsp = '␣' }

-- tab behavior
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Stop automatic insertion of comments on newline 'fo-table' for reference
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
})

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.colorcolumn = "80"

vim.opt.wrap = false

vim.opt.scrolloff = 8

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3


-- Neovide
-- NOTE: some settings are configured in a neovide/config.toml file
if vim.g.neovide then
    vim.g.neovide_confirm_quit = true

    -- zoom in/out
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
end
