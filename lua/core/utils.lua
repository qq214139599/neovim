local cmd = vim.cmd

-- 加载默认配置
skcode.load_config = function()
  return require('core.default_config')
end

-- 键位定义函数
-- @param mode 模式
-- @param key 键位
-- @param command 命令
-- @param opt 其他参数
skcode.map = function(mode, key, command, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = skcode.merge(options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, command, options)
end

skcode.buf_map = function(bufnr, mode, key, command, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = skcode.merge(options, opts)
  end
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, options)
end

skcode.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

-- 跳转到上一条(count=-1)/下一条(count=1)诊断，并在光标处弹出浮窗
skcode.jump_diagnostic = function(count)
  vim.diagnostic.jump({
    count = count,
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
        border = 'single',
      })
    end,
  })
end

skcode.close_buffer = function()
  local fn = vim.fn

  -- 获取当前所有的buffer列表
  local buflisted = fn.getbufinfo({ buflisted = 1 })
  local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
  if #buflisted < 2 then
    cmd('confirm qall')
    return
  end
  for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
    cmd(string.format('%d wincmd w', fn.win_id2win(winid)))
    cmd(cur_bufnr == buflisted[#buflisted].bufnr and 'bp' or 'bn')
  end
  cmd(string.format('%d wincmd w', cur_winnr))
  local is_terminal = fn.getbufvar(cur_bufnr, '&buftype') == 'terminal'
  cmd(is_terminal and 'bd! #' or 'silent! confirm bd #')
end
