# Treesitter

Treesitter provides advanced syntax highlighting, code navigation, and text objects based on the abstract syntax tree (AST) of your code.

## Features

- Accurate syntax highlighting
- Incremental selection
- Code navigation (functions, classes, etc.)
- Text objects for functions, classes, parameters
- Smart indentation

## Supported Languages

Auto-installed parsers for:
- Lua, Python, JavaScript, TypeScript, TSX
- Terraform, SQL, Dockerfile
- TOML, JSON, YAML
- Java, Groovy, Go
- GraphQL, Markdown
- Bash, Make, CMake
- HTML, CSS
- Vim, Vimdoc, Regex

## Keymaps

### Incremental Selection
| Keymap | Description |
|--------|-------------|
| `<C-Space>` | Init selection / Expand selection |
| `<C-s>` | Expand to scope |
| `<M-Space>` | Shrink selection |

### Text Objects (Select)
| Keymap | Description |
|--------|-------------|
| `aa` | Select outer parameter |
| `ia` | Select inner parameter |
| `af` | Select outer function |
| `if` | Select inner function |
| `ac` | Select outer class |
| `ic` | Select inner class |

### Navigation (Functions)
| Keymap | Description |
|--------|-------------|
| `]m` | Go to next function start |
| `]M` | Go to next function end |
| `[m` | Go to previous function start |
| `[M` | Go to previous function end |

### Navigation (Classes)
| Keymap | Description |
|--------|-------------|
| `]]` | Go to next class start |
| `][` | Go to next class end |
| `[[` | Go to previous class start |
| `[]` | Go to previous class end |

### Swap Parameters
| Keymap | Description |
|--------|-------------|
| `<leader>a` | Swap parameter with next |
| `<leader>A` | Swap parameter with previous |

## Usage Examples

### Incremental Selection
1. Place cursor inside a function
2. Press `<C-Space>` to select the current node
3. Press `<C-Space>` again to expand to parent node
4. Keep pressing to expand further
5. Press `<M-Space>` to shrink selection

### Text Objects
```python
def example(param1, param2):
    return param1 + param2
```

- `vif` - Select function body
- `vaf` - Select entire function including def
- `via` - Select parameter (cursor on param1)
- `daa` - Delete parameter including comma

### Function Navigation
```python
def func1():
    pass

def func2():
    pass

def func3():
    pass
```

- `]m` - Jump to next function (func2)
- `[m` - Jump to previous function (func1)

## Commands

### Install Parser
```vim
:TSInstall <language>
```

### Update Parsers
```vim
:TSUpdate
```

### Check Installation
```vim
:checkhealth nvim-treesitter
```

### Toggle Highlighting
```vim
:TSToggle highlight
```

## Custom File Types

The configuration includes custom file type associations:
- `.tf` → terraform
- `.tfvars` → terraform
- `.pipeline` → groovy
- `.multibranch` → groovy

## Troubleshooting

### Highlighting Not Working
1. Check if parser is installed:
```vim
:TSInstallInfo
```

2. Install missing parser:
```vim
:TSInstall <language>
```

3. Check health:
```vim
:checkhealth nvim-treesitter
```

### Slow Performance
Treesitter can be slow on very large files. To disable:
```vim
:TSDisable highlight
```

### Incorrect Highlighting
Update the parser:
```vim
:TSUpdate <language>
```

### Parser Installation Fails
Ensure you have a C compiler installed:
```bash
# macOS
xcode-select --install

# Linux
sudo apt install build-essential
```
