local M = {}

local function detect_root()
  local opts = { upward = true }
  local root_files = vim.fs.find({ 'go.mod', 'rgo_config.yaml' }, opts)
  return root_files[1] and vim.fs.dirname(root_files[1]) or nil
end

function M.setup(opts)
  -- Ensure dependencies are loaded
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    vim.notify('nvim-lspconfig not found', vim.log.levels.ERROR)
    return
  end

  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    vim.notify('nvim-cmp not found', vim.log.levels.ERROR)
    return
  end

  -- Register LSP server using new Neovim 0.10+ API
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- 只启用completion和notification能力
  capabilities.textDocument.completion = true
  capabilities.textDocument.hover = false
  capabilities.textDocument.definition = false
  capabilities.textDocument.references = false
  capabilities.textDocument.documentSymbol = false
  capabilities.textDocument.rename = false
  capabilities.textDocument.formatting = false
  capabilities.textDocument.codeAction = false

  vim.lsp.start({
    name = 'rgo',
    cmd = { 'rgo', 'lsp' },
    filetypes = { 'go' },
    root_dir = detect_root(),
    capabilities = capabilities,
    settings = {
      trace = {
        server = 'verbose'
      }
    }
  })

  -- Setup nvim-cmp source with new API
  cmp.register_source('rgo', {
    complete = function(self, params, callback)
      local client = vim.lsp.get_active_clients({ name = 'rgo' })[1]
      if not client then
        return callback({ isIncomplete = true })
      end

      client.request('textDocument/completion', params, callback, self.bufnr)
    end
  })
end

return M
