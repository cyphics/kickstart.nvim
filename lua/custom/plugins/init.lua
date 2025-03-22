-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = { 'html', 'shtml', 'htm' },
    callback = function()
      vim.lsp.start {
        name = 'superhtml',
        cmd = { 'superhtml', 'lsp' },
        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
      }
    end,
  }),
}
