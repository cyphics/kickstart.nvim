-- Generic LSP config: applies to every language server.
-- Language-specific server settings (e.g. Python) live in their own file
-- next to this one (see python.lua) so LazyVim can merge them together.
return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      underline = true,
      signs = true,
      update_in_insert = true,
    },
    autoformat = false,
    servers = {
      ["*"] = {
        keys = {
          {
            "gd",
            function()
              require("telescope.builtin").lsp_definitions { reuse_win = true }
            end,
            desc = "Goto Definition",
            has = "definition",
          },
          { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
          {
            "gI",
            function()
              require("telescope.builtin").lsp_implementations { reuse_win = true }
            end,
            desc = "Goto Implementation",
          },
          {
            "gy",
            function()
              require("telescope.builtin").lsp_type_definitions { reuse_win = true }
            end,
            desc = "Goto T[y]pe Definition",
          },
        },
      },
    },
  },
}
