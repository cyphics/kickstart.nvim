-- Floating diagnostic messages near the cursor.
-- This only DISPLAYS diagnostics that the LSP already produced —
-- it doesn't talk to any language server itself.
return {
  "dgagn/diagflow.nvim",
  event = "LspAttach",
  opts = {
    enable = true,
    max_width = 60, -- The maximum width of the diagnostic messages
    max_height = 10, -- the maximum height per diagnostics
    severity_colors = {
      error = "DiagnosticFloatingError",
      warning = "DiagnosticFloatingWarn",
      info = "DiagnosticFloatingInfo",
      hint = "DiagnosticFloatingHint",
    },
    format = function(diagnostic)
      return diagnostic.message
    end,
    gap_size = 1,
    scope = "cursor", -- 'cursor' | 'line' — show errors under the cursor vs. the whole line
    padding_top = 0,
    padding_right = 0,
    text_align = "right", -- 'left' | 'right'
    placement = "top", -- 'top' | 'inline'
    inline_padding_left = 0,
    update_event = { "DiagnosticChanged", "BufReadPost" },
    toggle_event = {},
    show_sign = false,
    render_event = { "DiagnosticChanged", "CursorMoved" },
  },
}
