# Configuration Guide

Complete setup and configuration instructions for the Ansible infrastructure automation repository.

## Prerequisites

- Python 3.12+
- [uv](https://docs.astral.sh/uv/getting-started/installation/) package manager
- Target systems: Ubuntu 22.04+

## Initial Setup

### 1. Clone Repository

```bash
git clone https://github.com/danielmacuare/dmac-ansible.git
cd dmac-ansible
```

### 2. Install Dependencies

Install uv package manager:
```bash
# See: https://docs.astral.sh/uv/getting-started/installation/
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Install Python dependencies:
```bash
uv sync
```

Install Ansible Galaxy roles:
```bash
uv run ansible-galaxy install -r requirements.yml -p ./roles
```

This installs external roles like `geerlingguy.docker` to the `./roles` directory.

Install system dependencies (optional - only needed for SSH password authentication):
```bash
sudo apt install sshpass
```

**Note:** `sshpass` is only required if you need to use password-based SSH authentication. If you're using SSH keys exclusively, you can skip this step.

### 3. Configure Vault Password

Create a vault password file at `~/.vault_pass`:
```bash
touch ~/.vault_pass
chmod 600 ~/.vault_pass
```

Edit the file and add your vault password (plain text):
```bash
vim ~/.vault_pass
```

This file is referenced in `ansible.cfg` and used to encrypt/decrypt vault variables.

### 4. Update Inventory

Edit `inventories/inventory.ini` to define your target hosts:
```ini
[servers]
server01 ansible_host=192.168.1.10
server02 ansible_host=192.168.1.11

[all:vars]
ansible_user=your_user
ansible_python_interpreter=/usr/bin/python3
```

### 5. Configure Variables

Edit `inventories/group_vars/all/vars.yaml` to define your configuration.

For detailed variable configuration for each role, see:
- [Ubuntu Role - Required Inputs](../roles/ubuntu/README.md#required-inputs)
- [ZeroTier Role - Required Inputs](../roles/zerotier/README.md#required-inputs)
- [ZSH Role - Required Inputs](../roles/zsh/README.md#required-inputs)

Basic example:
```yaml
# Users (see Ubuntu role docs for full details)
users:
  - username: dmac
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'dmac.pub') }}"
    ssh_pass: "{{ vault_dmac_ssh_pass }}"

# Packages (see Ubuntu role docs)
apt_packages:
  - name: git
    state: present

# ZeroTier (see ZeroTier role docs)
zerotier_network_id: "your-network-id"
zerotier_api_accesstoken: "{{ vault_zerotier_api_token }}"

# ZSH users (see ZSH role docs)
zsh_users:
  - username: dmac
    oh_my_zsh:
      write_zshrc: true
```

### 6. Add SSH Public Keys

Add SSH public keys to `roles/ubuntu/files/`. See [Ubuntu Role - SSH Keys](../roles/ubuntu/README.md#2-ssh-public-keys) for details.

```bash
cd roles/ubuntu/files/
echo "ssh-rsa AAAAB3NzaC1yc2E..." > dmac.pub
```

### 7. Configure Vault Variables

Copy the example vault file:
```bash
cd inventories/group_vars/all/
cp example.vault.yaml vault.yaml
```

Edit and add your vault variables:
```bash
vim vault.yaml
```

See [Password Generation Guide](password-generation.md) for creating password hashes for users.

Example vault variables:
```yaml
---
vault_dmac_ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."
vault_zerotier_api_token: "your-zerotier-api-token"
```

Encrypt the vault file:
```bash
uv run ansible-vault encrypt vault.yaml --vault-password-file ~/.vault_pass
```

Find required vault variables by searching your vars.yaml:
```bash
grep -r "vault_" inventories/group_vars/all/vars.yaml
```

### 8. Verify Configuration

Test connectivity:
```bash
uv run ansible all -m ping
```

Check playbook syntax:
```bash
uv run ansible-playbook playbooks/ubuntu.yml --syntax-check
```

Run in check mode (dry run):
```bash
uv run ansible-playbook playbooks/ubuntu.yml -K --check
```

## Usage

Run the full playbook:
```bash
uv run ansible-playbook playbooks/ubuntu.yml -K
```

Run specific roles using tags:
```bash
uv run ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zerotier
uv run ansible-playbook playbooks/ubuntu.yml -K --tags zsh
uv run ansible-playbook playbooks/ubuntu.yml -K --tags docker
```

The `-K` flag prompts for the sudo password on target hosts.

## Role-Specific Configuration

For detailed configuration instructions for each role, see:

### Custom Roles
- **[Ubuntu Role Documentation](../roles/ubuntu/README.md)** - User management, SSH keys, and package installation
- **[ZeroTier Role Documentation](../roles/zerotier/README.md)** - VPN network setup and authorization
- **[ZSH Role Documentation](../roles/zsh/README.md)** - Shell configuration with Oh-My-Zsh and Powerlevel10k

### External Roles
- **[Docker Role Documentation](docker-role.md)** - Docker CE installation and configuration

Each role README contains:
- Required variables and configuration
- File locations and naming conventions
- Common issues and troubleshooting
- Usage examples

## Troubleshooting

### Vault Decryption Failed

Ensure `~/.vault_pass` exists and contains the correct password:
```bash
uv ansible-vault view inventories/group_vars/all/vault.yaml
```

### SSH Connection Issues

Load SSH keys before running playbooks:
```bash
ssh-add ~/.ssh/your_key
```

Test manual SSH connection:
```bash
ssh your_host
```

### Variable Not Defined

Check that all `vault_` variables referenced in `vars.yaml` are defined in `vault.yaml`:
```bash
grep -r "vault_" inventories/group_vars/all/vars.yaml
uv ansible-vault view inventories/group_vars/all/vault.yaml
```