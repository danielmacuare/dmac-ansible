# Ansible Infrastructure Automation

Personal Ansible automation repository for Storing different kinds of playbooks.

## Features
- Ubuntu Playbook
    - User and group management with SSH key configuration
    - System package installation (apt and snap)
    - ZeroTier VPN network setup and authorization
    - ZSH shell with Oh-My-Zsh and Powerlevel10k theme
    - Neovim with full plugin support (LSP, Mason, lazy.nvim)
    - Docker CE installation and configuration

## Quick Start

See the [Configuration Guide](docs/configuration.md) for complete setup instructions.

```bash
# Install dependencies
uv sync
uv run ansible-galaxy install -r requirements.yml -p ./roles

# Configure inventory and variables
vim inventories/inventory.ini
vim inventories/group_vars/all/vars.yaml

# Run playbook
uv run ansible-playbook playbooks/ubuntu.yml -K
```

## Roles

### Custom Roles
- **[ubuntu](roles/ubuntu/README.md)** - User and group management, SSH keys, APT/Snap packages
- **[zerotier](roles/zerotier/README.md)** - ZeroTier VPN network setup and authorization
- **[zsh](roles/zsh/README.md)** - ZSH shell with Oh-My-Zsh and Powerlevel10k theme
- **[neovim](roles/neovim/README.md)** - Neovim with LSP, Mason, and full plugin support using Lazy.

### External Roles
- **[geerlingguy.docker](docs/docker-role.md)** - Docker CE installation and configuration

## Documentation

- **[Configuration Guide](docs/configuration.md)** - Complete setup and configuration instructions
- **[Password Generation](docs/password-generation.md)** - Generate user password hashes
- **[Development Guide](docs/development.md)** - Contributing and development workflow
- **[Docker Role Guide](docs/docker-role.md)** - Docker installation and configuration
- **[Neovim Role Guide](roles/neovim/README.md)** - Neovim installation and configuration

## Project Structure

```
.
├── inventories/              # Ansible inventory and variables
│   ├── inventory.ini        # Host definitions
│   └── group_vars/all/      # Group variables
├── playbooks/               # Ansible playbooks
├── roles/                   # Ansible roles (see role READMEs for details)
│   ├── ubuntu/             # Base system configuration
│   ├── zerotier/           # VPN networking
│   ├── zsh/                # Shell configuration
│   └── neovim/             # Neovim editor with plugins
└── ansible.cfg             # Ansible configuration
```

## Requirements

- Python 3.12+
- Ansible 12.2.0+
- uv package manager
- Target systems: Ubuntu 22.04+

## License

Personal project - use at your own risk.
