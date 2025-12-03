# Zen Mode

Distraction-free coding with Zen Mode.

## Features

- Centers the code window
- Hides UI elements
- Adjustable window size
- Tmux integration
- Terminal-specific integrations (Kitty, Alacritty, Wezterm, Neovide)

## Keymaps

No default keymaps. Add your own in `lua/core/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { desc = 'Toggle Zen Mode' })
```

## Commands

### Toggle Zen Mode
```vim
:ZenMode
```

### Close Zen Mode
```vim
:ZenMode
```
(Same command toggles on/off)

## Configuration

### Window Size
- **Width**: 120 characters
- **Height**: 100% of editor height

### Hidden Elements
When Zen Mode is active:
- Ruler is hidden
- Command display is hidden
- Status line is hidden (laststatus = 0)

### Tmux Integration
When entering Zen Mode:
- Tmux status bar is hidden
- Tmux pane is zoomed

When exiting:
- Tmux status bar is restored
- Tmux pane is unzoomed

## Plugins Integration

### Twilight
Enabled by default. Dims inactive code.

### Gitsigns
Disabled in Zen Mode.

### TODO Comments
Disabled in Zen Mode.

## Terminal Integrations

### Kitty
Disabled by default. To enable:
```lua
kitty = {
  enabled = true,
  font = '+4', -- Increase font size by 4
}
```

### Alacritty
Disabled by default. To enable:
```lua
alacritty = {
  enabled = true,
  font = '14', -- Set font size to 14
}
```

### Wezterm
Disabled by default. To enable:
```lua
wezterm = {
  enabled = true,
  font = '+4', -- 10% increase per step
}
```

### Neovide
Disabled by default. To enable:
```lua
neovide = {
  enabled = true,
  scale = 1.2, -- 20% larger
}
```

## Customization

### Change Window Width
```lua
window = {
  width = 100, -- Narrower
  -- or
  width = 0.8, -- 80% of editor width
}
```

### Change Backdrop Opacity
```lua
window = {
  backdrop = 1, -- No dimming (same as normal)
  -- or
  backdrop = 0.7, -- More dimming
}
```

### Keep Line Numbers
```lua
window = {
  options = {
    number = true,
    relativenumber = true,
  },
}
```

## Tips

### Writing Mode
Zen Mode is perfect for writing:
- Markdown files
- Documentation
- Long-form content

### Focus Mode
Use Zen Mode when you need to focus on a single file without distractions.

### Presentation Mode
Combine with increased font size for presentations:
```lua
kitty = { enabled = true, font = '+8' }
```

## Troubleshooting

### Tmux Status Not Hiding
Ensure the `on_open` and `on_close` callbacks are configured correctly.

### Window Not Centering
Check your terminal size. Zen Mode needs enough space to center the window.

### Twilight Not Working
Ensure twilight.nvim is installed:
```vim
:Lazy
```

### Can't Exit Zen Mode
Press `:ZenMode` again or `:q` to close the buffer.
