# Neo-tree

Neo-tree is a modern file explorer for Neovim with git integration, diagnostics, and a clean UI.

## Features

- File system navigation
- Git status integration
- LSP diagnostics display
- Buffer management
- Multiple view modes (filesystem, buffers, git status)
- Window picker for opening files

## Keymaps

### Opening Neo-tree
| Keymap | Description |
|--------|-------------|
| `<leader>e` | Toggle Neo-tree (left sidebar) |
| `<leader>w` | Toggle Neo-tree (floating window) |
| `<leader>ngs` | Open git status window |
| `\` | Reveal current file in Neo-tree |

### Navigation (Inside Neo-tree)
| Keymap | Action |
|--------|--------|
| `<CR>` / `l` | Open file/folder |
| `<Space>` | Toggle node |
| `<BS>` | Navigate up |
| `.` | Set root directory |
| `H` | Toggle hidden files |
| `C` | Close node |
| `z` | Close all nodes |

### File Operations
| Keymap | Action |
|--------|--------|
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |

### Window Management
| Keymap | Action |
|--------|--------|
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `w` | Open with window picker |
| `P` | Toggle preview |

### View Modes
| Keymap | Action |
|--------|--------|
| `<` | Previous source (filesystem → buffers → git) |
| `>` | Next source |

### Filtering & Sorting
| Keymap | Action |
|--------|--------|
| `/` | Fuzzy finder |
| `D` | Fuzzy finder (directories only) |
| `#` | Fuzzy sorter |
| `f` | Filter on submit |
| `<C-x>` | Clear filter |

### Git Navigation
| Keymap | Action |
|--------|--------|
| `[g` | Previous git modified file |
| `]g` | Next git modified file |

### Ordering
Press `o` to open the ordering menu, then:
| Keymap | Sort By |
|--------|---------|
| `oc` | Created time |
| `od` | Diagnostics |
| `og` | Git status |
| `om` | Modified time |
| `on` | Name |
| `os` | Size |
| `ot` | Type |

### Git Operations (in git_status view)
| Keymap | Action |
|--------|--------|
| `A` | Git add all |
| `ga` | Git add file |
| `gu` | Git unstage file |
| `gr` | Git revert file |
| `gc` | Git commit |
| `gp` | Git push |
| `gg` | Git commit and push |

### Miscellaneous
| Keymap | Action |
|--------|--------|
| `q` | Close window |
| `R` | Refresh |
| `?` | Show help |
| `i` | Show file details |

## Configuration

### Window Position
Neo-tree can be opened in different positions:
- **Left sidebar**: `<leader>e`
- **Floating window**: `<leader>w`
- **Right sidebar**: Modify config

### Hidden Files
By default, these are hidden:
- `.DS_Store`
- `thumbs.db`
- `node_modules`
- `__pycache__`
- `.git`
- `.python-version`
- `.venv`

Toggle hidden files with `H` inside Neo-tree.

### File Icons
Neo-tree uses nvim-web-devicons for file type icons. Requires a Nerd Font.

### Git Integration
Git status is shown with these symbols:
- `` - Added
- `` - Modified
- `✖` - Deleted
- `󰁕` - Renamed
- `` - Untracked
- `` - Ignored
- `󰄱` - Unstaged
- `` - Staged
- `` - Conflict

### Diagnostics
LSP diagnostics are shown with these icons:
- `` - Error
- `` - Warning
- `` - Info
- `󰌵` - Hint

## Window Picker

When opening files with `w`, Neo-tree uses nvim-window-picker to let you choose which window to open the file in.

### Window Picker Keymaps
- Press the highlighted letter to select a window
- `<Esc>` to cancel

## Tips & Tricks

### Quick File Creation
1. Press `a` in Neo-tree
2. Type the filename (use `/` for nested directories)
3. Press `<CR>`

Example: `src/components/Button.tsx` creates all directories and the file.

### Batch Operations
1. Use fuzzy finder (`/`) to filter files
2. Perform operations on filtered results

### Focus on Current File
Press `\` to reveal and focus the current file in Neo-tree.

### Git Workflow
1. Open git status: `<leader>ngs`
2. Stage files: `ga`
3. Commit: `gc`
4. Push: `gp`

## Troubleshooting

### Icons Not Showing
Install a Nerd Font and configure your terminal to use it.

### Git Status Not Updating
Press `R` to manually refresh, or check if you're in a git repository.

### Neo-tree Won't Open
Check for errors with `:messages` and ensure all dependencies are installed.

### Performance Issues
If Neo-tree is slow with large directories:
1. Add more patterns to `hide_by_name` in the config
2. Disable `follow_current_file` if enabled
3. Use `:Neotree close` and `:Neotree open` instead of toggle
