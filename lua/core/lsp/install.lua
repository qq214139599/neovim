local present, lsp_config = pcall(require, 'lspconfig')

if not present then
  return
end

local lsp_default_config = skcode.load_config().lsp

local default_opts = require('core.lsp.opts')

local servers = lsp_default_config.servers

local install_lsp = function(lspconfig)
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
      elseif server == 'jstls' then
        opts = skcode.merge(default_opts, {
          cmd = { 'jdtls' },
          root_dir = lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git'),
          filetypes = { 'java' },
      })
      elseif server == 'clangd' then
        opts = skcode.merge(default_opts, {
            capabilities = { offsetEncoding = "utf-8" },
        })
      else
        opts = default_opts
      end

      lspconfig[server].setup(opts)
    end
  end
end

install_lsp(lsp_config)
