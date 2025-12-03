# Alpha (Start Screen)

Alpha provides a customizable start screen for Neovim.

## Features

- ASCII art header
- Recent files
- Quick actions
- Session management

## Current Configuration

Uses the **Startify** theme with a custom NEOVIM ASCII header.

## Start Screen Sections

When you open Neovim without a file, Alpha shows:
1. **Header**: NEOVIM ASCII art
2. **Recent Files**: Recently opened files
3. **Sessions**: Saved sessions (if any)
4. **Quick Actions**: Common commands

## Navigation

- Use `j` / `k` to navigate
- Press `<CR>` to select an item
- Press `q` to close and open an empty buffer

## Customization

### Changing the Header

Edit `lua/plugins/alpha.lua`:

```lua
dashboard.section.header.val = {
  [[Your ASCII art here]],
  [[Line 2]],
  [[Line 3]],
}
```

### ASCII Art Resources

- [ASCII Art Generator](https://patorjk.com/software/taag/)
- [ascii.nvim](https://github.com/MaximilianLloyd/ascii.nvim)

### Using Dashboard Theme

Change from Startify to Dashboard:

```lua
local dashboard = require 'alpha.themes.dashboard'
```

### Disabling Alpha

Comment out the plugin in `init.lua` or set:

```lua
vim.g.alpha_disable = 1
```

## Tips

### Skip Start Screen

Open Neovim with a file to skip the start screen:
```bash
nvim file.txt
```

### Show Start Screen Manually

```vim
:Alpha
```
