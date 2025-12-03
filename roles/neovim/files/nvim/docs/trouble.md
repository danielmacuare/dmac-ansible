# Trouble

Trouble is a diagnostics list that provides a clean interface for viewing and navigating errors, warnings, and other diagnostics.

## Features

- Unified diagnostics view
- LSP references and definitions
- Quickfix and location list integration
- Symbol browser
- Telescope integration

## Keymaps

| Keymap | Description |
|--------|-------------|
| `<leader>xx` | Toggle diagnostics (all files) |
| `<leader>xX` | Toggle diagnostics (current buffer only) |
| `<leader>cs` | Toggle symbols |
| `<leader>cl` | Toggle LSP definitions/references |
| `<leader>xL` | Toggle location list |
| `<leader>xQ` | Toggle quickfix list |

## Usage

### Viewing Diagnostics
1. Press `<leader>xx` to open Trouble
2. Navigate with `j` / `k`
3. Press `<CR>` to jump to diagnostic
4. Press `q` to close

### Filtering Diagnostics
- `<leader>xx` - All diagnostics from workspace
- `<leader>xX` - Only diagnostics from current buffer

### LSP Integration
- `<leader>cl` - View LSP definitions, references, implementations
- `<leader>cs` - Browse document symbols

### Quickfix Integration
Trouble can display quickfix and location lists with better formatting:
- `<leader>xQ` - Quickfix list
- `<leader>xL` - Location list

## Navigation Inside Trouble

| Key | Action |
|-----|--------|
| `j` / `k` | Navigate items |
| `<CR>` | Jump to item |
| `<Tab>` | Jump to item (keep Trouble open) |
| `q` | Close Trouble |
| `o` | Jump to item and close Trouble |
| `P` | Toggle preview |
| `K` | Hover (show details) |
| `r` | Refresh |

## Diagnostic Severity

Trouble shows diagnostics with these severity levels:
- 🔴 Error
- 🟡 Warning
- 🔵 Info
- 💡 Hint

## Integration with Other Plugins

### Telescope
Trouble integrates with Telescope to show search results:
```vim
:Telescope diagnostics
```

### LSP
Trouble automatically displays LSP diagnostics when available.

## Commands

### Open Trouble
```vim
:Trouble diagnostics
```

### Close Trouble
```vim
:Trouble diagnostics toggle
```

### Specific Views
```vim
:Trouble symbols
:Trouble lsp
:Trouble quickfix
:Trouble loclist
```

## Tips & Tricks

### Quick Diagnostic Navigation
1. Open Trouble with `<leader>xx`
2. Use `j` / `k` to navigate
3. Press `<Tab>` to preview without closing Trouble
4. Press `<CR>` when you find the right diagnostic

### Filter by Severity
Trouble shows all severities by default. To filter, use the LSP diagnostic commands:
```vim
:lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
```

### Auto-open on Diagnostics
To automatically open Trouble when diagnostics are available, add to your config:
```lua
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    vim.cmd("Trouble diagnostics")
  end,
})
```

## Troubleshooting

### Trouble Not Opening
1. Check if plugin is loaded: `:Lazy`
2. Try the command directly: `:Trouble diagnostics`
3. Check for errors: `:messages`

### No Diagnostics Showing
1. Ensure LSP is attached: `:LspInfo`
2. Check if there are actual diagnostics in your code
3. Try refreshing: Press `r` inside Trouble

### Performance Issues
If Trouble is slow with many diagnostics:
1. Filter to current buffer: `<leader>xX`
2. Close and reopen Trouble
3. Reduce the number of diagnostics by fixing issues
