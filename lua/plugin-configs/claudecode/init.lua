require('claudecode').setup({
  -- 插件随 VeryLazy 加载，server 启动后就写 ~/.claude/ide/[port].lock
  auto_start = true,

  terminal = {
    -- 没装 snacks.nvim，用 nvim 自带 terminal
    provider = 'native',
    split_side = 'right',
    split_width_percentage = 0.35,
  },

  diff_opts = {
    -- Claude 提改动时开 nvim 原生 diff，:w 接受 / :q 拒绝
    layout = 'vertical',
  },
})

-- nvim-tree 里把光标所在文件加进 Claude 上下文
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'NvimTree',
  callback = function()
    skcode.buf_map(0, 'n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<CR>')
  end,
})
