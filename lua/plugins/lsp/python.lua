-- Python LSP customization.
--
-- The base setup (basedpyright + ruff, wired together correctly) comes
-- from LazyVim's official "lang.python" extra, enabled in lazyvim.json.
-- This file only overrides what's specific to this config: which LSP to
-- use (see lua/config/options.lua -> vim.g.lazyvim_python_lsp) and the
-- ruff lint rule selection below.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = false, -- let Ruff handle this
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      },
      ruff = {
        init_options = {
          settings = {
            logLevel = "error",
            lint = {
              select = {
                "E", -- pycodestyle
                "F", -- Pyflakes (conflicts a lot with basedpyright)
                "UP", -- pyupgrade
                "SIM", -- flake8-simplify
                "I", -- isort
              },
              ignore = {
                "F401", -- unused imports
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
}
