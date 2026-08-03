-- lua/plugins/debug/python.lua (nouveau fichier, séparé de lsp/python.lua qui reste pour basedpyright/ruff)
return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<leader>dT",
      function()
        require("dap-python").test_method()
      end,
      desc = "Debug nearest Python test",
      ft = "python",
    },
  },
}
