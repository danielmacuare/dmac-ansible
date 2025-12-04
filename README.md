# Ansible Infrastructure Automation

Personal Ansible automation repository for storing different kinds of automation workflows.

## Features
- Ubuntu Playbook
    - User and group management with SSH key configuration
    - System package installation (apt and snap)
    - ZeroTier VPN network setup and authorization
    - ZSH shell with Oh-My-Zsh and Powerlevel10k theme
    - Neovim with full plugin support (LSP, Mason, lazy.nvim)
    - Docker CE installation and configuration

## Requirements

- Python 3.12+
- [UV package manager](https://docs.astral.sh/uv/getting-started/installation/)
- git client

## Quick Start

See the [Configuration Guide](docs/configuration.md) for complete setup instructions.

```bash

# Clone this repo
git clone https://github.com/danielmacuare/dmac-ansible.git
cd dmac-ansible

# Install dependencies
uv sync
uv run ansible-galaxy install -r requirements.yml -p ./roles

# Configure inventory and variables
vim inventories/inventory.ini
vim inventories/group_vars/all/vars.yaml

# Run playbook
uv run ansible-playbook playbooks/ubuntu.yml -K

# Run specific roles
uv run ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zerotier
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zsh
uv run ansible-playbook playbooks/ubuntu.yml -K --tags neovim
uv run ansible-playbook playbooks/ubuntu.yml -K --tags docker
```

## Roles

This repository uses **modular, reusable roles** that can be combined in different playbooks based on your needs.

### Design Philosophy

Each role is self-contained and can be used independently or combined with others. This allows you to:
- Mix and match roles for different server types
- Maintain consistent configuration across environments
- Reuse roles across multiple playbooks

### Role Overview

![Roles Description](docs/media/roles-description.png)

#### Custom Roles
- **[ubuntu](roles/ubuntu/README.md)** - User and group management, SSH keys, APT/Snap packages
- **[zerotier](roles/zerotier/README.md)** - ZeroTier VPN network setup and authorization
- **[zsh](roles/zsh/README.md)** - ZSH shell with Oh-My-Zsh and Powerlevel10k theme
- **[neovim](roles/neovim/README.md)** - Neovim with LSP, Mason, and full plugin support using Lazy.

#### External Roles
- **[geerlingguy.docker](docs/docker-role.md)** - Docker CE installation and configuration

### Example Playbook Combinations

**Web Server:**
```yaml
- name: Configure Web Server
  hosts: webservers
  roles:
    - {role: ubuntu, tags: ['ubuntu']}
    - {role: zsh, tags: ['zsh']}
    - {role: geerlingguy.docker, tags: ['docker']}
```

**Development Machine:**
```yaml
- name: Configure Dev Environment
  hosts: dev_machines
  roles:
    - {role: ubuntu, tags: ['ubuntu']}
    - {role: zerotier, tags: ['zerotier']}
    - {role: zsh, tags: ['zsh']}
    - {role: neovim, tags: ['neovim']}
```

**Minimal Server:**
```yaml
- name: Configure Minimal Server
  hosts: minimal_servers
  roles:
    - {role: ubuntu, tags: ['ubuntu']}
```

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


## License

Personal project - use at your own risk.
