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
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | Find references |
| `gs` | Signature help |
| `vh` | Hover documentation |
| `rn` | Rename symbol |
| `fm` | Format document (Guard) |
| `ca` | Code actions |
| `gl` | Show diagnostic float |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>a` | Add to Harpoon |
| `<C-e>` | Harpoon quick menu |
| `<leader>gb` | Git blame |
| `<leader>xx` | Toggle diagnostics (Trouble) |

### TypeScript-specific

| Keymap | Action |
|--------|--------|
| `<leader>oi` | Organize imports |
| `<leader>ru` | Remove unused |
| `<leader>ai` | Add missing imports |
| `<leader>fa` | Fix all |
| `<leader>rf` | Rename file |

## LSP Setup

Mason auto-installs servers defined in `lua/plugins/lsp-mason.lua`:
- **CSS:** cssls, css_variables, cssmodules_ls, stylelint_lsp
- **Lua:** lua_ls
- **Rust:** rust_analyzer
- **Shell:** bashls
- **TypeScript/JavaScript:** typescript-tools.nvim (ts_ls disabled)
- **JSON:** jsonls (with schemastore.nvim)
- **YAML:** yamlls (with schemastore.nvim)
- **HTML:** html
- **Spelling:** typos_lsp

LSP keymaps are set on `LspAttach` event in the same file.

## Formatting

Formatting is handled by `guard.nvim` (`lua/plugins/guard.lua`) with format-on-save enabled.

| Filetype | Formatter |
|----------|-----------|
| Lua | stylua |
| JS/TS/JSX/TSX | eslint_d |
| CSS/SCSS | prettier |
| Rust | rustfmt |
| Go | go.nvim (goimports) |
| Shell | shfmt |
| JSON/YAML/Markdown | prettier |

## Adding Plugins

Create a new file `lua/plugins/plugin-name.lua` returning a lazy.nvim spec. The file is auto-discovered by lazy.nvim's import mechanism.
