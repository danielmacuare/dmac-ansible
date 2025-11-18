# Ansible Infrastructure Automation

Personal Ansible automation repository for managing Ubuntu server configurations.

## Features

- User and group management with SSH key configuration
- System package installation (apt and snap)
- ZeroTier VPN network setup and authorization
- ZSH shell configuration with Oh-My-Zsh and Powerlevel10k theme

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

- [Configuration Guide](docs/configuration.md) - Detailed setup and configuration
- [Password Generation](docs/password-generation.md) - Generate user password hashes
- [Development Guide](docs/development.md) - Contributing and development workflow

## Project Structure

```
.
├── inventories/              # Ansible inventory and variables
│   ├── inventory.ini        # Host definitions
│   └── group_vars/all/      # Group variables
├── playbooks/               # Ansible playbooks
├── roles/                   # Ansible roles
│   ├── ubuntu/             # Base Ubuntu configuration
│   ├── zerotier/           # ZeroTier VPN setup
│   └── zsh/                # ZSH shell configuration
└── ansible.cfg             # Ansible configuration
```

## Requirements

- Python 3.12+
- Ansible 12.2.0+
- uv package manager
- Target systems: Ubuntu 22.04.3+

## License

Personal project - use at your own risk.
