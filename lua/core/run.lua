vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<F5>',
      ':w<CR>:split<CR>:te /opt/homebrew/bin/php %<CR>i',
      { silent = true, noremap = true }
    )
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<F5>',
      ':w<CR>:split<CR>:te time go run %<CR>i',
      { silent = true, noremap = true }
    )
  end,
})
