# Telescope

Telescope is a highly extendable fuzzy finder for Neovim. It provides a unified interface for searching files, buffers, git commits, LSP symbols, and more.

## Features

- Fuzzy file finding
- Live grep (search in files)
- Buffer management
- Git integration
- LSP symbol search
- Extensible with custom pickers

## Dependencies

- **plenary.nvim**: Required Lua functions
- **telescope-fzf-native.nvim**: Fast fuzzy finding (requires `make`)
- **telescope-ui-select.nvim**: Use Telescope for vim.ui.select
- **nvim-web-devicons**: File icons

## Keymaps

### File Search
| Keymap | Description |
|--------|-------------|
| `<leader>sf` | Search files |
| `<leader>?` | Recently opened files |
| `<leader>s.` | Recent files |
| `<leader>/` | Fuzzy search in current buffer |

### Content Search
| Keymap | Description |
|--------|-------------|
| `<leader>sg` | Live grep (search in all files) |
| `<leader>sw` | Search current word |
| `<leader>s/` | Live grep in open files |

### Buffer & Navigation
| Keymap | Description |
|--------|-------------|
| `<leader>sb` | Search buffers |
| `<leader><leader>` | Find existing buffers |
| `<leader>sm` | Search marks |
| `<leader>sk` | Search keymaps |

### Git Integration
| Keymap | Description |
|--------|-------------|
| `<leader>gf` | Search git files |
| `<leader>gc` | Search git commits |
| `<leader>gcf` | Search git commits for current file |
| `<leader>gb` | Search git branches |
| `<leader>gs` | Git status (diff view) |

### LSP Integration
| Keymap | Description |
|--------|-------------|
| `<leader>sd` | Search diagnostics |
| `<leader>sds` | Search LSP document symbols |
| `<leader>sr` | Resume last search |

### Help & Documentation
| Keymap | Description |
|--------|-------------|
| `<leader>sh` | Search help tags |

### TODO Comments
| Keymap | Description |
|--------|-------------|
| `<leader>tt` | Search TODO comments |

## Telescope Mappings

When Telescope is open, use these mappings:

### Insert Mode
| Keymap | Action |
|--------|--------|
| `<C-j>` | Move to next result |
| `<C-k>` | Move to previous result |
| `<C-l>` | Select/open file |
| `<Esc>` | Close Telescope |

### Normal Mode
| Keymap | Action |
|--------|--------|
| `j` / `k` | Navigate results |
| `<CR>` | Select/open file |
| `q` | Close Telescope |

## Configuration

### File Ignore Patterns
Telescope ignores these directories by default:
- `node_modules`
- `.git`
- `.venv`

### Hidden Files
Hidden files (dotfiles) are shown by default in file search.

### Buffer Sorting
Buffers are sorted by last used, with the most recent first.

## Custom Pickers

### Find Files
```vim
:Telescope find_files
```

### Live Grep
```vim
:Telescope live_grep
```

### Buffers
```vim
:Telescope buffers
```

### Help Tags
```vim
:Telescope help_tags
```

## Extensions

### FZF Native
Provides faster fuzzy finding using native C code. Automatically loaded if `make` is available.

### UI Select
Replaces Neovim's default `vim.ui.select` with Telescope, providing a better UI for selections.

### Noice
Integration with noice.nvim for searching notifications and messages.

## Tips & Tricks

### Multi-select
In Telescope, you can select multiple files:
1. Use `<Tab>` to mark files
2. Press `<CR>` to open all marked files

### Search in Specific Directory
```vim
:Telescope find_files cwd=~/projects
```

### Search with Glob Pattern
```vim
:Telescope find_files find_command=rg,--files,--glob,*.lua
```

### Preview Window
- The preview window shows file contents
- Use `<C-u>` / `<C-d>` to scroll the preview

## Troubleshooting

### Slow Performance
If Telescope is slow:
1. Ensure `telescope-fzf-native` is installed and compiled
2. Reduce the number of files being searched with better ignore patterns
3. Use `:Telescope git_files` instead of `:Telescope find_files` in git repos

### No Results
- Check if you're in the correct directory
- Verify ignore patterns aren't too restrictive
- Try `:Telescope find_files hidden=true` to include hidden files

### ripgrep Not Found
Install ripgrep for live grep functionality:
```bash
brew install ripgrep  # macOS
```
