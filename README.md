# RGO CMP - Neovim Plugin

RGO CMP is a Neovim plugin that provides LSP server configuration and completion source for RGO language server with nvim-cmp.

## Installation

Using packer.nvim:
```lua
use {
  'your-username/rgo_cmp',
  requires = {
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp'
  }
}
```

Using lazy.nvim:
```lua
{
  'your-username/rgo_cmp',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp'
  },
  config = function()
    require('rgo_cmp').setup()
  end
}
```

## Configuration

Add to your Neovim config:
```lua
require('rgo_cmp').setup()
```

## Features

- RGO LSP server configuration
- nvim-cmp completion source integration