# Vim-Tmux-Navigator

Seamless navigation between Neovim splits and tmux panes.

## Features

- Unified navigation between Vim and tmux
- Same keybindings work in both
- No mental context switching

## Keymaps

| Keymap | Description |
|--------|-------------|
| `<C-h>` | Navigate left (Vim split or tmux pane) |
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |
| `<C-\>` | Navigate to previous |

## Setup

### Neovim Side
Already configured in `lua/plugins/vim-tmux-navigator.lua`.

### Tmux Side
Add to your `~/.tmux.conf`:

```bash
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(\\.[0-9]+)?).*/\\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\\' select-pane -l
```

Then reload tmux:
```bash
tmux source-file ~/.tmux.conf
```

## Usage

### Without Tmux
When not using tmux, the keybindings work as normal Vim window navigation.

### With Tmux
When using tmux, the same keybindings navigate between:
- Vim splits (when at a Vim split boundary)
- Tmux panes (when at a tmux pane boundary)

### Example Workflow
```
┌─────────────┬─────────────┐
│             │             │
│  Vim Split  │  Vim Split  │
│             │             │
├─────────────┴─────────────┤
│                           │
│      Tmux Pane            │
│                           │
└───────────────────────────┘
```

- `<C-h>` / `<C-l>` moves between Vim splits
- `<C-j>` moves from Vim to tmux pane
- `<C-k>` moves from tmux pane back to Vim

## Commands

### Check Process List
```vim
:TmuxNavigatorProcessList
```

Shows the process list used to detect Vim.

## Troubleshooting

### Navigation Not Working in Tmux
1. Ensure tmux config is added
2. Reload tmux config: `tmux source-file ~/.tmux.conf`
3. Restart tmux session

### Conflicts with Other Plugins
If you have other plugins using `<C-h/j/k/l>`, they may conflict. Remap vim-tmux-navigator:

```lua
keys = {
  { '<M-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
  { '<M-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
  { '<M-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
  { '<M-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
}
```

### Not Working in Neovim Terminal
The plugin works in normal Neovim, not in `:terminal` mode.

## Tips

### Disable Temporarily
```vim
:TmuxNavigateDisable
```

### Re-enable
```vim
:TmuxNavigateEnable
```
