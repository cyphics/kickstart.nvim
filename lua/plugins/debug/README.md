# Debugging (DAP)

Debugging is powered by two LazyVim extras (see `lazyvim.json`):

- `lazyvim.plugins.extras.dap.core` — base nvim-dap + nvim-dap-ui + virtual text,
  with default keymaps under `<leader>d` (`<leader>db` toggle breakpoint,
  `<leader>dc` continue, `<leader>di` step into, etc. — see `<leader>d` in
  which-key for the full list).
- `lazyvim.plugins.extras.lang.python` — wires up `nvim-dap-python` (debugpy)
  automatically when `dap.core` is also enabled.

This is intentionally a separate folder from `lsp/`: DAP (Debug Adapter
Protocol) and LSP (Language Server Protocol) are two different protocols
that happen to both talk to external tools. If you add a custom debug
config or keymap later, it goes in this folder — e.g. `dap.lua`.
