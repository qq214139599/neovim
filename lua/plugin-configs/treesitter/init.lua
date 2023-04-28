local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.help = {
  install_info = {
    url = "/var/study/tree-sitter-help",    -- local path or git repo
    files = { "src/parser.c" },             -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main",                        -- default branch in case of git repo if different from master
    generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "help",                          -- if filetype does not match the parser name
}

local default_treesitter_config = skcode.load_config().plugins.options.treesitter

local present, treesitter = pcall(require, 'nvim-treesitter.configs')

local swap_next, swap_prev = (function()
  local swap_objects = {
    p = '@parameter.inner',
    f = '@function.outer',
    e = '@element',
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format('<leader>s%s', key)] = obj
    p[string.format('<leader>s%s', string.upper(key))] = obj
  end

  return n, p
end)()

if present then
  require('base46').load_highlight('treesitter')
  treesitter.setup({
    ensure_installed = default_treesitter_config.ensure_installed,
    sync_install = false,
    ignore_install = { '' },
    highlight = {
      enable = true,
      disable = { '' },
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    autopairs = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        scope_incremental = '<S-CR>',
        node_decremental = '<BS>',
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        c = '// %s',
        lua = '-- %s',
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']p'] = '@parameter.inner',
          [']]'] = '@function.outer',
          [']m'] = '@class.outer',
        },
        goto_next_end = {
          ['[]'] = '@function.outer',
          [']M'] = '@class.outer',
        },
        goto_previous_start = {
          ['[p'] = '@parameter.inner',
          ['[['] = '@function.outer',
          ['[m'] = '@class.outer',
        },
        goto_previous_end = {
          [']['] = '@function.outer',
          ['[M'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = swap_next,
        swap_previous = swap_prev,
      },
    },
  })
end
