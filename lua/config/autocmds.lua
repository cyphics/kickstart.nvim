-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "html", "shtml", "htm" },
  callback = function()
    vim.lsp.start {
      name = "superhtml",
      cmd = { "superhtml", "lsp" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    }
  end,
})

-- lua/config/autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false -- vraies tabs (requis par gofmt, sinon il les reconvertit à chaque save)
    vim.opt_local.tabstop = 4 -- largeur d'affichage d'une tab = 4 colonnes
    vim.opt_local.shiftwidth = 4 -- indentation (<<, >>, autoindent) alignée sur la même largeur
    vim.opt_local.softtabstop = 4 -- la touche Tab se comporte comme 4 colonnes
  end,
})
