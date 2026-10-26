-- lua/plugins/editor/bigfile.lua
return {
  "folke/snacks.nvim",
  opts = {
    bigfile = {
      -- size = 1024 * 1024 * 5, -- 5 Mo au lieu de ~1.5 Mo par défaut
      line_length = 1000000,
    },
    picker = {
      win = {
        input = { keys = { ["<c-l>"] = { "cycle_win", mode = { "i", "n" } } } },
        list  = { keys = { ["<c-l>"] = "cycle_win" } },
      },
    },
  },
}
