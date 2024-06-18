local present, nvim_comment = pcall(require, 'Comment')

if present then
  nvim_comment.setup({
    pre_hook =  require('ts_context_commentstring').setup {}
  })
end
