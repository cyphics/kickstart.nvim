-- lua/plugins/coding/completion.lua
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      -- Coupe l'aperçu "ghost text" devant le curseur
      ghost_text = { enabled = false },
      list = {
        selection = {
          preselect = false, -- rien de surligné par défaut dans la liste, juste les options
        },
      },
    },
    keymap = {
      -- <Tab> valide la suggestion en tête de liste (même sans surlignage visuel).
      -- "fallback" = si le menu n'est pas ouvert, <Tab> reprend son comportement normal (indentation)
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
