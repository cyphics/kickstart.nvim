-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  -- {
  --   'RRethy/vim-hexokinase',
  -- },
  -- { 'norcalli/nvim-colorizer.lua', opts = { 'json' } },
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    opts = {
      render = 'background',
      virtual_symbol = '■',
      enable_tailwind = true,
      virtual_symbol_position = 'inline',
    },
  },
  {
    'danymat/neogen',
    config = true,
  },
  {
    'ThePrimeagen/vim-be-good',
    'tpope/vim-fugitive',
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-4>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'nocksock/do.nvim',
    opts = {
      winbar = true,
      kaomoji_mode = 1,
      doing_prefix = 'Current task: ',
      store = {
        auto_create_file = true,
        file_name = '.do_tasks',
      },
    },
  },
  { -- This plugin
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    --keys = { { '<M-m>', '<cmd>CompilerOpen<cr>', desc = 'Open compiler' } },
    config = function()
      vim.api.nvim_set_keymap('n', '<M-m>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true })
    end,
  },
  { -- The task runner we use
    'stevearc/overseer.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
