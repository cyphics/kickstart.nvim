return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   prefix = "●",
          --   -- this will set the prefix to a function that returns the diagnostics icon based on the severity
          --   -- prefix = "icons",
          -- },
          virtual_text = false,
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable this to enable the builtin LSP folding on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the folds.
        folds = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean}
        ---@type table<string, lazyvim.lsp.Config|boolean>
        servers = {

          -- pyright = {},
          basedpyright = {
            settings = {
              basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                  diagnosticSeverityOverrides = {
                    reportUnusedImport = "none",
                  },
                },
              },
            },
          },
          ruff = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = {
              settings = {
                logLevel = "error",
                args = {
                  "--ignore",
                  "F821",
                  "--ignore",
                  "E402",
                  "--ignore",
                  "E722",
                  "--ignore",
                  "E712",
                },
              },
            },
            keys = {
              {
                "<leader>co",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
            },
          },
          ruff_lsp = {
            keys = {
              {
                "<leader>co",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
            },
          },
          --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
          --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
          tsserver = {
            enabled = false,
          },
          ts_ls = {
            enabled = false,
          },
          tailwindcss = {
            filetypes_exclude = { "markdown" },
            filetypes_include = {},
          },
          stylua = { enabled = false },
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = vim.schedule_wrap(function(_, opts)
      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

      -- inlay hints
      if opts.inlay_hints.enabled then
        LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- folds
      if opts.folds.enabled then
        LazyVim.lsp.on_supports_method("textDocument/foldingRange", function(client, buffer)
          if LazyVim.set_default("foldmethod", "expr") then
            LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
          end
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end

      -- diagnostics
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = LazyVim.config.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      if opts.capabilities then
        vim.lsp.config("*", { capabilities = opts.capabilities })
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason = LazyVim.has("mason-lspconfig.nvim")
      local mason_all = have_mason
          and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
        or {} --[[ @as string[] ]]
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude automatic setup
      local function configure(server)
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts) -- configure the server
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end

      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      if have_mason then
        require("mason-lspconfig").setup({
          ensure_installed = vim.list_extend(install, LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}),
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end),
    -- config = function()

    --   -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --   local lspconfig = require("lspconfig")
    --   local on_attach_pyright = function(client, _)
    --     client.server_capabilities.hoverProvider = true
    --   end
    --   -- Configure pyright
    --   -- lspconfig.pyright.setup({
    --     -- on_attach = on_attach_pyright,
    --     -- capabilities = (function()
    --     --   local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     --   capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
    --     --   return capabilities
    --     -- end)(),
    --     -- settings = {
    --     --   python = {
    --     --     analysis = {
    --     --       useLibraryCodeForTypes = true,
    --     --       diagnosticSeverityOverrides = {
    --     --         reportUnusedVariable = "warning",
    --     --       },
    --     --       -- typeCheckingMode = "off", -- Set type-checking mode to off
    --     --       -- diagnosticMode = "off", -- Disable diagnostics entirely
    --     --     },
    --     --   },
    --     -- },
    --   -- })
    --
    --   -- local on_attach_ruff = function(client, _)
    --   --   if client.name == "ruff" then
    --   --     -- disable hover in favor of pyright
    --   --     client.server_capabilities.hoverProvider = false
    --   --   end
    --   -- end
    --   --
    --   -- --     ruff_lsp = {
    --   -- --       keys = {
    --   -- --         {
    --   -- --           "<leader>co",
    --   -- --           LazyVim.lsp.action["source.organizeImports"],
    --   -- --           desc = "Organize Imports",
    --   -- --         },
    --   -- --       },
    --   -- --     },
    --   -- lspconfig.ruff.setup({
    --   --   cmd_env = { RUFF_TRACE = "messages" },
    --   --   keys = {
    --   --     {
    --   --       "<leader>co",
    --   --       LazyVim.lsp.action["source.organizeImports"],
    --   --       desc = "Organize Imports",
    --   --     },
    --   --   },
    --   --   on_attach = on_attach_ruff,
    --   --   init_options = {
    --   --     settings = {
    --   --       logLevel = "error",
    --   --       args = {
    --   --         "--ignore",
    --   --         "F821",
    --   --         "--ignore",
    --   --         "E402",
    --   --         "--ignore",
    --   --         "E722",
    --   --         "--ignore",
    --   --         "E712",
    --   --       },
    --   --     },
    --   --   },
    --   -- })
    --   -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --   --   border = "rounded",
    --   --   width = 70,
    --   --   height = 15,
    --   -- })
    --   -- vim.lsp.handlers["textDocument/signatureHelp"] =
    --   --   vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    --   --
    --   -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    --   -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
    --   -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
    --   -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    -- end,

    -- opts = {
    --   -- make sure mason installs the server
    --   servers = {
    --   },
    -- },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
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
