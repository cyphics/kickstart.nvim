-- lua/plugins/debug/go.lua
return {
  "leoluz/nvim-dap-go",
  keys = {
    {
      "<leader>dT",
      function()
        require("dap-go").debug_test()
      end,
      desc = "Debug nearest Go test",
      ft = "go",
    },
  },
}
