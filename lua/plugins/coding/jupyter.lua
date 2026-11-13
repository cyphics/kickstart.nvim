-- Provider Python de Neovim (celui qui contient pynvim, jupyter_client...)
vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/neovim/bin/python"

-- Exécute la cellule "# %%" sous le curseur
local function run_cell()
  local cur = vim.fn.line "."
  local last = vim.fn.line "$"
  local s, e = 1, last
  for l = cur, 1, -1 do
    if vim.fn.getline(l):match "^# %%%%" then
      s = l + 1
      break
    end
  end
  for l = cur + 1, last do
    if vim.fn.getline(l):match "^# %%%%" then
      e = l - 1
      break
    end
  end
  if s <= e then
    vim.fn.MoltenEvaluateRange(s, e)
  end
end

-- Saute à la cellule suivante / précédente
local function goto_cell(dir)
  local flags = dir == "next" and "W" or "bW"
  vim.fn.search("^# %%", flags)
end

return {
  -- Ouvre les .ipynb comme des scripts .py avec cellules "# %%"
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "percent",
      output_extension = "py",
      force_ft = "python",
    },
  },

  -- Affichage des images dans le terminal
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- "kitty" convient aussi à wezterm/ghostty; sinon "ueberzug"
      integrations = {},
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },

  -- Exécution via kernel Jupyter
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_use_border_highlights = true
    end,
    keys = {
      { "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Molten: init kernel" },
      { "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Molten: évaluer (opérateur)" },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Molten: évaluer la ligne" },
      { "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Molten: évaluer la sélection" },
      { "<leader>mc", run_cell, desc = "Molten: exécuter la cellule" },
      { "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Molten: ré-évaluer la cellule" },
      { "<leader>mo", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Molten: entrer dans la sortie" },
      { "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Molten: cacher la sortie" },
      { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Molten: supprimer la cellule" },
      {
        "]c",
        function()
          goto_cell "next"
        end,
        desc = "Cellule suivante",
      },
      {
        "[c",
        function()
          goto_cell "prev"
        end,
        desc = "Cellule précédente",
      },
      {
        "<leader>ma",
        function()
          vim.cmd "normal! ggVG"
          vim.cmd "MoltenEvaluateVisual"
          vim.cmd "normal! \27"
        end,
        desc = "Molten: exécuter tout le fichier",
      },
    },
  },
}
