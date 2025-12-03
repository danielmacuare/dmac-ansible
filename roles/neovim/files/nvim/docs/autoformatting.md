# Auto-formatting

Auto-formatting is handled by conform.nvim, which provides fast and reliable code formatting.

## Plugin

- **conform.nvim**: Modern formatter plugin

## Configured Formatters

| Language/Filetype | Formatter | Notes |
|-------------------|-----------|-------|
| Lua | stylua | Installed via Homebrew/Cargo |
| Python | ruff_format, ruff_organize_imports | Fast Python formatter |
| JavaScript/TypeScript | prettier | |
| JSX/TSX | prettier | |
| JSON | prettier | |
| YAML | prettier | |
| Markdown | prettier | |
| HTML | prettier | |
| CSS | prettier | |
| Shell/Bash | shfmt | 4-space indentation |
| Terraform | terraform_fmt | |

## Keymaps

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>mp` | n, v | Format file or selection |

## Format on Save

Files are automatically formatted when saved with these settings:
- **Timeout**: 1000ms
- **LSP Fallback**: Enabled (uses LSP formatting if no formatter configured)
- **Async**: Disabled (formatting completes before save)

### Disabling Format on Save
To save without formatting, use:
```vim
<leader>sn
```

## Formatter Configuration

### stylua (Lua)
Configuration in `stylua.toml`:
- Column width: 160
- Indent: 2 spaces
- Quote style: Single quotes preferred
- Call parentheses: Omitted when possible

### shfmt (Shell)
- Indentation: 4 spaces
- Binary operators at start of line

### ruff (Python)
- Format with ruff_format
- Organize imports with ruff_organize_imports
- Import sorting follows isort rules

### prettier
Default prettier configuration for:
- JavaScript/TypeScript
- JSON
- YAML
- Markdown
- HTML
- CSS

## Manual Formatting

### Format Current File
```vim
:lua require('conform').format()
```

Or use the keymap: `<leader>mp`

### Format Selection
1. Select text in visual mode
2. Press `<leader>mp`

### Format Specific Range
```vim
:lua require('conform').format({ range = { start = {1, 0}, end = {10, 0} } })
```

## Installation

### stylua
stylua must be installed separately (not via Mason):

```bash
# macOS
brew install stylua

# Using Cargo
cargo install stylua
```

### Other Formatters
All other formatters are auto-installed via Mason:
- prettier
- shfmt
- ruff

## Customization

### Adding a New Formatter

1. Install the formatter via Mason or system package manager
2. Add to `formatters_by_ft` in `lua/plugins/autoformatting.lua`:

```lua
formatters_by_ft = {
  your_filetype = { 'your_formatter' },
}
```

### Configuring Formatter Options

Add to the `formatters` table:

```lua
formatters = {
  your_formatter = {
    prepend_args = { '--option', 'value' },
  },
}
```

### Disabling Format on Save

Set `format_on_save` to `false`:

```lua
format_on_save = false,
```

### Changing Timeout

Increase timeout for slow formatters:

```lua
format_on_save = {
  timeout_ms = 3000, -- 3 seconds
}
```

## Formatter Priority

When multiple formatters are configured for a filetype, they run in order:

```lua
python = { 'ruff_format', 'ruff_organize_imports' },
```

1. ruff_format runs first
2. ruff_organize_imports runs second

## LSP Fallback

If no formatter is configured for a filetype, conform.nvim falls back to LSP formatting (if available).

To disable LSP fallback:

```lua
format_on_save = {
  lsp_fallback = false,
}
```

## Tips & Tricks

### Format on Save for Specific Filetypes Only

```lua
format_on_save = function(bufnr)
  -- Disable for certain filetypes
  local filetype = vim.bo[bufnr].filetype
  if filetype == 'markdown' then
    return nil
  end
  return { timeout_ms = 1000, lsp_fallback = true }
end,
```

### Check Formatter Status

```vim
:ConformInfo
```

Shows:
- Available formatters for current filetype
- Formatter status (available/not found)
- Configuration details

### Format Specific Formatter

```vim
:lua require('conform').format({ formatters = { 'prettier' } })
```

## Troubleshooting

### Formatter Not Running

1. Check if formatter is installed:
```vim
:Mason
```

2. Check conform status:
```vim
:ConformInfo
```

3. Verify formatter is in PATH:
```bash
which prettier
which stylua
```

### Formatting Errors

Check Neovim messages:
```vim
:messages
```

### Slow Formatting

1. Increase timeout
2. Disable format on save for large files
3. Use async formatting (may cause race conditions)

### stylua Not Found

Install stylua separately:
```bash
brew install stylua  # macOS
cargo install stylua  # Rust
```

Verify installation:
```bash
which stylua
stylua --version
```

### Conflicting Formatters

If you have multiple formatters (e.g., LSP + conform), disable one:
- Disable LSP formatting: Set `lsp_fallback = false`
- Or disable specific LSP formatters in `lua/plugins/lsp.lua`
