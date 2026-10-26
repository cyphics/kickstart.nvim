-- lua/plugins/coding/run.lua
return {
  "akinsho/toggleterm.nvim",
  init = function()
    -- Doit être réglé AVANT que toggleterm.setup() tourne (via opts),
    -- d'où l'utilisation de `init` plutôt que juste `opts`.
    if vim.fn.has("win32") == 1 then
      vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
      vim.opt.shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
      vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
      vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
      vim.opt.shellquote = ""
      vim.opt.shellxquote = ""
    end
  end,
  opts = {
    direction = 'vertical',
    size = function(term)
      if term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
  },
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
