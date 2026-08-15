-- lua/plugins/editor/explorer.lua
return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer (toggle)" },
    { "\\", function() Snacks.explorer() end, desc = "Explorer (reveal)" },
  },
}
