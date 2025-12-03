# TODO Comments

Highlights and manages TODO comments in your code.

## Features

- Highlights TODO, FIXME, HACK, WARN, PERF, NOTE, TEST
- Search all TODOs with Telescope
- Quickfix and location list integration
- Customizable keywords and colors

## Highlighted Keywords

| Keyword | Purpose | Color |
|---------|---------|-------|
| `TODO:` | Things to implement | Info (blue) |
| `FIXME:` | Things to fix | Error (red) |
| `HACK:` | Temporary workarounds | Warning (orange) |
| `WARN:` | Warnings | Warning (orange) |
| `PERF:` | Performance improvements | Hint (purple) |
| `NOTE:` | Important notes | Hint (purple) |
| `TEST:` | Test-related notes | Test (green) |

## Usage

### In Code
```lua
-- TODO: Implement user authentication
-- FIXME: Memory leak in this function
-- HACK: Temporary fix until API is updated
-- WARN: This will be deprecated in v2.0
-- PERF: Optimize this loop
-- NOTE: This requires Node.js 18+
-- TEST: Add unit tests for edge cases
```

### Alternative Formats
```lua
-- TODO(username): Assign to specific person
-- FIXME: Brief description
-- TODO: Multi-line todos
--       can span multiple lines
```

## Keymaps

| Keymap | Description |
|--------|-------------|
| `<leader>tt` | Search TODOs with Telescope |

## Commands

### Search TODOs
```vim
:TodoTelescope
```

### Add to Quickfix
```vim
:TodoQuickFix
```

### Add to Location List
```vim
:TodoLocList
```

### Trouble Integration
```vim
:TodoTrouble
```

## Telescope Integration

Press `<leader>tt` to open Telescope with all TODOs:
1. Navigate with `j` / `k`
2. Preview with `<Tab>`
3. Jump to TODO with `<CR>`

## Customization

### Add Custom Keywords

Edit `lua/plugins/todo-comments.lua`:

```lua
opts = {
  keywords = {
    CUSTOM = { icon = "󰄬", color = "hint" },
  },
}
```

### Change Colors

```lua
opts = {
  colors = {
    error = { "DiagnosticError", "#DC2626" },
    warning = { "DiagnosticWarn", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
  },
}
```

### Disable Signs
```lua
opts = {
  signs = false,
}
```

## Tips

### Project Management
1. Add TODOs throughout your code
2. Use `<leader>tt` to see all TODOs
3. Prioritize with FIXME (urgent) vs TODO (later)

### Code Review
Use NOTE and WARN for code review comments:
```lua
-- NOTE: This pattern is preferred over X
-- WARN: Don't modify this without updating Y
```

### Performance Tracking
Mark optimization opportunities:
```lua
-- PERF: This could be cached
-- PERF: Consider using a hash map here
```

### Test Coverage
Track testing needs:
```lua
-- TEST: Add test for error handling
-- TEST: Mock API responses
```

## Troubleshooting

### TODOs Not Highlighted
1. Check if plugin is loaded: `:Lazy`
2. Ensure you're using the correct format: `TODO:` (with colon)
3. Try `:e` to reload the file

### Telescope Search Not Working
1. Ensure Telescope is installed
2. Check for errors: `:messages`
3. Try `:TodoQuickFix` as alternative

### Custom Keywords Not Working
1. Restart Neovim after config changes
2. Check syntax in config file
3. Ensure icon fonts are available
