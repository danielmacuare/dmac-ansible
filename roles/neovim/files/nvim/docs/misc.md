# Miscellaneous Plugins

This document covers smaller plugins that don't require extensive documentation.

## nvim-autopairs

Auto-closes brackets, quotes, and other pairs.

### Features
- Automatically closes `()`, `[]`, `{}`, `''`, `""`
- Smart deletion (deletes pair when backspacing)
- Works in insert mode

### Usage
Just type an opening character and it automatically adds the closing one:
```
Type: (
Result: (|)  # cursor in middle
```

---

## nvim-ts-autotag

Auto-closes and renames HTML/XML tags.

### Features
- Auto-close tags: `<div>` → `<div></div>`
- Rename pairs: Change `<div>` to `<span>` and closing tag updates automatically

### Supported Filetypes
- HTML
- XML
- JSX/TSX
- Vue
- Svelte

### Usage
```html
Type: <div>
Result: <div>|</div>

Change: <div> to <span>
Result: <span></span>  # closing tag auto-updates
```

---

## vim-sleuth

Automatically detects and sets indentation settings.

### Features
- Detects tabs vs spaces
- Detects indent width (2, 4, 8 spaces)
- Sets `shiftwidth`, `tabstop`, `expandtab` automatically

### Usage
No configuration needed. Just open a file and sleuth detects the indentation style.

---

## vim-fugitive

Powerful Git integration for Vim.

### Key Commands
| Command | Description |
|---------|-------------|
| `:Git` | Run any git command |
| `:Git status` / `:G` | Git status |
| `:Git commit` | Commit changes |
| `:Git push` | Push to remote |
| `:Git pull` | Pull from remote |
| `:Git blame` | Show blame for current file |
| `:Git diff` | Show diff |
| `:Git log` | Show log |
| `:Gdiffsplit` | Split diff view |
| `:Gread` | Checkout current file |
| `:Gwrite` | Stage current file |

### Usage Examples

#### Commit Workflow
```vim
:G                    " Open status
s                     " Stage file (cursor on file)
cc                    " Commit
:Git push            " Push
```

#### View Blame
```vim
:Git blame
```

#### Resolve Merge Conflicts
```vim
:Gdiffsplit          " 3-way diff
:diffget //2         " Take left (ours)
:diffget //3         " Take right (theirs)
```

---

## vim-rhubarb

GitHub integration for vim-fugitive.

### Features
- Open files/commits on GitHub
- Browse GitHub from Vim

### Commands
| Command | Description |
|---------|-------------|
| `:GBrowse` | Open current file on GitHub |
| `:GBrowse <commit>` | Open commit on GitHub |

### Usage
```vim
:GBrowse              " Open current file on GitHub
:'<,'>GBrowse         " Open selection on GitHub
```

---

## which-key

Shows available keybindings in a popup.

### Features
- Displays keybindings when you press leader
- Shows descriptions for each binding
- Helps discover available commands

### Usage
1. Press `<Space>` (leader key)
2. Wait a moment
3. Popup shows available keybindings
4. Continue typing to execute command

### Example
```
Press: <Space>
Shows: All leader keybindings

Press: <Space>s
Shows: All search-related keybindings (sf, sg, sw, etc.)
```

---

## todo-comments

Highlights TODO, FIXME, NOTE, and other comments.

### Highlighted Keywords
- `TODO:` - Things to do
- `FIXME:` - Things to fix
- `HACK:` - Hacky solutions
- `WARN:` - Warnings
- `PERF:` - Performance notes
- `NOTE:` - General notes
- `TEST:` - Test-related notes

### Keymaps
| Keymap | Description |
|--------|-------------|
| `<leader>tt` | Search TODOs with Telescope |

### Usage
```lua
-- TODO: Implement this feature
-- FIXME: This is broken
-- NOTE: Important information
-- HACK: Temporary workaround
```

### Commands
```vim
:TodoTelescope        " Search all TODOs
:TodoQuickFix         " Add TODOs to quickfix
:TodoLocList          " Add TODOs to location list
```

---

## nvim-colorizer

Highlights color codes with their actual colors.

### Features
- Highlights hex colors: `#ff0000`
- Highlights RGB: `rgb(255, 0, 0)`
- Highlights color names: `red`, `blue`

### Supported Formats
- Hex: `#RGB`, `#RRGGBB`, `#RRGGBBAA`
- RGB: `rgb(r, g, b)`, `rgba(r, g, b, a)`
- HSL: `hsl(h, s, l)`, `hsla(h, s, l, a)`
- Color names: `red`, `blue`, `green`, etc.

### Usage
Just open a file with colors and they're automatically highlighted:
```css
.example {
  color: #ff0000;        /* Shows red background */
  background: rgb(0, 255, 0);  /* Shows green background */
}
```

### Commands
```vim
:ColorizerToggle      " Toggle colorizer
:ColorizerAttachToBuffer  " Enable for current buffer
:ColorizerDetachFromBuffer  " Disable for current buffer
```

---

## nvim-notify

Better notifications for Neovim.

### Features
- Animated notifications
- Notification history
- Multiple notification levels

### Usage
Notifications appear automatically for:
- LSP messages
- Plugin updates
- Error messages
- Custom notifications

### Dismiss Notifications
| Keymap | Description |
|--------|-------------|
| `<leader>nd` | Dismiss all notifications |

### Commands
```vim
:Notifications        " Show notification history
```

---

## Tips for All Plugins

### Disable a Plugin
Comment it out in `lua/plugins/misc.lua`:
```lua
-- {
--   'plugin/name',
-- },
```

### Update Plugins
```vim
:Lazy sync
```

### Check Plugin Status
```vim
:Lazy
```
