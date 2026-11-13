-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--  See `:help vim.keymap.set()`

local map = vim.keymap.set
local pick = LazyVim.pick

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- map('n', '<cr>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
map("n", "<S-h>", "^", { desc = "Move to beginning of line"})
map("n", "<S-l>", "$", { desc = "Move to end of line"})
map("n", "<leader>h", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
map("n", "<leader>l", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })

--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-a>", "^", { remap = true, desc = "Go to beginning of line" })
map("n", "<C-e>", "$", { remap = true, desc = "Go to end of line" })

-- Resizing
map("n", "<C-M-h>", "<cmd>vertical resize +5<cr>") -- make the window biger vertically
map("n", "<C-M-l>", "<cmd>vertical resize -5<cr>") -- make the window smaller vertically
map("n", "<C-M-k>", "<cmd>horizontal resize +2<cr>") -- make the window bigger horizontally by pressing shift and =
map("n", "<C-M-j>", "<cmd>horizontal resize -2<cr>") -- make the window smaller horizontally by pressing shift and -
map("n", "<C-Up>", "<cmd>vertical resize +5<cr>") -- make the window biger vertically
map("n", "<C-Down>", "<cmd>vertical resize -5<cr>") -- make the window smaller vertically
map("n", "<C-Right>", "<cmd>horizontal resize +2<cr>") -- make the window bigger horizontally by pressing shift and =
map("n", "<C-Left>", "<cmd>horizontal resize -2<cr>") -- make the window smaller horizontally by pressing shift and -

map("v", "<leader>p", "_dp", { desc = "Paste without overwriting register" })

local is_maximized = false
map("n", "<leader>wm", function()
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

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

map("n", "<leader>dr", function() require("dap").restart() end, { desc = "Restart session" })
map("n", "<leader>dR", function() require("dap").repl() end, { desc = "Toggle REPL" })

map("n", "<leader>fR", function() Snacks.picker.recent() end, {desc = "Recent (all)" })
map("n", "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = LazyVim.root() } }) end, {desc = "Recent (project)" })

map("n", "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
map("n", "<leader>/", pick("live_grep"), { desc = "Grep (Root Dir)" })
map("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader><space>", pick("files"), { desc = "Find Files (Root Dir)" })

-- find
map("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>", { desc = "Buffers" })
map("n", "<leader>fc", pick.config_files(), { desc = "Find Config File" })
map("n", "<leader>ff", pick("files"), { desc = "Find Files (Root Dir)" })
map("n", "<leader>fF", pick("files", { root = false }), { desc = "Find Files (cwd)" })
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })
map("n", "<leader>fs", "<cmd>Telescope oldfiles<cr>", { desc = "Recent (all)" })
-- racine évaluée à l'appui (pas au chargement)
map("n", "<leader>fR", function()
  pick("oldfiles", { cwd = LazyVim.root() })()
end, { desc = "Recent (project)" })

-- git
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Status" })

-- search
map("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
map("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>sg", pick("live_grep"), { desc = "Grep (Root Dir)" })
map("n", "<leader>sG", pick("live_grep", { root = false }), { desc = "Grep (cwd)" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
map("n", "<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
map("n", "<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
map("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map("n", "<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })

map("n", "<leader>sw", pick("grep_string", { word_match = "-w" }), { desc = "Word (Root Dir)" })
map("n", "<leader>sW", pick("grep_string", { root = false, word_match = "-w" }), { desc = "Word (cwd)" })
map("v", "<leader>sw", pick("grep_string"), { desc = "Selection (Root Dir)" })
map("v", "<leader>sW", pick("grep_string", { root = false }), { desc = "Selection (cwd)" })

map("n", "<leader>uC", pick("colorscheme", { enable_preview = true }), { desc = "Colorscheme with Preview" })

map("n", "<leader>ss", function()
  require("telescope.builtin").lsp_document_symbols({
    symbols = LazyVim.config.get_kind_filter(),
  })
end, { desc = "Goto Symbol" })

map("n", "<leader>sS", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols({})
end, { desc = "Goto Symbol (Workspace)" })

vim.keymap.set("n", "<leader>dd", function()
  require("dap").continue()
end, { desc = "Start/Continue debug" })
