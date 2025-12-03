# Render Markdown

Renders Markdown files with enhanced formatting in Neovim.

## Features

- Renders headings with different sizes
- Shows checkboxes for task lists
- Renders code blocks with syntax highlighting
- Displays tables properly
- Shows links and images
- Renders blockquotes

## Usage

Open any Markdown file and it will automatically render with enhanced formatting.

## Rendered Elements

### Headings
```markdown
# Heading 1    → Large, bold
## Heading 2   → Medium, bold
### Heading 3  → Smaller, bold
```

### Lists
```markdown
- Bullet point
* Another bullet
1. Numbered list
2. Second item
```

### Task Lists
```markdown
- [ ] Unchecked task
- [x] Completed task
```

### Code Blocks
````markdown
```python
def hello():
    print("Hello, World!")
```
````

### Links
```markdown
[Link text](https://example.com)
```

### Images
```markdown
![Alt text](image.png)
```

### Tables
```markdown
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |
```

### Blockquotes
```markdown
> This is a quote
> Spanning multiple lines
```

## Commands

### Toggle Rendering
```vim
:RenderMarkdown toggle
```

### Enable Rendering
```vim
:RenderMarkdown enable
```

### Disable Rendering
```vim
:RenderMarkdown disable
```

## Customization

Edit `lua/plugins/render-markdown.lua` to customize rendering options.

### Disable for Specific Files
```lua
opts = {
  file_types = { 'markdown' }, -- Only these filetypes
}
```

## Tips

### Writing Documentation
Render Markdown is perfect for:
- README files
- Documentation
- Notes
- Blog posts

### Toggle for Editing
If rendering interferes with editing:
1. Disable with `:RenderMarkdown disable`
2. Edit your content
3. Re-enable with `:RenderMarkdown enable`

### Combine with Zen Mode
For distraction-free writing:
```vim
:ZenMode
```

## Troubleshooting

### Not Rendering
1. Check if you're in a Markdown file: `:set filetype?`
2. Ensure Treesitter markdown parser is installed: `:TSInstall markdown`
3. Try toggling: `:RenderMarkdown toggle`

### Rendering Looks Wrong
1. Ensure you have a Nerd Font installed
2. Check terminal true color support
3. Try a different color scheme

### Performance Issues
For large Markdown files:
```vim
:RenderMarkdown disable
```
