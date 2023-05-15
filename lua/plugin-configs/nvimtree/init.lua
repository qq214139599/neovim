local present, nvimtree = pcall(require, 'nvim-tree')

if present then
  require('base46').load_highlight('nvimtree')

  local api = require('nvim-tree.api')
  api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd('edit ' .. file.fname)
  end)

  local lib = require('nvim-tree.lib')

  local git_add = function()
    local node = lib.get_node_at_cursor()
    local gs = node.git_status

    -- If the file is untracked, unstaged or partially staged, we stage it
    if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
      vim.cmd('silent !git add ' .. node.absolute_path)

      -- If the file is staged, we unstage
    elseif gs == 'M ' or gs == 'A ' then
      vim.cmd('silent !git restore --staged ' .. node.absolute_path)
    end

    lib.refresh_tree()
  end

  local function on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  end


  nvimtree.setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = true,
    hijack_cursor = false,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    view = {
      width = 30,
      hide_root_folder = false,
      side = 'left',
      adaptive_size = true,
      number = false,
      relativenumber = false,
      -- mappings = {
      --   custom_only = false,
      --   list = {
      --     { key = { 'l', '<CR>', 'o' }, action = 'tabnew' },
      --     { key = { 'e' }, action = 'edit' },
      --     { key = 'h', action = 'close_node' },
      --     { key = 'v', action = 'vsplit' },
      --     { key = 'ga', action = 'git_add', action_cb = git_add },
      --   },
      -- },
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = false,
      },
    },
    filters = {
      dotfiles = false,
      custom = { '^.git$' },
      exclude = { 'node_modules' },
    },
    renderer = {
      highlight_git = true,
      indent_markers = {
        enable = true,
      },
      icons = {
        webdev_colors = true,
        git_placement = 'before',
        padding = ' ',
        symlink_arrow = ' ➛ ',
        show = {
          file = true,
          folder = true,
          git = true,
          folder_arrow = false,
        },
        glyphs = {
          default = '',
          symlink = '',
          git = {
            unstaged = '',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            deleted = '',
            untracked = 'u',
            ignored = '◌',
          },
          folder = {
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            symlink_open = '',
          },
        },
      },
    },
  })
end
