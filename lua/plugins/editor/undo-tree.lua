return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = { -- load the plugin only when using it's keybinding:
    -- <leader>uu, not bare <leader>u: LazyVim already reserves <leader>u as
    -- the "+ui" toggle group, so this nests inside it instead of shadowing it.
    { "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
  },
}
