-- lua/plugins/coding/run.lua
return {
  "akinsho/toggleterm.nvim",
  opts = {},
  keys = {
    {
      "<leader>rr",
      function()
        require("toggleterm").exec("python " .. vim.fn.shellescape(vim.fn.expand("%")))
      end,
      desc = "Run current file",
    },
  },
}
