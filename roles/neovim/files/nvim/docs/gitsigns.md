# Gitsigns

Gitsigns provides git decorations and utilities for managing changes directly in Neovim.

## Features

- Git diff signs in the gutter
- Inline blame
- Hunk navigation
- Stage/unstage hunks
- Preview changes
- Integration with other git tools

## Signs

Gitsigns shows these symbols in the gutter:

| Symbol | Meaning |
|--------|---------|
| `+` | Added line |
| `~` | Changed line |
| `_` | Deleted line |
| `‾` | Top delete |

### Staged Signs
When changes are staged, they appear with the same symbols but different highlighting.

## Default Keymaps

Gitsigns provides default keymaps (check `:help gitsigns` for full list):

### Hunk Navigation
| Keymap | Description |
|--------|-------------|
| `]c` | Next hunk |
| `[c` | Previous hunk |

### Hunk Operations
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hR` | n | Reset buffer |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line |
| `<leader>tb` | n | Toggle blame |
| `<leader>hd` | n | Diff this |
| `<leader>hD` | n | Diff this ~ |
| `<leader>td` | n | Toggle deleted |

### Text Objects
| Keymap | Mode | Description |
|--------|------|-------------|
| `ih` | o, x | Inner hunk |

## Usage Examples

### Staging Changes
1. Make changes to a file
2. Navigate to a hunk with `]c`
3. Preview with `<leader>hp`
4. Stage with `<leader>hs`

### Reviewing Changes
1. Open a modified file
2. Use `]c` / `[c` to navigate between changes
3. Press `<leader>hp` to preview each change
4. Press `<leader>hb` to see who made the change (blame)

### Resetting Changes
1. Navigate to unwanted change
2. Press `<leader>hr` to reset the hunk
3. Or `<leader>hR` to reset entire buffer

### Visual Mode Operations
1. Select lines in visual mode
2. Press `<leader>hs` to stage selection
3. Or `<leader>hr` to reset selection

## Integration with Neo-tree

Gitsigns works seamlessly with Neo-tree's git status view:
1. Open Neo-tree git status: `<leader>ngs`
2. See all modified files
3. Use gitsigns keymaps to stage/unstage

## Integration with Fugitive

Gitsigns complements vim-fugitive:
- Use gitsigns for quick hunk operations
- Use fugitive for complex git operations (`:Git`, `:Gcommit`, etc.)

## Commands

### Stage Hunk
```vim
:Gitsigns stage_hunk
```

### Reset Hunk
```vim
:Gitsigns reset_hunk
```

### Preview Hunk
```vim
:Gitsigns preview_hunk
```

### Blame Line
```vim
:Gitsigns blame_line
```

### Diff This
```vim
:Gitsigns diffthis
```

## Configuration

### Changing Signs
Edit `lua/plugins/signsgit.lua`:
```lua
signs = {
  add = { text = '│' },
  change = { text = '│' },
  delete = { text = '_' },
  topdelete = { text = '‾' },
  changedelete = { text = '~' },
}
```

### Disabling Gitsigns
To disable for specific filetypes:
```lua
opts = {
  on_attach = function(bufnr)
    if vim.bo[bufnr].filetype == 'markdown' then
      return false
    end
  end,
}
```

## Tips & Tricks

### Quick Staging Workflow
1. Make changes
2. Use `]c` to jump to next hunk
3. Press `<leader>hp` to preview
4. Press `<leader>hs` to stage
5. Repeat for all hunks
6. Commit with `:Git commit`

### Blame Current Line
Press `<leader>hb` to see:
- Who made the change
- When it was made
- Commit message

### Compare with Different Branch
```vim
:Gitsigns diffthis origin/main
```

### Undo Staging
If you staged a hunk by mistake:
```vim
<leader>hu
```

## Troubleshooting

### Signs Not Showing
1. Ensure you're in a git repository
2. Check if file is tracked: `git status`
3. Refresh: `:e` (reload file)

### Blame Not Working
1. Ensure git is installed and in PATH
2. Check if file has git history
3. Try: `:Git blame` (fugitive) as alternative

### Performance Issues
For large files or repositories:
1. Disable blame: `<leader>tb`
2. Reduce update frequency in config
3. Disable for specific files/filetypes
