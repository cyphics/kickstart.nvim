return {
  {
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
        ['*'] = {
          keys = {
            { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
            { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
            { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
            { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
          }
        },
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = false, -- let Ruff handle this
              analysis = {
                typeCheckingMode = "basic",
                -- diagnosticSeverityOverrides = {
                --   reportUnusedImport = "none",
                -- },
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              -- format = { enabled = true },
              logLevel = "error",
              lint = {
                select = {
                  -- pycodestyle
                  "E",
                  -- Pyflakes
                  "F", -- conflicts a lot with basedpyright
                  -- pyupgrade
                  "UP",
                  -- flake8-bugbear
                  --"B",
                  -- flake8-simplify
                  "SIM",
                  -- isort
                  "I",
                },
                ignore = {
                  "F401",
                  "F841", -- unused imports/var
                  "F821", -- undefined name
                  "SIM117", -- use single with statement
                },
              },
            },
          },
        },
      },
    },
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    "dgagn/diagflow.nvim",
    opts = {
      enable = true,
      max_width = 60, -- The maximum width of the diagnostic messages
      max_height = 10, -- the maximum height per diagnostics
      severity_colors = { -- The highlight groups to use for each diagnostic severity level
        error = "DiagnosticFloatingError",
        warning = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
      },
      format = function(diagnostic)
        return diagnostic.message
      end,
      gap_size = 1,
      scope = "cursor", -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
      padding_top = 0,
      padding_right = 0,
      text_align = "right", -- 'left', 'right'
      placement = "top", -- 'top', 'inline'
      inline_padding_left = 0, -- the padding left when the placement is inline
      update_event = { "DiagnosticChanged", "BufReadPost" }, -- the event that updates the diagnostics cache
      toggle_event = {}, -- if InsertEnter, can toggle the diagnostics on inserts
      show_sign = false, -- set to true if you want to render the diagnostic sign before the diagnostic message
      render_event = { "DiagnosticChanged", "CursorMoved" },
    },
  },
}
