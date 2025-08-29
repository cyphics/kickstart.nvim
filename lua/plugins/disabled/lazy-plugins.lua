require('lazy').setup( {

    
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'folke/noice.nvim',
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',
    -- 'beautifier/js-beautify',
    -- 'sbdchd/neoformat',
  { 'norcalli/nvim-colorizer.lua', opts =  {
      'css';
      'javascript';
      html = {
        mode = 'foreground';
      }
    }
  },


  -- NOTE: Plugins can specify dependencies.
  --
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
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
