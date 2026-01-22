# Neovim Configuration

A modular Neovim configuration using Lua and lazy.nvim as the plugin manager.

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua         # Plugin manager bootstrap
│   │   ├── options.lua      # Vim settings
│   │   ├── remap.lua        # Custom keymaps
│   │   └── terminal.lua     # Terminal keymaps
│   └── plugins/             # One file per plugin (auto-discovered)
```

## Features

- **Plugin Manager**: lazy.nvim with auto-updates
- **Theme**: Gruvbox Material (dark, hard, transparent)
- **LSP**: Mason + nvim-lspconfig for multiple languages
- **TypeScript**: typescript-tools.nvim (faster than tsserver)
- **Completion**: nvim-cmp with LSP, snippets, buffer, path sources
- **Formatting**: guard.nvim (respects project configs)
- **Fuzzy Finding**: Telescope
- **File Navigation**: Harpoon 2
- **Syntax**: Treesitter
- **Git**: gitsigns, git-conflict
- **Statusline**: lualine
- **Mini utilities**: surround, pairs, ai text objects
- **Debugging**: nvim-dap with UI (Go, TypeScript/JS, Rust)
- **Database**: vim-dadbod with UI and completion
- **AI Integration**: claude-code.nvim (floating terminal for Claude Code CLI)

## Keymaps

Leader key: `Space`

### General

| Keymap | Action |
|--------|--------|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlight |
| `x` | Delete char (no register) |
| `<leader>tt` | Open netrw |
| `<leader>cp` | Copy relative file path |
| `<leader>cpf` | Copy full file path |

### Navigation

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep |
| `<leader>gs` | Git status |
| `<C-e>` | Harpoon quick menu |
| `<leader>a` | Add file to Harpoon |

### LSP

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | Find references |
| `gs` | Signature help |
| `vh` | Hover documentation |
| `rn` | Rename symbol |
| `ca` | Code action |
| `fm` | Format (Guard) |
| `df` | Open diagnostic float |
| `[d` / `]d` | Previous/next diagnostic |

### TypeScript (typescript-tools.nvim)

| Keymap | Action |
|--------|--------|
| `<leader>oi` | Organize imports |
| `<leader>ru` | Remove unused |
| `<leader>ai` | Add missing imports |
| `<leader>fa` | Fix all |
| `<leader>rf` | Rename file |

### Trouble (Diagnostics)

| Keymap | Action |
|--------|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Symbols |
| `<leader>cl` | LSP definitions/references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

### Git Conflict

| Keymap | Action |
|--------|--------|
| `co` | Choose ours |
| `ct` | Choose theirs |
| `cn` | Choose none |
| `cb` | Choose both |
| `]x` / `[x` | Next/prev conflict |

### Splits & Tabs

| Keymap | Action |
|--------|--------|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sx` | Close split |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab / terminal tab |
| `<leader>tp` | Previous tab |

### Terminal

| Keymap | Action |
|--------|--------|
| `ts` | Terminal in horizontal split |
| `tv` | Terminal in vertical split |
| `<Esc>` or `jk` | Exit terminal mode |

### Search & Replace

| Keymap | Action |
|--------|--------|
| `<leader>rif` | Smart search & replace (with scope, confirm options) |

### Comments (Comment.nvim)

| Keymap | Action |
|--------|--------|
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment selection |

### Mini.surround

| Keymap | Action |
|--------|--------|
| `sa` | Add surrounding |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |

### Debugging (nvim-dap)

| Keymap | Action |
|--------|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue/Start debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Terminate session |

### Database (vim-dadbod)

| Keymap | Action |
|--------|--------|
| `<leader>Du` | Toggle database UI |
| `<leader>Da` | Add database connection |

### Claude Code

| Keymap | Action |
|--------|--------|
| `<C-,>` | Toggle Claude Code terminal (floating window) |

## LSP Servers

Auto-installed via Mason:

- `cssls`, `css_variables`, `cssmodules_ls` - CSS
- `eslint` - JavaScript/TypeScript linting
- `stylelint_lsp` - CSS/SCSS linting
- `lua_ls` - Lua
- `rust_analyzer` - Rust
- `bashls` - Bash
- `typos_lsp` - Spell checking

TypeScript/JavaScript uses `typescript-tools.nvim` (not Mason).

## Formatting (guard.nvim)

Format on save is enabled. Respects project configs.

| Language | Formatter |
|----------|-----------|
| Lua | stylua |
| TypeScript/JavaScript | eslint_d --fix |
| CSS/SCSS | stylelint --fix |
| Rust | rustfmt |
| Go | gofmt + goimports |
| Shell | shfmt |
| JSON/YAML/Markdown | prettier |

## Requirements

### System

- Neovim >= 0.9
- Git
- Node.js (for LSP servers)
- ripgrep (for Telescope live_grep)
- Claude Code CLI (for claude-code.nvim integration)

### Formatters (install globally)

```bash
npm install -g eslint_d prettier stylelint
cargo install stylua
brew install shfmt
```

## Adding Plugins

Create a new file in `lua/plugins/plugin-name.lua`:

```lua
return {
  "author/plugin",
  dependencies = { ... },
  config = function()
    require("plugin").setup({})
  end,
}
```

The file is auto-discovered by lazy.nvim.
