# Bufferline

Bufferline provides a tab-like interface for managing buffers.

## Features

- Visual buffer tabs
- File type icons
- Modified indicators
- Close buttons
- Buffer sorting

## Buffer Indicators

- `●` - Modified buffer
- `✗` - Close button
- Icons - File type icons (requires Nerd Font)

## Keymaps

### Buffer Navigation
| Keymap | Description |
|--------|-------------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer |
| `<leader>,` | New buffer |

### Mouse Actions
- **Left click**: Switch to buffer
- **Right click**: Close buffer
- **Middle click**: (disabled)

## Configuration

### Tab Size
Each tab is 21 characters wide.

### Separator Style
Uses vertical bars (`│`) as separators.

### Close Icon
Uses `✗` for the close button.

## Buffer Sorting

Buffers are sorted by insertion order (most recent at the end).

### Alternative Sorting Options
Edit `lua/plugins/bufferline.lua`:

```lua
sort_by = 'insert_at_end',  -- Current
-- sort_by = 'id',           -- By buffer ID
-- sort_by = 'extension',    -- By file extension
-- sort_by = 'directory',    -- By directory
-- sort_by = 'tabs',         -- By tab order
```

## Pinning Buffers

To pin a buffer (keep it at the start):
```vim
:BufferLineTogglePin
```

## Customization

### Disable Bufferline
Set in config:
```lua
always_show_bufferline = false,
```

### Change Tab Size
```lua
tab_size = 30,  -- Increase from 21
```

### Hide Close Icons
```lua
show_buffer_close_icons = false,
show_close_icon = false,
```

## Tips

### Quick Buffer Switching
1. Look at buffer tabs at the top
2. Use `<Tab>` / `<S-Tab>` to cycle
3. Or click with mouse

### Close Multiple Buffers
```vim
:BufferLineCloseRight   " Close all to the right
:BufferLineCloseLeft    " Close all to the left
:BufferLineCloseOthers  " Close all except current
```

### Go to Specific Buffer
Uncomment the keymaps in `lua/plugins/bufferline.lua`:
```lua
vim.keymap.set('n', '<leader>1', "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
-- ... etc for 2-9
```

Then use `<leader>1` through `<leader>9` to jump to buffers 1-9.

## Troubleshooting

### Icons Not Showing
Install a Nerd Font and configure your terminal.

### Bufferline Not Visible
Check if it's disabled for your filetype in the config.

### Wrong Buffer Order
Change the `sort_by` option in the configuration.
