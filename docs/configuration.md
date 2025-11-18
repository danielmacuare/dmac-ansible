# Configuration Guide

## Initial Setup

### 1. Install Dependencies

Install uv package manager:
```bash
# See: https://docs.astral.sh/uv/getting-started/installation/
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Install Python dependencies:
```bash
uv sync
```

Install system dependencies:
```bash
sudo apt install sshpass
```

### 2. Configure Vault Password

Create a vault password file:
```bash
echo "your-vault-password" > ~/.vault_pass
chmod 600 ~/.vault_pass
```

This file is referenced in `ansible.cfg` and used to decrypt vault variables.

### 3. Update Inventory

Edit `inventories/inventory.ini` to define your target hosts:
```ini
[servers]
server01 ansible_host=192.168.1.10
server02 ansible_host=192.168.1.11

[all:vars]
ansible_user=your_user
ansible_python_interpreter=/usr/bin/python3
```

### 4. Configure Variables

Edit `inventories/group_vars/all/vars.yaml` to define your configuration:

```yaml
users:
  - username: dmac
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'dmac.pub') }}"
    ssh_pass: "{{ vault_dmac_ssh_pass }}"
    custom_alias_file: aliases_dmac.j2
    custom_functions_file: functions_dmac.j2

apt_packages:
  - name: git
    state: present
  - name: vim
    state: present

snap_packages:
  - name: btop
    classic: false
```

**Important**: SSH public key filenames must match usernames (e.g., `dmac.pub` for user `dmac`).

### 5. Add SSH Public Keys

Add SSH public keys to `roles/ubuntu/files/`:
```bash
cd roles/ubuntu/files/
echo "ssh-rsa AAAAB3NzaC1yc2E..." > dmac.pub
echo "ssh-rsa AAAAB3NzaC1yc2E..." > user2.pub
```

### 6. Configure Vault Variables

Find required vault variables:
```bash
grep -r "vault_" inventories/group_vars/all/vars.yaml
```

Create the vault file:
```bash
ansible-vault create inventories/group_vars/all/vault.yaml
```

Add vault variables (see [Password Generation](password-generation.md) for creating password hashes):
```yaml
---
vault_dmac_ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."
vault_zerotier_api_token: "your-zerotier-api-token"
```

### 7. Verify Configuration

Test connectivity:
```bash
ansible all -m ping
```

Check playbook syntax:
```bash
ansible-playbook playbooks/ubuntu.yml --syntax-check
```

Run in check mode (dry run):
```bash
ansible-playbook playbooks/ubuntu.yml -K --check
```

## Role-Specific Configuration

### Ubuntu Role

Configures base Ubuntu system with users, groups, and packages.

Variables in `vars.yaml`:
- `users`: List of users to create
- `apt_packages`: APT packages to install
- `snap_packages`: Snap packages to install

### ZeroTier Role

Sets up ZeroTier VPN networking.

Variables in `vars.yaml`:
```yaml
zerotier_network_id: "your-network-id"
zerotier_api_token: "{{ vault_zerotier_api_token }}"
```

### ZSH Role

Installs and configures ZSH with Oh-My-Zsh and Powerlevel10k theme.

No additional configuration required - uses sensible defaults.

## Troubleshooting

### Vault Decryption Failed

Ensure `~/.vault_pass` exists and contains the correct password:
```bash
ansible-vault view inventories/group_vars/all/vault.yaml
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
ansible-vault view inventories/group_vars/all/vault.yaml
```

For more troubleshooting, see the steering files in `.kiro/steering/troubleshooting.md`.
