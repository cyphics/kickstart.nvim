return {
  "tpope/vim-fugitive",
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "css",
      "javascript",
      html = {
        mode = "foreground",
      },
    },
  },
  {
    "benomahony/uv.nvim",
    -- Optional filetype to lazy load when you open a python file
    -- ft = { python }
    -- Optional dependency, but recommended:
    -- dependencies = {
    --   "folke/snacks.nvim"
    -- or
    --   "nvim-telescope/telescope.nvim"
    -- },
    opts = {
      picker_integration = true,
      keymaps = {
        prefix = "<leader>m", -- Main prefix for uv commands
        commands = true, -- Show uv commands menu (<leader>x)
        run_file = true, -- Run current file (<leader>xr)
        run_selection = true, -- Run selected code (<leader>xs)
        run_function = true, -- Run function (<leader>xf)
        venv = true, -- Environment management (<leader>xe)
        init = true, -- Initialize uv project (<leader>xi)
        add = true, -- Add a package (<leader>xa)
        remove = true, -- Remove a package (<leader>xd)
        sync = true, -- Sync packages (<leader>xc)
        sync_all = true, -- Sync all packages, extras and groups (<leader>xC)
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
      require("outline").setup({
        -- Your setup opts here (leave empty to use defaults)
      })
    end,
  },
}
