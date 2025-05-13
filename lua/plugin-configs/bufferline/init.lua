local present, configs = pcall(require, 'bufferline')

if present then
  require('base46').load_highlight('bufferline')
  configs.setup({
    options = {
      buffer_close_icon = '',
      modified_icon = '',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      diagnostics = false,
      offsets = { { filetype = 'NvimTree', text = '', padding = 0 } },
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = 'none',
      enforce_regular_tabs = true,
      always_show_bufferline = true,
    },
  })
end

vim.cmd [[
  " 选中 buffer/tab 的背景和前景
  hi BufferLineBufferSelected guibg=#0074d9 guifg=#ffffff gui=bold
  hi BufferLineTabSelected guibg=#0074d9 guifg=#ffffff gui=bold

  " 未选中 buffer/tab 的背景和前景
  hi BufferLineBufferVisible guibg=#1e1e2e guifg=#c0c0c0
  hi BufferLineTab guibg=#1e1e2e guifg=#c0c0c0

  " 分隔符颜色与相邻 tab 保持一致
  hi BufferLineSeparator guibg=#1e1e2e guifg=#1e1e2e
  hi BufferLineSeparatorVisible guibg=#1e1e2e guifg=#1e1e2e
  hi BufferLineSeparatorSelected guibg=#0074d9 guifg=#0074d9

  hi BufferLineTabSeparator guibg=#1e1e2e guifg=#1e1e2e
  hi BufferLineTabSeparatorVisible guibg=#1e1e2e guifg=#1e1e2e
  hi BufferLineTabSeparatorSelected guibg=#0074d9 guifg=#0074d9

  " 指示器和填充
  hi BufferLineIndicatorSelected guibg=#0074d9 guifg=#0074d9
  hi BufferLineIndicatorVisible guibg=#1e1e2e guifg=#1e1e2e
  hi BufferLineFill guibg=#1e1e2e guifg=#1e1e2e
]]