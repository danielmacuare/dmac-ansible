# Catppuccin Color Scheme

Catppuccin is a soothing pastel theme with four flavors.

## Flavors

- **Latte**: Light theme
- **Frappé**: Medium-light theme
- **Macchiato**: Medium-dark theme
- **Mocha**: Dark theme (default)

## Current Configuration

The configuration uses the **Mocha** flavor (dark theme).

## Changing Flavor

Edit `lua/plugins/catpuccin.lua`:

```lua
require('catppuccin').setup {
  flavour = 'mocha', -- Change to: latte, frappe, macchiato, or mocha
}
```

## Integrations

Catppuccin is integrated with:
- Gitsigns
- Neo-tree
- Telescope
- Mini (indent-blankline)

## Commands

### Switch Flavor Temporarily
```vim
:colorscheme catppuccin-latte
:colorscheme catppuccin-frappe
:colorscheme catppuccin-macchiato
:colorscheme catppuccin-mocha
```

## Customization

### Transparent Background
```lua
require('catppuccin').setup {
  transparent_background = true,
}
```

### Custom Highlights
```lua
require('catppuccin').setup {
  custom_highlights = function(colors)
    return {
      Comment = { fg = colors.flamingo },
      LineNr = { fg = colors.overlay0 },
    }
  end,
}
```

## Alternative Themes

To use a different theme, edit `lua/plugins/catpuccin.lua` or create a new plugin file:

```lua
return {
  'theme-author/theme-name',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'theme-name'
  end,
}
```

Popular alternatives:
- `folke/tokyonight.nvim`
- `EdenEast/nightfox.nvim`
- `rebelot/kanagawa.nvim`
- `navarasu/onedark.nvim`
