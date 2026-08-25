-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
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
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-a>", "^", { remap = true, desc = "Go to beginning of line" })
vim.keymap.set("n", "<C-e>", "$", { remap = true, desc = "Go to end of line" })

-- Resizing
vim.keymap.set("n", "<C-M-h>", "<cmd>vertical resize +5<cr>") -- make the window biger vertically
vim.keymap.set("n", "<C-M-l>", "<cmd>vertical resize -5<cr>") -- make the window smaller vertically
vim.keymap.set("n", "<C-M-k>", "<cmd>horizontal resize +2<cr>") -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "<C-M-j>", "<cmd>horizontal resize -2<cr>") -- make the window smaller horizontally by pressing shift and -
vim.keymap.set("n", "<C-Up>", "<cmd>vertical resize +5<cr>") -- make the window biger vertically
vim.keymap.set("n", "<C-Down>", "<cmd>vertical resize -5<cr>") -- make the window smaller vertically
vim.keymap.set("n", "<C-Right>", "<cmd>horizontal resize +2<cr>") -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "<C-Left>", "<cmd>horizontal resize -2<cr>") -- make the window smaller horizontally by pressing shift and -

vim.keymap.set("v", "<leader>p", "_dp", { desc = "Paste without overwriting register" })

local is_maximized = false
vim.keymap.set("n", "<leader>wm", function()
  if is_maximized then
    vim.cmd "wincmd =" -- retour à une taille équilibrée
  else
    vim.cmd "wincmd _" -- max hauteur
    vim.cmd "wincmd |" -- max largeur
  end
  is_maximized = not is_maximized
end, { desc = "Toggle maximize window" })

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("edit " .. vim.lsp.get_log_path())
end, {})

-- lua/config/keymaps.lua (à côté de la commande LspLog qu'on vient d'ajouter)
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("Aucun client LSP attaché à ce buffer", vim.log.levels.WARN)
    return
  end
  local lines = { "LSP clients attachés à ce buffer :", "" }
  for _, client in ipairs(clients) do
    table.insert(lines, string.format("• %s (id: %d)", client.name, client.id))
    table.insert(lines, string.format("  root_dir: %s", client.root_dir or "?"))
    table.insert(lines, string.format("  filetypes: %s", table.concat(client.config.filetypes or {}, ", ")))

    local cmd = client.config.cmd
    local cmd_str
    if type(cmd) == "table" then
      cmd_str = table.concat(cmd, " ")
    elseif type(cmd) == "function" then
      cmd_str = "<résolu dynamiquement>"
    else
      cmd_str = "?"
    end
    table.insert(lines, string.format("  cmd: %s", cmd_str))
    table.insert(lines, "")
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LspInfo" })
end, {})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

