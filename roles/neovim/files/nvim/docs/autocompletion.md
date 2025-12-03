# Auto-completion

Auto-completion is powered by nvim-cmp, providing intelligent code completion from multiple sources.

## Plugins

- **nvim-cmp**: Completion engine
- **LuaSnip**: Snippet engine
- **cmp_luasnip**: LuaSnip completion source
- **cmp-nvim-lsp**: LSP completion source
- **cmp-buffer**: Buffer completion source
- **cmp-path**: Path completion source
- **cmp-cmdline**: Command-line completion source
- **friendly-snippets**: Pre-made snippets collection

## Keymaps

### In Completion Menu
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-j>` | i | Select next item |
| `<C-k>` | i | Select previous item |
| `<CR>` | i | Confirm selection |
| `<C-c>` | i | Trigger completion manually |
| `<Tab>` | i | Next item or expand snippet |
| `<S-Tab>` | i | Previous item or jump back in snippet |

### Snippet Navigation
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-l>` | i, s | Jump to next snippet placeholder |
| `<C-h>` | i, s | Jump to previous snippet placeholder |

## Completion Sources

Completion suggestions come from:

1. **LSP** - Language server completions (highest priority)
2. **LuaSnip** - Snippet completions
3. **Buffer** - Words from current buffer
4. **Path** - File system paths

## Completion Icons

Each completion item shows an icon indicating its type:

| Icon | Type |
|------|------|
| 󰉿 | Text |
| m | Method |
| 󰊕 | Function |
|  | Constructor |
|  | Field |
| 󰆧 | Variable |
| 󰌗 | Class |
|  | Interface |
|  | Module |
|  | Property |
|  | Unit |
| 󰎠 | Value |
|  | Enum |
| 󰌋 | Keyword |
|  | Snippet |
| 󰏘 | Color |
| 󰈙 | File |
|  | Reference |
| 󰉋 | Folder |
|  | EnumMember |
| 󰇽 | Constant |
|  | Struct |
|  | Event |
| 󰆕 | Operator |
| 󰊄 | TypeParameter |

## Command-line Completion

### Search Completion
When searching with `/`, completion suggests:
- Words from the current buffer

### Command Completion
When entering commands with `:`, completion suggests:
- File paths
- Vim commands
- Command arguments

## LuaSnip

LuaSnip provides snippet expansion and navigation.

### Using Snippets
1. Type the snippet trigger
2. Press `<Tab>` to expand
3. Use `<C-l>` / `<C-h>` to navigate placeholders
4. Fill in each placeholder
5. Press `<C-l>` to move to the next placeholder

### Example Workflow
```lua
-- Type "fn" and press Tab
function name(args)
  -- cursor here
end
```

### Snippet Sources
Snippets are loaded from:
- **friendly-snippets**: Community-maintained snippets for many languages
- Custom snippets (can be added in `~/.config/nvim/snippets/`)

## Customization

### Adding Custom Completion Sources
Edit `lua/plugins/autocompletion.lua` and add to the `sources` table:
```lua
sources = {
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'buffer' },
  { name = 'path' },
  { name = 'your_source' }, -- Add here
}
```

### Changing Completion Behavior
Modify the `completion` option:
```lua
completion = { 
  completeopt = 'menu,menuone,noinsert' -- or 'menu,menuone,noselect'
}
```

- `noinsert`: Don't auto-insert first match
- `noselect`: Don't auto-select first match

### Disabling Auto-completion
To disable auto-completion and only trigger manually:
```lua
completion = { 
  autocomplete = false 
}
```
Then use `<C-c>` to trigger completion manually.

## Tips & Tricks

### Accept First Match Quickly
Press `<CR>` immediately after typing to accept the first suggestion.

### Navigate Without Selecting
Use `<C-j>` / `<C-k>` to browse suggestions without selecting.

### Snippet Preview
Hover over a snippet completion to see its expanded form.

### Buffer Completion
When LSP isn't available, nvim-cmp falls back to buffer completion, suggesting words from your current file.

## Troubleshooting

### No Completions Showing
1. Check if LSP is attached: `:LspInfo`
2. Trigger manually with `<C-c>`
3. Check if you're in insert mode

### Completions Too Slow
1. Reduce the number of sources
2. Increase the debounce time in config
3. Disable buffer completion for large files

### Snippets Not Working
1. Ensure LuaSnip is installed: `:Lazy`
2. Check if friendly-snippets is loaded
3. Try manually triggering with `<Tab>`

### Wrong Completion Selected
Change `completeopt` to `noselect` to prevent auto-selection.
