local present, gitsigns = pcall(require, 'gitsigns')

if present then
  require('base46').load_highlight('git')
  gitsigns.setup({
    signs = {
      add = { hl = 'DiffAdd', text = '│', numhl = 'GitSignsAddNr' },
      change = { hl = 'DiffChange', text = '│', numhl = 'GitSignsChangeNr' },
      delete = { hl = 'DiffDelete', text = '_', numhl = 'GitSignsDeleteNr' },
      topdelete = { hl = 'DiffDelete', text = '‾', numhl = 'GitSignsDeleteNr' },
      changedelete = {
        hl = 'DiffChangeDelete',
        text = '│',
        numhl = 'GitSignsChangeNr',
      },
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 300,
      ignore_whitespace = false,
    },
    sign_priority = 6,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function()
      require('core.mappings').gitsigns()
    end,
  })
end
