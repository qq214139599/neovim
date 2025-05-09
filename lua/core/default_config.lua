local M = {}

-- UI配置
M.ui = {
  theme = 'gruvbox', -- default theme
}

-- Lsp 配置
M.lsp = {
  servers = {
    --    tsserver = true, -- typescript --deprecated
    ts_ls = true, -- typescript
    cssls = true, -- css
    cssmodules_ls = true, -- css module
    jsonls = true, -- json
    html = true, -- html
    eslint = true, -- eslint
    phpactor = true, --php
    gopls = true, -- go
    pylsp = true, --python
    lua_ls = true, -- lua
    -- ccls = true,           -- c/c++
    clangd = true, -- c/c++ 在根目录执行compiledb -nf make
    tailwindcss = false, -- tailwindcss
    emmet_ls = false, -- emmet
    marksman = false, -- markdown
    volar = false, -- vue3
    rust_analyzer = false, -- rust
    vuels = false, -- vue2
    jdtls = true,
  },
}

-- 插件配置
M.plugins = {
  options = {
    treesitter = {
      ensure_installed = {
        'bash',
        'c',
        'c_sharp',
        'comment',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'dot',
        'fish',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'go',
        'graphql',
        'html',
        'markdown',
        'pug',
        'prisma',
        'lua',
        'vim',
        'help',
        'java',
        'javascript',
        'typescript',
        'scss',
        'tsx',
        'vue',
        'jsdoc',
        'json',
        'json5',
        'regex',
        'ruby',
        'rust',
        'sql',
        'yaml',
      },
    },
    statusline = {
      style = 'arrow', -- default, round , slant , block , arrow
    },
  },
}

return M
