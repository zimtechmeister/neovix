--  See `:help vim.keymap.set()`

-- set <space> as leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--clear highlight on pressing <Esc> in normal mode after searching
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Exit nvim saving the filecontent and a session file to the current working directory
-- Load the session with nvim -S Session.vim or :source Session.vim
vim.keymap.set('n', 'ZS', function()
    vim.cmd('wa')
    vim.cmd('mksession! Session.vim')
    vim.cmd('qa')
end, { desc = "Save session in CWD and exit" })
