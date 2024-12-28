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

local function setupLspHandlers()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
  })

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    border = 'single',
    virtual_text = false,
    underline = true,
    severity_sort = true,
    update_in_insert = false,
  })
end

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
setupLspHandlers()
setupLspIcons()
setupLspSymbol()
