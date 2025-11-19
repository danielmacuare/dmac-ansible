# ZSH Role

## Overview

The ZSH role installs and configures ZSH shell with Oh-My-Zsh framework and Powerlevel10k theme, providing a modern, feature-rich shell experience.

This role:
- Installs ZSH shell and dependencies
- Installs Oh-My-Zsh framework
- Configures Powerlevel10k (P10k) theme
- Installs MesloLGS Nerd Fonts
- Sets up ZSH plugins (autosuggestions, syntax highlighting)
- Sets ZSH as default shell for specified users

## What This Role Does

1. **ZSH Installation**: Installs ZSH and required dependencies (git, wget, fd-find)
2. **Oh-My-Zsh Setup**: Installs Oh-My-Zsh framework for each user
3. **Powerlevel10k Theme**: Installs and configures P10k theme
4. **Font Installation**: Installs MesloLGS Nerd Fonts for proper icon display
5. **Plugin Installation**: Installs custom ZSH plugins:
   - zsh-autosuggestions - Command suggestions based on history
   - zsh-fast-syntax-highlighting - Syntax highlighting as you type
   - fzf-tab - Fuzzy finder for tab completion
   - zsh-completions - Additional completion definitions
6. **Shell Configuration**: Generates .zshrc for each user
7. **Default Shell**: Sets ZSH as default shell for specified users

## Required Inputs

### 1. Variables File

**File**: `inventories/group_vars/all/vars.yaml`

Define users who should have ZSH configured:

```yaml
zsh_users:
  - username: dmac
    oh_my_zsh:
      write_zshrc: true
  - username: user2
    oh_my_zsh:
      write_zshrc: true

zsh_plugins:
  - zsh-autosuggestions
  - zsh-fast-syntax-highlighting
```

### 2. No Vault Variables Required

This role doesn't require any vault variables.

## Usage

Run the zsh role:

```bash
# Run full zsh role
ansible-playbook playbooks/ubuntu.yml -K --tags zsh

# Check mode (dry run)
ansible-playbook playbooks/ubuntu.yml -K --tags zsh --check

# Run specific sub-tasks
ansible-playbook playbooks/ubuntu.yml -K --tags oh-my-zsh
ansible-playbook playbooks/ubuntu.yml -K --tags p10k
```


## Variables Reference

### Required Variables

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `zsh_users` | list | Users to configure ZSH for | See vars.yaml example |

### Optional Variables (Defaults)

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `zsh_dependencies` | list | `[zsh, git, wget, fd-find]` | Packages to install |
| `zsh_bin_path` | string | `/usr/bin/zsh` | Path to ZSH binary |
| `zsh_oh_my_zsh_theme` | string | `robbyrussell` | Oh-My-Zsh theme (overridden by P10k) |
| `zsh_oh_myzsh_install` | boolean | `true` | Install Oh-My-Zsh |
| `zsh_oh_my_zsh_update_mode` | string | `disabled` | Update mode (disabled/auto/reminder) |
| `zsh_oh_my_zsh_write_zshrc` | boolean | `true` | Generate .zshrc file |
| `zsh_p10k_write_p10k_config` | boolean | `true` | Deploy P10k config file |
| `zsh_plugins` | list | `[]` | ZSH plugins to install |
| `zsh_plugins_path` | string | `.oh-my-zsh/custom/plugins` | Path for custom plugins |

### Default Values

Defined in `roles/zsh/defaults/main.yaml`:

```yaml
zsh_dependencies:
  - zsh
  - git
  - wget
  - fd-find

zsh_bin_path: "/usr/bin/zsh"

zsh_oh_my_zsh_theme: "robbyrussell"
zsh_oh_myzsh_install: true
zsh_oh_my_zsh_update_mode: disabled
zsh_oh_my_zsh_update_frequency: 5
zsh_oh_my_zsh_write_zshrc: true

zsh_p10k_dependencies:
  - zsh
  - git
  - wget
  - curl

zsh_p10k_write_p10k_config: true

# Plugin configuration
zsh_plugins_path: '.oh-my-zsh/custom/plugins'
zsh_autosuggestions_repo_url: "https://github.com/zsh-users/zsh-autosuggestions.git"
zsh_fast_syntax_highlighting_repo_url: "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
zsh_fzf_tab_repo_url: "https://github.com/Aloxaf/fzf-tab.git"
zsh_completions_repo_url: "https://github.com/zsh-users/zsh-completions.git"
```

## Common Issues

### Issue: ZSH Not Set as Default Shell

**Symptoms**:
- User still logs in with bash
- `echo $SHELL` shows `/bin/bash`

**Solution**:
- Manually set default shell: `chsh -s /usr/bin/zsh username`
- Log out and log back in
- Verify: `echo $SHELL` should show `/usr/bin/zsh`

### Issue: Oh-My-Zsh Already Installed

**Error**:
```
You already have Oh My Zsh installed
```

**Solution**:
- This is expected behavior - the role won't reinstall
- To force reinstall, remove `~/.oh-my-zsh` directory first
- Or set `update: true` in the git task

### Issue: Fonts Not Displaying Correctly

**Symptoms**:
- Icons appear as boxes or question marks
- Powerline symbols broken

**Solution**:
- Install MesloLGS Nerd Fonts on your local machine (not the server)
- Configure your terminal to use "MesloLGS NF" font
- For iTerm2: Preferences → Profiles → Text → Font
- For VS Code: Settings → Terminal Font Family → "MesloLGS NF"
- Restart terminal application

### Issue: P10k Configuration Wizard Appears

**Symptoms**:
- P10k wizard runs on first login
- Asks configuration questions

**Solution**:
- This is normal if `zsh_p10k_write_p10k_config: false`
- To skip wizard, set `zsh_p10k_write_p10k_config: true`
- Or manually copy `.p10k.zsh` config file
- Run wizard to customize: `p10k configure`

### Issue: Plugins Not Working

**Symptoms**:
- Autosuggestions not appearing
- Syntax highlighting not working

**Solution**:
- Verify plugins are in `zsh_plugins` list in vars.yaml
- Check plugins are installed: `ls ~/.oh-my-zsh/custom/plugins/`
- Ensure plugins are enabled in .zshrc
- Restart shell: `exec zsh`

### Issue: Permission Denied on .oh-my-zsh

**Error**:
```
Permission denied: /home/user/.oh-my-zsh
```

**Solution**:
- Check ownership: `ls -la ~/.oh-my-zsh`
- Fix permissions: `sudo chown -R username:username ~/.oh-my-zsh`
- The role should set correct permissions automatically

### Issue: Conditional Boolean Error

**Error**:
```
Conditional result was derived from value of type 'list'
```

**Solution**:
- This was fixed in recent versions
- Update the role to use proper conditionals
- Check `when` clauses use `is defined and | length > 0`

## File Structure

```
roles/zsh/
├── defaults/
│   └── main.yaml              # Default variables
├── files/
│   ├── fonts/                 # MesloLGS Nerd Fonts
│   └── p10k_zsh               # P10k configuration file
├── tasks/
│   ├── main.yaml              # Entry point
│   ├── install-zsh.yaml       # ZSH installation
│   ├── install-oh-my-zsh.yaml # Oh-My-Zsh setup
│   ├── install-p10k.yaml      # Powerlevel10k installation
│   ├── install-p10k-fonts.yaml # Font installation
│   └── install-zsh-plugins.yaml # Plugin installation
├── templates/
│   └── zshrc.j2               # .zshrc template
└── README.md                  # This file
```

## Dependencies

None. This is a standalone role.

## Manual Operations

### Configure Powerlevel10k

Run the configuration wizard:
```bash
p10k configure
```

### Update Oh-My-Zsh

```bash
omz update
```

### List Installed Plugins

```bash
ls ~/.oh-my-zsh/custom/plugins/
```

### Test ZSH Configuration

```bash
# Check ZSH version
zsh --version

# Verify default shell
echo $SHELL

# Test .zshrc syntax
zsh -n ~/.zshrc

# Reload configuration
source ~/.zshrc
```

## Customization

### Change Theme

Edit `roles/zsh/defaults/main.yaml`:
```yaml
zsh_oh_my_zsh_theme: "agnoster"  # or any Oh-My-Zsh theme
```

Note: If using Powerlevel10k, this will be overridden.

### Add More Plugins

Edit `inventories/group_vars/all/vars.yaml`:
```yaml
zsh_plugins:
  - zsh-autosuggestions      # Command suggestions based on history
  - zsh-fast-syntax-highlighting  # Syntax highlighting
  - fzf-tab                  # Fuzzy finder for tab completion
  - zsh-completions          # Additional completion definitions
  - git                      # Git aliases (built-in Oh-My-Zsh)
  - docker                   # Docker aliases (built-in Oh-My-Zsh)
  - kubectl                  # Kubernetes aliases (built-in Oh-My-Zsh)
```

**Available Custom Plugins (installed by this role):**
- `zsh-autosuggestions` - Suggests commands as you type based on history and completion
- `zsh-fast-syntax-highlighting` - Highlights commands with colors as you type
- `fzf-tab` - Replaces tab completion with fuzzy finder (interactive search)
- `zsh-completions` - Additional completion definitions for 500+ commands

**Built-in Oh-My-Zsh Plugins:**
Oh-My-Zsh includes many built-in plugins. Just add their names to the list (e.g., `git`, `docker`, `kubectl`, `terraform`, etc.)

**Plugin Repository URLs:**
You can customize plugin sources by overriding these variables:
- `zsh_autosuggestions_repo_url`
- `zsh_fast_syntax_highlighting_repo_url`
- `zsh_fzf_tab_repo_url`
- `zsh_completions_repo_url`

### Customize P10k Configuration

1. Run `p10k configure` on target system
2. Copy generated `~/.p10k.zsh` to `roles/zsh/files/p10k_zsh`
3. Re-run the role to deploy to all users

### Per-User Configuration

```yaml
zsh_users:
  - username: dmac
    oh_my_zsh:
      write_zshrc: true
      theme: "powerlevel10k/powerlevel10k"
  - username: user2
    oh_my_zsh:
      write_zshrc: false  # User will manage their own .zshrc
```

## Terminal Configuration

### iTerm2 (macOS)

1. Install MesloLGS NF fonts (included in role)
2. iTerm2 → Preferences → Profiles → Text
3. Font: MesloLGS NF
4. Use ligatures: Yes

### VS Code Terminal

Add to settings.json:
```json
{
  "terminal.integrated.fontFamily": "MesloLGS NF",
  "terminal.integrated.fontSize": 14
}
```

### Windows Terminal

Add to settings.json:
```json
{
  "profiles": {
    "defaults": {
      "fontFace": "MesloLGS NF"
    }
  }
}
```

## Examples

### Basic Configuration

```yaml
zsh_users:
  - username: dmac
    oh_my_zsh:
      write_zshrc: true

zsh_plugins:
  - zsh-autosuggestions
  - zsh-fast-syntax-highlighting
  - fzf-tab
  - zsh-completions
```

### Advanced Configuration

```yaml
zsh_users:
  - username: admin
    oh_my_zsh:
      write_zshrc: true
  - username: developer
    oh_my_zsh:
      write_zshrc: true

zsh_plugins:
  - zsh-autosuggestions
  - zsh-fast-syntax-highlighting
  - fzf-tab
  - zsh-completions
  - git
  - docker
  - kubectl

zsh_oh_my_zsh_update_mode: auto
zsh_oh_my_zsh_update_frequency: 7
```

### Minimal Installation (No P10k)

To skip Powerlevel10k installation, use tags:
```bash
ansible-playbook playbooks/ubuntu.yml -K --tags zsh --skip-tags p10k
```

## Testing

Verify ZSH installation:
```bash
# Check ZSH is installed
ansible all -m command -a "zsh --version"

# Check default shell
ansible all -m command -a "getent passwd dmac | cut -d: -f7"

# Verify Oh-My-Zsh
ansible all -m stat -a "path=/home/dmac/.oh-my-zsh"

# Check P10k theme
ansible all -m stat -a "path=/home/dmac/.oh-my-zsh/custom/themes/powerlevel10k"
```

## Related Documentation

- [Oh-My-Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [ZSH Documentation](https://zsh.sourceforge.io/Doc/)
- [Configuration Guide](../../docs/configuration.md)
- [Development Guide](../../docs/development.md)
