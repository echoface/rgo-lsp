# RGO CMP - Neovim Plugin

RGO CMP is a Neovim plugin that provides LSP server configuration and completion source for RGO language server with nvim-cmp.

## Installation

Using packer.nvim:
```lua
use {
  'echoface/rgo_cmp',
  requires = {
    'hrsh7th/nvim-cmp'
  }
}
```

Using lazy.nvim:
```lua
{
  'echoface/rgo_cmp',
  dependencies = {
    'hrsh7th/nvim-cmp'
  },
  config = function()
    require('rgo_cmp').setup({})
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