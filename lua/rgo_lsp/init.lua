local M = {}

local function detect_root()
  local opts = { upward = true }
  local root_files = vim.fs.find({ 'rgo_config.yaml' }, opts)
  return root_files[1] and vim.fs.dirname(root_files[1]) or nil
end

local function register_source_if_needed()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    vim.notify('nvim-cmp not found', vim.log.levels.WARN)
    return
  end

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

M.setup = function (opts)
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

  vim.lsp.config("rgo", {
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
  vim.notify('nvim-rgo config and enable rgo', vim.log.levels.Info)
  vim.lsp.enable("rgo")

  register_source_if_needed()
end

return M