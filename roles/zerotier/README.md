# ZeroTier Role

## Overview

The ZeroTier role installs and configures ZeroTier One VPN client on Ubuntu servers, enabling secure peer-to-peer networking across distributed systems.

This role:
- Installs ZeroTier One client
- Joins specified ZeroTier networks
- Automatically authorizes nodes (optional)
- Configures the service to survive restarts

## What This Role Does

1. **Installation**: Installs ZeroTier One from official repository
2. **Service Configuration**: Enables and starts zerotier-one service
3. **Network Joining**: Joins specified ZeroTier network(s)
4. **Node Authorization**: Automatically authorizes the node on the network (if API token provided)
5. **Fact Collection**: Stores ZeroTier node ID in Ansible facts for reference

## Required Inputs

### 1. Variables File

**File**: `inventories/group_vars/all/vars.yaml`

Define ZeroTier network configuration:

```yaml
zerotier_network_id: "a1b2c3d4e5f6g7h8"           # Your ZeroTier network ID
zerotier_api_accesstoken: "{{ vault_zerotier_api_token }}"  # API token from vault
```

### 2. Vault Variables

**File**: `inventories/group_vars/all/vault.yaml` (encrypted)

Store your ZeroTier API token:

```yaml
---
vault_zerotier_api_token: "your-zerotier-api-token-here"
```

**Getting Your API Token**:
1. Log in to [ZeroTier Central](https://my.zerotier.com/)
2. Go to Account settings
3. Generate a new API token
4. Copy the token and add it to vault.yaml

**Getting Your Network ID**:
1. Log in to [ZeroTier Central](https://my.zerotier.com/)
2. Select or create a network
3. Copy the 16-character network ID (e.g., `a1b2c3d4e5f6g7h8`)

### 3. Edit Vault File

```bash
# Create or edit vault file
ansible-vault edit inventories/group_vars/all/vault.yaml

# Add the API token
vault_zerotier_api_token: "your-token-here"
```

## Usage

Run the zerotier role:

```bash
# Run full zerotier role
ansible-playbook playbooks/ubuntu.yml -K --tags zerotier

# Check mode (dry run)
ansible-playbook playbooks/ubuntu.yml -K --tags zerotier --check

# Verbose output
ansible-playbook playbooks/ubuntu.yml -K --tags zerotier -vv
```

## Variables Reference

### Required Variables

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `zerotier_network_id` | string | ZeroTier network ID to join | `a1b2c3d4e5f6g7h8` |
| `zerotier_api_accesstoken` | string | API token for authorization | `{{ vault_zerotier_api_token }}` |

### Optional Variables (Defaults)

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `zerotier_api_url` | string | `https://api.zerotier.com/api/v1/` | ZeroTier API endpoint |
| `zerotier_api_delegate` | string | `localhost` | Where to run API calls |
| `zerotier_authorize_member` | boolean | `true` | Auto-authorize node on network |

### Default Values

Defined in `roles/zerotier/defaults/main.yaml`:

```yaml
zerotier_api_url: "https://api.zerotier.com/api/v1/"
zerotier_api_delegate: localhost
zerotier_authorize_member: true
```

## How It Works

### Installation Process

1. Adds ZeroTier GPG key and repository
2. Installs zerotier-one package
3. Enables and starts the service
4. Collects node ID and stores in Ansible facts

### Authorization Process

If `zerotier_api_accesstoken` is provided:

1. Retrieves the node's ZeroTier member ID
2. Makes API call to ZeroTier Central
3. Authorizes the node on the specified network
4. Node becomes active and can communicate

### Network Joining

1. Uses `zerotier-cli` to join the network
2. Verifies the join was successful
3. Node appears in ZeroTier Central dashboard

## Common Issues

### Issue: ZeroTier Service Not Starting

**Error**:
```
FAILED! => {"msg": "Service zerotier-one could not be started"}
```

**Solution**:
- Check if service is installed: `systemctl status zerotier-one`
- View service logs: `journalctl -u zerotier-one`
- Restart service manually: `sudo systemctl restart zerotier-one`
- Verify internet connectivity on target host

### Issue: Network Join Failed

**Error**:
```
FAILED! => {"msg": "Failed to join ZeroTier network"}
```

**Solution**:
- Verify network ID is correct (16 characters)
- Check ZeroTier service is running: `systemctl status zerotier-one`
- Test manually: `sudo zerotier-cli join <network_id>`
- Check network exists in ZeroTier Central
- Ensure target host has internet access

### Issue: Node Authorization Failed

**Error**:
```
FAILED! => {"msg": "Failed to authorize node"}
```

**Solution**:
- Verify API token is correct in vault.yaml
- Check API token has authorization permissions
- Test API token: `curl -H "Authorization: bearer <token>" https://api.zerotier.com/api/v1/status`
- Manually authorize via ZeroTier Central web interface
- Check member ID is correctly retrieved from facts

### Issue: API Token Not Found

**Error**:
```
FAILED! => {"msg": "The task includes an option with an undefined variable"}
```

**Solution**:
- Ensure `vault_zerotier_api_token` is defined in vault.yaml
- Edit vault: `ansible-vault edit inventories/group_vars/all/vault.yaml`
- Verify variable name matches: `vault_zerotier_api_token`

### Issue: Node Not Appearing in Network

**Symptoms**:
- Node joins successfully but doesn't appear in ZeroTier Central
- No connectivity between nodes

**Solution**:
- Wait a few minutes for synchronization
- Check node status: `sudo zerotier-cli listnetworks`
- Verify node ID: `sudo zerotier-cli info`
- Check if node needs manual authorization in ZeroTier Central
- Ensure network is not set to private without authorization

## File Structure

```
roles/zerotier/
├── defaults/
│   └── main.yaml              # Default variables
├── files/
│   └── set_facts.sh           # Script to collect ZeroTier facts
├── tasks/
│   ├── main.yaml              # Entry point
│   ├── install.yaml           # Installation tasks
│   ├── join_network.yaml      # Network joining tasks
│   └── authorize_node.yaml    # Node authorization tasks
└── README.md                  # This file
```

## Dependencies

None. This is a standalone role.

## Manual Operations

### Check ZeroTier Status

```bash
# Check service status
sudo systemctl status zerotier-one

# Get node ID
sudo zerotier-cli info

# List joined networks
sudo zerotier-cli listnetworks

# Join network manually
sudo zerotier-cli join <network_id>

# Leave network
sudo zerotier-cli leave <network_id>
```

### View Logs

```bash
# Service logs
sudo journalctl -u zerotier-one -f

# Recent logs
sudo journalctl -u zerotier-one --since "10 minutes ago"
```

### Troubleshooting Commands

```bash
# Test connectivity to ZeroTier
ping my.zerotier.com

# Check if node is authorized
sudo zerotier-cli listnetworks | grep OK

# Restart service
sudo systemctl restart zerotier-one
```

## Security Considerations

1. **API Token**: Keep API token encrypted in vault.yaml
2. **Network Access**: Only join trusted ZeroTier networks
3. **Authorization**: Review and authorize nodes in ZeroTier Central
4. **Firewall**: ZeroTier uses UDP port 9993
5. **Private Networks**: Use private networks for sensitive environments

## Examples

### Basic Configuration

```yaml
# vars.yaml
zerotier_network_id: "a1b2c3d4e5f6g7h8"
zerotier_api_accesstoken: "{{ vault_zerotier_api_token }}"

# vault.yaml
vault_zerotier_api_token: "your-api-token"
```

### Multiple Networks

To join multiple networks, run the role multiple times with different network IDs, or modify the role to accept a list of networks.

### Manual Authorization Only

If you prefer to manually authorize nodes:

```yaml
zerotier_authorize_member: false
zerotier_api_accesstoken: ""  # Leave empty
```

Then manually authorize nodes in ZeroTier Central dashboard.

## Testing

Verify ZeroTier installation:

```bash
# Check service is running
ansible all -m command -a "systemctl is-active zerotier-one"

# Get node ID
ansible all -m command -a "zerotier-cli info" --become

# List networks
ansible all -m command -a "zerotier-cli listnetworks" --become

# Test connectivity between nodes
ansible all -m ping -a "zerotier_ip_address"
```

## Related Documentation

- [ZeroTier Documentation](https://docs.zerotier.com/)
- [ZeroTier Central](https://my.zerotier.com/)
- [Configuration Guide](../../docs/configuration.md)
