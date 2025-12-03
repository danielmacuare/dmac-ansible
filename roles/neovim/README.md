# Neovim Role

Installs and configures Neovim text editor.

## What This Role Does

1. Installs Neovim package
2. Sets Neovim as default editor (optional)
3. Creates Neovim config directory for users
4. Deploys basic Neovim configuration (optional)

## Usage

### Basic Installation (Already in apt_packages)

Neovim is already included in your `apt_packages` list, so it will be installed automatically.

### Advanced Configuration

To use this role for custom Neovim setup, add to your playbook:

```yaml
roles:
  - {role: neovim, tags: ['neovim']}
```

### Variables

Add to `vars.yaml`:

```yaml
# Set Neovim as default editor
neovim_set_default_editor: true

# Deploy custom config
neovim_deploy_config: true

# Users to configure
neovim_users:
  - username: dmac
  - username: svmt
```

### Run

```bash
ansible-playbook playbooks/ubuntu.yml -K --tags neovim
```

## Customization

Edit `roles/neovim/templates/init.lua.j2` to customize the Neovim configuration.

## Note

If you just want Neovim installed without custom config, it might be better you add it into the ubuntu role using snap or apt packages.
