# LSP Configuration

Language Server Protocol (LSP) integration provides IDE-like features such as auto-completion, go-to-definition, diagnostics, and more.

## Plugins

- **nvim-lspconfig**: LSP client configurations
- **mason.nvim**: Automatic LSP/tool installer
- **mason-lspconfig.nvim**: Bridge between Mason and lspconfig
- **mason-tool-installer.nvim**: Auto-install tools
- **fidget.nvim**: LSP progress notifications

## Configured Language Servers

| Language | Server | Notes |
|----------|--------|-------|
| Python | pylsp, ruff | Ruff for linting/formatting |
| Rust | rust-analyzer | With clippy integration |
| Lua | lua_ls | Configured for Neovim |
| HTML | html | |
| CSS | cssls | |
| Tailwind | tailwindcss | |
| JSON | jsonls | |
| SQL | sqlls | |
| Terraform | terraformls | |
| YAML | yamlls | |
| Bash | bashls | |
| GraphQL | graphql | |
| Docker | dockerls, docker_compose_language_service | |
| LaTeX | ltex, texlab | |

## Keymaps

All LSP keymaps are available when an LSP server is attached to a buffer.

### Navigation
| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Go to type definition |

### Symbols & Search
| Keymap | Description |
|--------|-------------|
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |

### Code Actions
| Keymap | Description |
|--------|-------------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `K` | Hover documentation |

### Workspace
| Keymap | Description |
|--------|-------------|
| `<leader>wa` | Add workspace folder |
| `<leader>wr` | Remove workspace folder |
| `<leader>wl` | List workspace folders |

## Mason

Mason is a package manager for LSP servers, formatters, and linters.

### Commands
- `:Mason` - Open Mason UI
- `:MasonInstall <package>` - Install a package
- `:MasonUninstall <package>` - Uninstall a package
- `:MasonUpdate` - Update all packages

### Auto-installed Tools
The following tools are automatically installed:
- prettier (JS/TS/JSON/YAML/Markdown formatter)
- shfmt (Shell formatter)
- ruff (Python formatter and linter)

**Note**: stylua is installed via Homebrew/Cargo, not Mason, due to a compatibility issue.

## Python Configuration

### pylsp
Configured with most plugins disabled to avoid conflicts with ruff:
```lua
pylsp = {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = false },
        pylsp_mypy = { enabled = false },
        pylsp_black = { enabled = false },
        pylsp_isort = { enabled = false },
      },
    },
  },
}
```

### Ruff
Provides fast linting and formatting with custom commands:
- `:RuffAutofix` - Fix all auto-fixable problems
- `:RuffOrganizeImports` - Organize imports

## Rust Configuration

rust-analyzer is configured with:
- All cargo features enabled
- Clippy for additional linting
- Check on save enabled

## Lua Configuration

lua_ls is configured specifically for Neovim development:
- LuaJIT runtime
- Neovim runtime files included
- Third-party library support
- Telemetry disabled

## Customization

### Adding a New LSP Server

1. Add to the `servers` table in `lua/plugins/lsp.lua`:
```lua
local servers = {
  your_server = {
    -- Optional: custom settings
    settings = {
      -- server-specific settings
    },
  },
}
```

2. Restart Neovim - Mason will auto-install it.

### Disabling a Server

Remove it from the `servers` table or set it to `nil`.

## Troubleshooting

### Check LSP Status
```vim
:LspInfo
```

### View LSP Logs
```bash
tail -f ~/.local/state/nvim/lsp.log
```

### Restart LSP
```vim
:LspRestart
```

### Common Issues

**LSP not starting**: Check if the server is installed with `:Mason`

**Slow performance**: Some servers (like lua_ls) can be slow on large projects. Check the server's documentation for performance tuning options.

**Conflicting formatters**: If you have multiple formatters for the same filetype, they might conflict. Use conform.nvim to manage formatting instead.
