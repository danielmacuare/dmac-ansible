# Lualine

Lualine is a fast and customizable status line for Neovim.

## Features

- Shows current mode
- Git branch information
- File information
- Diagnostics count
- Git diff stats
- File encoding and type
- Cursor position and progress

## Status Line Sections

### Left Side
- **Mode**: Current Vim mode (NORMAL, INSERT, VISUAL, etc.)
- **Branch**: Current git branch
- **Filename**: Current file name with status (modified, readonly)

### Right Side
- **Diagnostics**: Error and warning counts
- **Diff**: Git changes (+, ~, -)
- **Encoding**: File encoding (utf-8, etc.)
- **Filetype**: File type with icon
- **Location**: Line and column number
- **Progress**: Percentage through file

## Mode Indicators

| Mode | Display |
|------|---------|
| Normal | NORMAL |
| Insert | INSERT |
| Visual | VISUAL |
| Visual Line | V-LINE |
| Visual Block | V-BLOCK |
| Command | COMMAND |
| Replace | REPLACE |
| Terminal | TERMINAL |

## Diagnostic Icons

- `` Error
- `` Warning
- `` Info
- `` Hint

## Git Diff Icons

- `` Added lines
- `` Modified lines
- `` Removed lines

## Theme

Currently using the **Dracula** theme.

### Available Themes
- dracula (current)
- nord
- onedark
- catppuccin
- gruvbox
- tokyonight
- and many more

### Changing Theme
Edit `lua/plugins/lualine.lua`:
```lua
require('lualine').setup {
  options = {
    theme = 'nord', -- Change theme here
  },
}
```

## Customization

### Hide on Small Windows
Lualine automatically hides some components when the window is less than 100 characters wide:
- Diagnostics
- Diff
- Encoding
- Filetype

### Disabled Filetypes
Lualine is disabled for:
- alpha (start screen)
- neo-tree (file explorer)
- Avante

### Separators
Current configuration uses:
- Section separators: `` and ``
- Component separators: `` and ``

To change separators, edit the config:
```lua
section_separators = { left = '', right = '' },
component_separators = { left = '', right = '' },
```

## Extensions

Lualine includes the **fugitive** extension for better Git integration.

## Troubleshooting

### Icons Not Showing
Install a Nerd Font and configure your terminal to use it.

### Status Line Not Visible
Check if `laststatus` is set:
```vim
:set laststatus=3
```

### Wrong Colors
Ensure your terminal supports true colors:
```vim
:set termguicolors
```
