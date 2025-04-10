require('lazy').setup( {

    
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'folke/noice.nvim',
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',
    -- 'beautifier/js-beautify',
    -- 'sbdchd/neoformat',

  require 'kickstart.plugins.autocomplete',
  require 'kickstart.plugins.autopairs', -- auto-close {}
  require 'kickstart.plugins.conform',
  require 'kickstart.plugins.debug', -- debug stuff, mainly dap
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  -- require 'kickstart.plugins.harpoon',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.neo-tree', -- file explorer
  require 'kickstart.plugins.qmk', -- keyboard firmware code formatter
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.treesitter-textobjects',
  require('kickstart/plugins/trouble'),
  require('kickstart/plugins/todo-comments'),
  require('kickstart/plugins/undo-tree'),
  require('kickstart/plugins/which-key'), -- show pending keybindings

  -- NOTE: Plugins can specify dependencies.
  --
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    -- 'catppuccin/nvim',
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.o.background = 'dark'
      -- vim.cmd.colorscheme 'catppuccin-macchiato'
      vim.cmd.colorscheme 'gruvbox'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
