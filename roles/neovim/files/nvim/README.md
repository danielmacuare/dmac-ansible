# Neovim Configuration

A modern Neovim configuration focused on development across multiple languages with emphasis on DevOps tooling (Terraform, Kubernetes, Ansible, Pulumi).

## Features

- 🚀 LSP integration with automatic server installation via Mason
- 🔍 Fuzzy finding with Telescope
- 📁 File tree navigation with Neo-tree
- 🎨 Catppuccin color scheme
- ✨ Auto-completion with nvim-cmp
- 🔧 Auto-formatting with conform.nvim
- 📝 Syntax highlighting with Treesitter
- 🔀 Git integration with gitsigns and fugitive
- 🎯 Tmux integration for seamless navigation

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (recommended: MesloLGSDZ Nerd Font Mono)
- ripgrep (for Telescope live grep)
- Node.js (for some LSP servers)
- Python 3 (for Python LSP)
- Rust (optional, for rust-analyzer)

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone this repository:
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. Install stylua (Lua formatter):
```bash
brew install stylua  # macOS
# OR
cargo install stylua  # Using Rust
```

4. Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## General Keymaps

Leader key: `<Space>`

### Navigation
| Keymap | Mode | Description |
|--------|------|-------------|
| `<Space>` | n, v | Leader key (disabled default behavior) |
| `jk` / `kj` | i | Exit insert mode |
| `<C-h>` | n | Navigate to left window |
| `<C-j>` | n | Navigate to down window |
| `<C-k>` | n | Navigate to up window |
| `<C-l>` | n | Navigate to right window |
| `<C-d>` | n | Scroll down and center |
| `<C-u>` | n | Scroll up and center |
| `n` / `N` | n | Find next/previous and center |

### File Operations
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-s>` | n | Save file |
| `<leader>sn` | n | Save without auto-formatting |
| `<C-q>` | n | Quit file |

### Buffer Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<leader>x` | n | Close buffer |
| `<leader>,` | n | New buffer |

### Window Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>v` | n | Split window vertically |
| `<leader>h` | n | Split window horizontally |
| `<leader>se` | n | Make split windows equal size |
| `<leader>xs` | n | Close current split |

### Tab Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>to` | n | Open new tab |
| `<leader>tx` | n | Close current tab |
| `<leader>tn` | n | Go to next tab |
| `<leader>tp` | n | Go to previous tab |

### Editing
| Keymap | Mode | Description |
|--------|------|-------------|
| `x` | n | Delete character without copying |
| `<` / `>` | v | Indent left/right (stay in visual mode) |
| `<A-j>` / `<A-k>` | v | Move text up/down |
| `p` | v | Paste without overwriting register |
| `<leader>j` | n | Replace word under cursor |
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>+` / `<leader>-` | n | Increment/decrement number |

### Diagnostics
| Keymap | Mode | Description |
|--------|------|-------------|
| `[d` | n | Go to previous diagnostic |
| `]d` | n | Go to next diagnostic |
| `<leader>d` | n | Open floating diagnostic |
| `<leader>q` | n | Open diagnostics list |
| `<leader>do` | n | Toggle diagnostics on/off |

### Miscellaneous
| Keymap | Mode | Description |
|--------|------|-------------|
| `<Esc>` | n | Clear search highlights |
| `<leader>lw` | n | Toggle line wrapping |
| `<leader>ss` | n | Save session |
| `<leader>sl` | n | Load session |

## Plugins

### Core Functionality
- [lazy.nvim](docs/lazy.md) - Plugin manager
- [LSP](docs/lsp.md) - Language Server Protocol configuration
- [Mason](docs/lsp.md#mason) - LSP/tool installer
- [Treesitter](docs/treesitter.md) - Syntax highlighting and parsing

### UI & Appearance
- [Catppuccin](docs/catppuccin.md) - Color scheme
- [Lualine](docs/lualine.md) - Status line
- [Bufferline](docs/bufferline.md) - Buffer/tab line
- [Alpha](docs/alpha.md) - Start screen
- [Noice](docs/noice.md) - UI enhancements for messages
- [Indent Blankline](docs/indent-blankline.md) - Indentation guides
- [Colorizer](docs/misc.md#colorizer) - Color highlighter

### Navigation & Search
- [Telescope](docs/telescope.md) - Fuzzy finder
- [Neo-tree](docs/neo-tree.md) - File explorer
- [Which-key](docs/misc.md#which-key) - Keybinding hints

### Editing & Completion
- [nvim-cmp](docs/autocompletion.md) - Auto-completion
- [LuaSnip](docs/autocompletion.md#luasnip) - Snippet engine
- [Conform](docs/autoformatting.md) - Auto-formatting
- [nvim-autopairs](docs/misc.md#autopairs) - Auto-close brackets
- [nvim-ts-autotag](docs/misc.md#autotag) - Auto-close HTML tags

### Git Integration
- [Gitsigns](docs/gitsigns.md) - Git decorations
- [Fugitive](docs/misc.md#fugitive) - Git commands
- [vim-rhubarb](docs/misc.md#rhubarb) - GitHub integration

### Utilities
- [Trouble](docs/trouble.md) - Diagnostics list
- [TODO Comments](docs/todo-comments.md) - Highlight TODOs
- [Zen Mode](docs/zen-mode.md) - Distraction-free mode
- [vim-tmux-navigator](docs/vim-tmux-navigator.md) - Tmux integration
- [Render Markdown](docs/render-markdown.md) - Markdown preview
- [vim-sleuth](docs/misc.md#sleuth) - Auto-detect indentation

## Supported Languages

### LSP Servers Configured
- **Python**: pylsp, ruff
- **Rust**: rust-analyzer
- **Lua**: lua_ls
- **JavaScript/TypeScript**: (via Mason)
- **HTML/CSS**: html, cssls, tailwindcss
- **DevOps**: terraformls, yamlls, dockerls, docker_compose_language_service
- **Shell**: bashls
- **Database**: sqlls
- **GraphQL**: graphql
- **LaTeX**: ltex, texlab

### Formatters
- **Lua**: stylua
- **Python**: ruff
- **JavaScript/TypeScript/JSON/YAML/Markdown**: prettier
- **Shell**: shfmt
- **Terraform**: terraform_fmt

## Configuration Structure

```
.
├── init.lua                 # Entry point
├── lua/
│   ├── core/               # Core configuration
│   │   ├── keymaps.lua    # Key mappings
│   │   └── options.lua    # Neovim options
│   └── plugins/           # Plugin configurations
├── stylua.toml            # Lua formatter config
└── .kiro/
    └── steering/          # AI assistant steering rules
```

## Customization

### Changing Color Scheme
Edit `lua/plugins/catpuccin.lua` and change the `flavour` option:
```lua
flavour = 'mocha', -- Options: latte, frappe, macchiato, mocha
```

### Adding New LSP Servers
Edit `lua/plugins/lsp.lua` and add to the `servers` table:
```lua
local servers = {
  your_server = {},
  -- ... other servers
}
```

### Adding New Formatters
Edit `lua/plugins/autoformatting.lua` and add to `formatters_by_ft`:
```lua
formatters_by_ft = {
  your_filetype = { 'your_formatter' },
  -- ... other formatters
}
```

## Troubleshooting

### LSP Not Working
1. Check if the LSP server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check logs: `~/.local/state/nvim/lsp.log`

### Formatting Not Working
1. Ensure formatter is installed: `:Mason`
2. Check conform status: `:ConformInfo`
3. Manually format: `<leader>mp`

### Icons Not Showing
Install a Nerd Font and configure your terminal to use it.

## Contributing

Feel free to submit issues or pull requests for improvements.

## License

MIT
