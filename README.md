# Ansible Infrastructure Automation

Personal Ansible automation repository for managing Ubuntu server configurations.

## Roles

This repository includes three main roles:

- **[ubuntu](roles/ubuntu/README.md)** - User and group management, SSH keys, APT/Snap packages
- **[zerotier](roles/zerotier/README.md)** - ZeroTier VPN network setup and authorization
- **[zsh](roles/zsh/README.md)** - ZSH shell with Oh-My-Zsh and Powerlevel10k theme

See each role's README for detailed documentation.

## Quick Start

### Prerequisites

1. Install [uv](https://docs.astral.sh/uv/getting-started/installation/)
2. Install dependencies:
   ```bash
   uv sync
   ```
3. Install sshpass (for SSH password authentication):
   ```bash
   sudo apt install sshpass
   ```
4. Create vault password file at `~/.vault_pass`

### Configuration

1. Update inventory: `inventories/inventory.ini`
2. Configure variables: `inventories/group_vars/all/vars.yaml`
3. Add SSH public keys to: `roles/ubuntu/files/`
4. Create encrypted vault: `inventories/group_vars/all/vault.yaml`

See [Configuration Guide](docs/configuration.md) for detailed setup instructions.

### Usage

Run the full playbook:
```bash
ansible-playbook playbooks/ubuntu.yml -K
```

Run specific roles using tags:
```bash
ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu
ansible-playbook playbooks/ubuntu.yml -K --tags zerotier
ansible-playbook playbooks/ubuntu.yml -K --tags zsh
```

## Documentation

### General Documentation
- [Configuration Guide](docs/configuration.md) - Initial setup and configuration
- [Password Generation](docs/password-generation.md) - Generate user password hashes
- [Development Guide](docs/development.md) - Contributing and development workflow

### Role Documentation
- [Ubuntu Role](roles/ubuntu/README.md) - User management, SSH, and packages
- [ZeroTier Role](roles/zerotier/README.md) - VPN network configuration
- [ZSH Role](roles/zsh/README.md) - Shell configuration and theming

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
│   └── zsh/                # Shell configuration
└── ansible.cfg             # Ansible configuration
```

## Requirements

- Python 3.12+
- Ansible 12.2.0+
- uv package manager
- Target systems: Ubuntu 22.04.3+

## License

Personal project - use at your own risk.
