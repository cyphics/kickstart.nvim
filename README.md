# Config Neovim personnelle

Basée sur [LazyVim](https://www.lazyvim.org/) (pas kickstart.nvim). LazyVim fournit
la base (LSP, complétion, Treesitter, DAP, formatage... déjà branchés ensemble) ;
ce dépôt ne contient que les ajouts et personnalisations par-dessus.

## Structure

```
init.lua                 -- bootstrap : charge config.lazy puis plugins.disabled
lua/
├── config/
│   ├── options.lua       -- vim.opt / vim.g, y compris les options LazyVim (leader, LSP Python...)
│   ├── keymaps.lua        -- keymaps custom (en plus de ceux de LazyVim)
│   ├── autocmds.lua       -- autocommandes custom
│   └── lazy.lua            -- bootstrap + config de lazy.nvim lui-même
└── plugins/                -- chaque fichier = un plugin (ou un petit groupe cohérent)
    ├── lsp/                 -- Language Server Protocol (go-to-def, hover, diagnostics)
    ├── debug/                -- Debug Adapter Protocol (breakpoints, step debugging)
    ├── lang/                  -- Treesitter (syntaxe) + outils spécifiques à un langage
    ├── coding/                 -- formatage (conform.nvim)
    ├── editor/                  -- navigation, fichiers, recherche
    ├── git/                       -- intégration git
    └── ui/                         -- éléments d'interface (todo-comments, etc.)
```

### Pourquoi séparer `lsp/`, `debug/` et `lang/` ?

Ce sont trois systèmes différents qu'on confond facilement :

| Dossier | Rôle | Parle à un outil externe ? |
|---|---|---|
| `lsp/` | Go-to-definition, hover, diagnostics | Oui — un *language server* (basedpyright, ruff...) |
| `debug/` | Breakpoints, step into/over, inspection de variables | Oui — un *debug adapter* (debugpy...) |
| `lang/` | Coloration syntaxique, indentation | Non — Treesitter analyse le fichier lui-même |
| `coding/` | Réécrit ton code au bon format | Oui — un *formatter* (stylua, prettier...) |

LSP et DAP sont deux protocoles différents et indépendants (l'un ne fait pas
l'autre), d'où les dossiers séparés.

## Extras LazyVim activés

Voir `lazyvim.json`. Actuellement :

- `lang.python` — basedpyright + ruff, correctement câblés ensemble.
  Personnalisé dans `lua/plugins/lsp/python.lua` (règles de lint ruff)
  et `lua/config/options.lua` (`vim.g.lazyvim_python_lsp = "basedpyright"`).
- `dap.core` — debugging générique (nvim-dap + UI). Combiné à `lang.python`,
  ça active automatiquement le debugger Python (debugpy) — voir
  `lua/plugins/debug/README.md`.

Pour activer/désactiver d'autres extras officiels : `:LazyExtras` dans Neovim.

## Style de code

Formaté avec [stylua](https://github.com/JohnnyMorganz/StyLua) — config dans
`.stylua.toml`. Lance `stylua lua/` avant de commit si tu modifies quelque chose.

## Autres fichiers

- `.ideavimrc` — config pour l'émulation Vim dans IntelliJ/PyCharm, source ce
  `init.lua` pour réutiliser le leader et quelques mappings.
- `lazy-lock.json` — versions exactes des plugins (à committer, pour des
  installs reproductibles).
