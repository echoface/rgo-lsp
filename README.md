# RGO CMP - Neovim Plugin

RGO CMP is a Neovim plugin that provides LSP server configuration and completion source for RGO language server with nvim-cmp.

## Installation

Using packer.nvim:
```lua
use {
  'echoface/rgo_lsp',
  requires = {
    'hrsh7th/nvim-cmp'
  }
}
```

Using lazy.nvim:
```lua
{
  'echoface/rgo_lsp',
  dependencies = {
    'hrsh7th/nvim-cmp'
  },
  config = function()
    require('rgo_lsp').setup({})
  end
}
```

## Configuration

Add to your Neovim config:
```lua
require('rgo_cmp').setup({})
```

## Features

- RGO LSP server configuration
- nvim-cmp completion source integration