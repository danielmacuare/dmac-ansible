# Indent Blankline

Adds indentation guides to make code structure more visible.

## Features

- Vertical lines showing indentation levels
- Scope highlighting
- Customizable characters
- Filetype exclusions

## Appearance

Uses `▏` character for indent guides.

## Scope

- **show_start**: Disabled (doesn't show scope start)
- **show_end**: Disabled (doesn't show scope end)
- **show_exact_scope**: Disabled

This provides a cleaner look with just the indent guides.

## Excluded Filetypes

Indent guides are disabled for:
- help
- startify
- dashboard
- packer
- neogitstatus
- NvimTree
- Trouble

## Customization

### Change Indent Character

Edit `lua/plugins/indent-blanklines.lua`:

```lua
opts = {
  indent = {
    char = '│',  -- or '┊', '┆', '¦', '|', '⎸'
  },
}
```

### Enable Scope Highlighting

```lua
opts = {
  scope = {
    show_start = true,
    show_end = true,
  },
}
```

### Add More Excluded Filetypes

```lua
exclude = {
  filetypes = {
    'help',
    'markdown',  -- Add markdown
    'text',      -- Add text
  },
}
```

## Commands

### Toggle Indent Guides
```vim
:IBLToggle
```

### Enable/Disable
```vim
:IBLEnable
:IBLDisable
```

## Tips

### Disable for Specific Buffer
```vim
:IBLDisable
```

### Temporary Toggle
Create a keymap in `lua/core/keymaps.lua`:
```lua
vim.keymap.set('n', '<leader>ti', ':IBLToggle<CR>', { desc = 'Toggle indent guides' })
```

## Troubleshooting

### Guides Not Showing
1. Check if filetype is excluded
2. Ensure `expandtab` is set (guides don't show for tabs)
3. Try `:IBLEnable`

### Performance Issues
Disable for large files:
```vim
:IBLDisable
```
