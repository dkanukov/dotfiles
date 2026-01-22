# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using Lua and lazy.nvim as the plugin manager. The configuration is modular with separate concerns split between `lua/config/` (core settings) and `lua/plugins/` (one file per plugin).

## Architecture

**Entry Point:** `init.lua` loads four config modules in order:
1. `config.lazy` - Plugin manager bootstrap (sets leader to Space)
2. `config.remap` - Custom keymaps
3. `config.options` - Vim settings (4-space tabs, relative line numbers, system clipboard)
4. `config.terminal` - Terminal split keymaps

**Plugin Pattern:** Each plugin file in `lua/plugins/` returns a lazy.nvim spec table:
```lua
return {
  "author/plugin",
  dependencies = { ... },
  config = function() ... end,
  -- Lazy-load triggers: keys, ft, event, cmd
}
```

## Key Keymaps

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fs` | Live grep |
| `gd` | Go to definition |
| `gr` | Find references |
| `vh` | Hover documentation |
| `rn` | Rename symbol |
| `fm` | Format document |
| `ca` | Code actions |
| `<leader>a` | Add to Harpoon |
| `<C-e>` | Harpoon quick menu |
| `<leader>gb` | Git blame |
| `<leader>xx` | Toggle diagnostics (Trouble) |

## LSP Setup

Mason auto-installs servers defined in `lua/plugins/lsp-mason.lua`. Currently: cssls, eslint, stylelint_lsp, lua_ls, rust_analyzer, bashls, typos_lsp.

LSP keymaps are set on `LspAttach` event in the same file.

## Adding Plugins

Create a new file `lua/plugins/plugin-name.lua` returning a lazy.nvim spec. The file is auto-discovered by lazy.nvim's import mechanism.
