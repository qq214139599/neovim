-- 只在 default_config 里把 volar 设为 true 时才会被 install.lua 加载。
-- 注意：nvim-lspconfig 上游已把 volar 重命名为 vue_ls，lsp/volar.lua 只是个会告警的 shim。

local function get_ts_server_path(root_dir)
  -- lspconfig.util.find_node_modules_ancestor 已废弃，上游给的替代写法就是下面这句
  local node_modules = vim.fs.find('node_modules', { path = root_dir, upward = true })[1]
  local project_root = node_modules and vim.fs.dirname(node_modules) or nil

  local local_tsserverlib = project_root
    and vim.fs.joinpath(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
  local global_tsserverlib = vim.fn.expand('~/.npm/lib/node_modules/typescript/lib/tsserverlibrary.js')

  if local_tsserverlib and vim.uv.fs_stat(local_tsserverlib) then
    return local_tsserverlib
  end
  return global_tsserverlib
end

return {
  -- on_new_config 在新版 LSP API 里已经没有这个回调了，时机等价的是 before_init
  before_init = function(_, config)
    config.init_options = config.init_options or {}
    config.init_options.typescript = config.init_options.typescript or {}
    config.init_options.typescript.serverPath = get_ts_server_path(config.root_dir)
  end,
}
