# Ubuntu Role

## Overview

The Ubuntu role provides base system configuration for Ubuntu servers, including:

- User and group management
- SSH key configuration and authorized_keys setup
- Sudo access configuration
- APT package installation
- Snap package installation
- Custom shell aliases and functions per user

This role is designed for Ubuntu 22.04.3+ and handles the foundational setup for new servers.

## What This Role Does

1. **User Management**: Creates system users with specified privileges
2. **SSH Configuration**: Sets up SSH keys and authorized_keys for secure access
3. **Sudo Access**: Configures sudo permissions for specified users
4. **Package Installation**: Installs APT and Snap packages
5. **Shell Customization**: Deploys user-specific aliases and functions

## Required Inputs

### 1. Variables File

**File**: `inventories/group_vars/all/vars.yaml`

Define users, packages, and configuration:

```yaml
users:
  - username: dmac                                    # System username
    sudo_access: true                                 # Grant sudo privileges
    ssh_access: true                                  # Allow SSH access
    ssh_pub_key: "{{ lookup('file', 'dmac.pub') }}"  # SSH public key (must match username)
    ssh_pass: "{{ vault_dmac_ssh_pass }}"            # Vault-encrypted password hash
    custom_alias_file: aliases_dmac.j2               # User-specific alias template
    custom_functions_file: functions_dmac.j2         # User-specific functions template

apt_packages:
  - name: git
    state: present
  - name: vim
    state: present
  - name: htop
    state: present

snap_packages:
  - name: btop
    classic: false
```

**Important**: SSH public key filenames must match usernames exactly (e.g., `dmac.pub` for user `dmac`).

### 2. SSH Public Keys

**Directory**: `roles/ubuntu/files/`

Add SSH public keys for each user:

```bash
cd roles/ubuntu/files/
echo "ssh-rsa AAAAB3NzaC1yc2E..." > dmac.pub
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5..." > user2.pub
```

**Naming Convention**: The filename must match the username defined in `vars.yaml`.

### 3. Vault Variables

**File**: `inventories/group_vars/all/vault.yaml` (encrypted)

Store password hashes and sensitive data:

```yaml
---
vault_dmac_ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."
vault_user2_ssh_pass: "$6$another_hash_here"
```

See [Password Generation Guide](../../docs/password-generation.md) for creating password hashes.

### 4. User Templates (Optional)

**Directory**: `roles/ubuntu/templates/`

Create custom aliases and functions for each user:

- `aliases_<username>.j2` - Shell aliases
- `functions_<username>.j2` - Shell functions

Example `aliases_dmac.j2`:
```bash
# Custom aliases for dmac
alias ll='ls -lah'
alias gs='git status'
alias gp='git pull'
```

Example `functions_dmac.j2`:
```bash
# Custom functions for dmac
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```

## Usage

Run the ubuntu role:

```bash
# Run full ubuntu role
ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu

# Check mode (dry run)
ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu --check

# Verbose output
ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu -vv
```

## Variables Reference

### Required Variables

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `users` | list | List of users to create | See vars.yaml example |
| `vault_<username>_ssh_pass` | string | Encrypted password hash | `$6$hash...` |

### Optional Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `apt_packages` | list | `[]` | APT packages to install |
| `snap_packages` | list | `[]` | Snap packages to install |

### User Object Structure

```yaml
username: string              # Required - system username
sudo_access: boolean          # Required - grant sudo privileges
ssh_access: boolean           # Required - allow SSH access
ssh_pub_key: string           # Required - SSH public key (file lookup)
ssh_pass: string              # Required - vault variable reference
custom_alias_file: string     # Optional - alias template filename
custom_functions_file: string # Optional - functions template filename
```

## Common Issues

### Issue: SSH Key File Not Found

**Error**:
```
ERROR! Could not find or access 'username.pub'
```

**Solution**:
- Ensure SSH public key file exists in `roles/ubuntu/files/`
- Verify filename matches username exactly (e.g., `dmac.pub` for user `dmac`)
- Check file permissions allow reading

### Issue: User Already Exists

**Error**:
```
FAILED! => {"msg": "useradd: user 'username' already exists"}
```

**Solution**:
- User already exists on target system
- The role uses `state: present` which is idempotent
- If you need to recreate the user, manually remove first: `userdel -r username`

### Issue: Vault Variable Not Defined

**Error**:
```
FAILED! => {"msg": "The task includes an option with an undefined variable"}
```

**Solution**:
- Check that vault variable exists in `vault.yaml`
- Verify variable naming: `vault_<username>_ssh_pass`
- Edit vault: `ansible-vault edit inventories/group_vars/all/vault.yaml`

### Issue: Password Hash Invalid

**Error**:
```
User password hash is invalid
```

**Solution**:
- Generate new password hash using mkpasswd or passlib
- Ensure hash is properly quoted in vault.yaml
- See [Password Generation Guide](../../docs/password-generation.md)

### Issue: Template File Not Found

**Error**:
```
Could not find or access 'aliases_username.j2'
```

**Solution**:
- Create template file in `roles/ubuntu/templates/`
- Or remove `custom_alias_file` from user definition in vars.yaml
- Template filename must match exactly

## File Structure

```
roles/ubuntu/
├── files/                      # Static files
│   ├── dmac.pub               # SSH public keys (one per user)
│   └── custom_scripts/        # Custom scripts
├── handlers/
│   └── main.yml               # Handler definitions
├── tasks/
│   ├── main.yaml              # Entry point
│   ├── users.yaml             # User creation and SSH setup
│   ├── apt_packages.yaml      # APT package installation
│   └── snap_packages.yaml     # Snap package installation
├── templates/
│   ├── aliases_<user>.j2      # User-specific aliases
│   ├── functions_<user>.j2    # User-specific functions
│   ├── sshd_config.j2         # SSH daemon configuration
│   └── sudoers.j2             # Sudo configuration
└── vars/
    └── main.yaml              # Role variables
```

## Dependencies

None. This is a standalone role.

## Testing

Test user creation:
```bash
# Check if user exists
ansible all -m command -a "id dmac"

# Check sudo access
ansible all -m command -a "sudo -l -U dmac" --become

# Test SSH access
ssh dmac@target-host
```

## Security Considerations

1. **Password Hashes**: Always use hashed passwords, never plaintext
2. **Vault Encryption**: Keep vault.yaml encrypted at all times
3. **SSH Keys**: Never commit private keys to the repository
4. **Sudo Access**: Only grant sudo to trusted users
5. **File Permissions**: SSH keys should be 600, public keys 644

## Examples

### Minimal User Configuration

```yaml
users:
  - username: john
    sudo_access: false
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'john.pub') }}"
    ssh_pass: "{{ vault_john_ssh_pass }}"
```

### User with Custom Shell Configuration

```yaml
users:
  - username: admin
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'admin.pub') }}"
    ssh_pass: "{{ vault_admin_ssh_pass }}"
    custom_alias_file: aliases_admin.j2
    custom_functions_file: functions_admin.j2
```

### Package Installation

```yaml
apt_packages:
  - name: git
    state: present
  - name: docker.io
    state: present
  - name: python3-pip
    state: present

snap_packages:
  - name: btop
    classic: false
  - name: kubectl
    classic: true
```

## Related Documentation

- [Configuration Guide](../../docs/configuration.md)
- [Password Generation](../../docs/password-generation.md)
- [Development Guide](../../docs/development.md)
