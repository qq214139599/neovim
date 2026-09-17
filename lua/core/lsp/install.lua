local lsp_default_config = skcode.load_config().lsp

local default_opts = require('core.lsp.opts')

local servers = lsp_default_config.servers

-- nvim 0.11+ 的 vim.lsp.config 会把 nvim-lspconfig 的 lsp/<server>.lua 一起合并进来
-- （优先级：vim.lsp.config('*') < lsp/<server>.lua < 这里的调用），
-- 所以不再需要 require('lspconfig')[server].setup()，那个框架已被上游废弃。
local install_lsp = function()
  local opts

  for server, enable in pairs(servers) do
    if enable then
      if server == 'tsserver' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.tsserver'))
      elseif server == 'ts_ls' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.ts_ls'))
      elseif server == 'tailwindcss' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.tailwindcss'))
      elseif server == 'volar' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.volar'))
      elseif server == 'lua_ls' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.lua_ls'))
      elseif server == 'jsonls' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.jsonls'))
      elseif server == 'clangd' then
        opts = skcode.merge(default_opts, {
          capabilities = { offsetEncoding = 'utf-8' },
        })
      else
        -- 其余 server（cssls/html/eslint/gopls/pylsp/jdtls/phpactor...）
        -- 的 cmd / filetypes / root_markers 由 nvim-lspconfig 的 lsp/<server>.lua 提供
        opts = default_opts
      end

      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end
  end
end

install_lsp()
