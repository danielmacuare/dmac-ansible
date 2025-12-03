# Noice

Noice provides a modern UI for messages, command line, and popups in Neovim.

## Features

- Animated notifications
- Better command line UI
- Popup menu improvements
- Message history
- Search integration

## Components

### Messages
System messages appear as notifications instead of at the bottom of the screen.

### Command Line
The command line appears in a centered popup instead of at the bottom.

### Popup Menu
Completion menus have improved styling and animations.

## Keymaps

| Keymap | Description |
|--------|-------------|
| `<leader>nd` | Dismiss all notifications |

## Commands

### View Message History
```vim
:Noice
```

### View Last Message
```vim
:Noice last
```

### Dismiss Notifications
```vim
:NoiceDismiss
```

Or use the keymap: `<leader>nd`

### Search Messages
```vim
:Noice telescope
```

## Telescope Integration

Search through message history with Telescope:
```vim
:Noice telescope
```

Or from Telescope:
```vim
:Telescope noice
```

## Notification Levels

Notifications appear with different colors based on level:
- **Error**: Red
- **Warning**: Yellow
- **Info**: Blue
- **Debug**: Gray

## Customization

### Disable Notifications
```lua
opts = {
  notify = {
    enabled = false,
  },
}
```

### Change Command Line Position
```lua
opts = {
  cmdline = {
    view = "cmdline", -- Use bottom command line instead of popup
  },
}
```

### Disable Popupmenu
```lua
opts = {
  popupmenu = {
    enabled = false,
  },
}
```

## Tips

### View All Messages
Press `:Noice` to see all messages in a scrollable window.

### Dismiss Annoying Notifications
Press `<leader>nd` to clear all notifications at once.

### Search Old Messages
Use `:Noice telescope` to search through message history.

## Troubleshooting

### Notifications Not Showing
1. Check if nvim-notify is installed: `:Lazy`
2. Try `:Noice` to see if messages are being captured
3. Check for errors: `:messages`

### Command Line Not Centered
1. Ensure terminal size is adequate
2. Check Noice configuration
3. Try `:Noice disable` and `:Noice enable`

### Performance Issues
Disable animations:
```lua
opts = {
  presets = {
    lsp_doc_border = true,
  },
  views = {
    notify = {
      replace = true, -- Replace old notifications
    },
  },
}
```

### Too Many Notifications
Increase timeout or filter messages:
```lua
opts = {
  routes = {
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
  },
}
```
