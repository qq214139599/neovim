local function setupLspSymbol()
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●', -- 可以是 '●', '▎', 或者其他符号
    },
    signs = {
      active = {
        { name = 'DiagnosticSignError', text = '✗' },
        { name = 'DiagnosticSignWarn', text = '!' },
        { name = 'DiagnosticSignHint', text = '?' },
        { name = 'DiagnosticSignInfo', text = 'i' },
      },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })
end

local function setupLspDiagnostic()
  local config = {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'single',
      source = 'always',
      header = '',
      prefix = '',
    },
  }
  vim.diagnostic.config(config)
end

-- NOTE: 浮窗边框不在这里全局设置。
-- hover 在键位里传 `{ border = 'single' }`（见 core/mappings.lua），
-- signatureHelp 的边框由 lsp_signature 的 `handler_opts.border` 负责，
-- 诊断相关的开关走下面的 vim.diagnostic.config()。

local function setupLspIcons()
  -- 配置 lsp 的图标
  require('vim.lsp.protocol').CompletionItemKind = {
    '',
    '',
    'ƒ',
    ' ',
    '',
    '',
    '',
    'ﰮ',
    '',
    '',
    '',
    '',
    '了',
    ' ',
    '﬌ ',
    ' ',
    ' ',
    '',
    ' ',
    ' ',
    ' ',
    ' ',
    '',
    '',
    '<>',
  }
end

require('base46').load_highlight('lsp')
setupLspDiagnostic()
setupLspIcons()
setupLspSymbol()
