return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 
        "autopep8", 
        "prettier",
        "prettierd",
        "twigcs",
        "phpcs",
        "php-cs-fixer",
      })
    end,
  },
}
