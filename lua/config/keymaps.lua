-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- vim.keymap.set('n', '<cr>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-a>', '^', { remap = true, desc = 'Go to beginning of line' })
vim.keymap.set('n', '<C-e>', '$', { remap = true, desc = 'Go to end of line' })

-- Resizing
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
vim.keymap.set('n', '<C-M-h>', '<cmd>vertical resize +5<cr>') -- make the window biger vertically
vim.keymap.set('n', '<C-M-l>', '<cmd>vertical resize -5<cr>') -- make the window smaller vertically
vim.keymap.set('n', '<C-M-k>', '<cmd>horizontal resize +2<cr>') -- make the window bigger horizontally by pressing shift and =
vim.keymap.set('n', '<C-M-j>', '<cmd>horizontal resize -2<cr>') -- make the window smaller horizontally by pressing shift and -
vim.keymap.set('n', '<C-Up>', '<cmd>vertical resize +5<cr>') -- make the window biger vertically
vim.keymap.set('n', '<C-Down>', '<cmd>vertical resize -5<cr>') -- make the window smaller vertically
vim.keymap.set('n', '<C-Right>', '<cmd>horizontal resize +2<cr>') -- make the window bigger horizontally by pressing shift and =
vim.keymap.set('n', '<C-Left>', '<cmd>horizontal resize -2<cr>') -- make the window smaller horizontally by pressing shift and -

vim.keymap.set('v', '<leader>p', '_dp')
