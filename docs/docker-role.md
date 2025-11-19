# Docker Role (geerlingguy.docker)

## Overview

This role installs and configures Docker CE (Community Edition) on Ubuntu servers. It's a third-party role from Ansible Galaxy maintained by Jeff Geerling.

**Note**: This is an external role, not maintained as part of this repository. The role is installed via `ansible-galaxy` and not committed to the repository.

## Installation

This role must be installed from Ansible Galaxy before use:

```bash
ansible-galaxy install -r requirements.yml -p ./roles
```

This command:
- Reads `requirements.yml` to find required roles
- Installs them to the `./roles` directory
- Ensures the correct version (7.8.0) is installed

## What This Role Does

1. **Docker Installation**: Installs Docker CE from official Docker repository
2. **Service Configuration**: Enables and starts Docker daemon
3. **User Management**: Adds specified users to the docker group
4. **Docker Compose**: Optionally installs Docker Compose
5. **Python SDK**: Installs Docker Python SDK for Ansible docker modules

## Required Inputs

### 1. Variables File

**File**: `inventories/group_vars/all/vars.yaml`

Define Docker configuration:

```yaml
# Docker users (users who can run docker without sudo)
docker_users:
  - dmac
  - user2

# Docker Compose installation
docker_install_compose: true
docker_compose_version: "2.24.5"

# Docker package state
docker_package_state: present

# Docker service state
docker_service_state: started
docker_service_enabled: true
```

### 2. No Vault Variables Required

This role doesn't require any vault variables.

## Usage

Run the docker role:

```bash
# Install role first (if not already installed)
ansible-galaxy install -r requirements.yml -p ./roles

# Run docker role
ansible-playbook playbooks/ubuntu.yml -K --tags docker

# Check mode (dry run)
ansible-playbook playbooks/ubuntu.yml -K --tags docker --check
```

## Variables Reference

### Common Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `docker_users` | list | `[]` | Users to add to docker group |
| `docker_install_compose` | boolean | `true` | Install Docker Compose |
| `docker_compose_version` | string | `2.24.5` | Docker Compose version |
| `docker_package_state` | string | `present` | Docker package state (present/latest) |
| `docker_service_state` | string | `started` | Docker service state |
| `docker_service_enabled` | boolean | `true` | Enable Docker on boot |

### Advanced Variables

For a complete list of variables, see the [official role documentation](https://github.com/geerlingguy/ansible-role-docker).

## Common Issues

### Issue: Permission Denied Running Docker

**Symptoms**:
- User cannot run docker commands without sudo
- Error: `permission denied while trying to connect to the Docker daemon socket`

**Solution**:
- Ensure user is in `docker_users` list
- Log out and log back in for group membership to take effect
- Verify: `groups` should show `docker`
- Or run: `newgrp docker` to activate group without logout

### Issue: Docker Service Not Starting

**Error**:
```
Failed to start docker.service
```

**Solution**:
- Check service status: `systemctl status docker`
- View logs: `journalctl -u docker -n 50`
- Verify Docker is installed: `docker --version`
- Restart service: `sudo systemctl restart docker`

### Issue: Role Not Found

**Error**:
```
ERROR! the role 'geerlingguy.docker' was not found
```

**Solution**:
- Install the role: `ansible-galaxy install -r requirements.yml -p ./roles`
- Verify installation: `ls roles/geerlingguy.docker`
- Check requirements.yml exists and is correct

### Issue: Docker Compose Not Found

**Symptoms**:
- `docker compose` command not available
- Error: `docker: 'compose' is not a docker command`

**Solution**:
- Ensure `docker_install_compose: true` in vars.yaml
- Check Docker Compose version is valid
- Verify installation: `docker compose version`
- May need to use `docker-compose` (with hyphen) for older versions

## Manual Operations

### Check Docker Status

```bash
# Check Docker version
docker --version

# Check Docker service
sudo systemctl status docker

# Check Docker info
docker info

# List running containers
docker ps

# List all containers
docker ps -a
```

### Manage Docker Service

```bash
# Start Docker
sudo systemctl start docker

# Stop Docker
sudo systemctl stop docker

# Restart Docker
sudo systemctl restart docker

# Enable on boot
sudo systemctl enable docker
```

### User Management

```bash
# Add user to docker group manually
sudo usermod -aG docker username

# Verify group membership
groups username

# Activate group without logout
newgrp docker
```

## Testing

Verify Docker installation:

```bash
# Check Docker is installed
ansible all -m command -a "docker --version"

# Check Docker service is running
ansible all -m service -a "name=docker state=started" --become

# Check user is in docker group
ansible all -m command -a "groups dmac"

# Test Docker functionality
ansible all -m command -a "docker run hello-world" -u dmac
```

## Examples

### Basic Configuration

```yaml
docker_users:
  - dmac

docker_install_compose: true
```

### Advanced Configuration

```yaml
docker_users:
  - dmac
  - developer
  - admin

docker_install_compose: true
docker_compose_version: "2.24.5"

docker_package_state: latest  # Always update to latest

# Docker daemon options
docker_daemon_options:
  log-driver: "json-file"
  log-opts:
    max-size: "10m"
    max-file: "3"
```

### Production Configuration

```yaml
docker_users:
  - deploy

docker_install_compose: true
docker_service_state: started
docker_service_enabled: true

# Use specific version for stability
docker_package_state: present

# Configure logging
docker_daemon_options:
  log-driver: "json-file"
  log-opts:
    max-size: "100m"
    max-file: "5"
  storage-driver: "overlay2"
```

## Security Considerations

1. **Docker Group**: Users in the docker group have root-equivalent privileges
2. **Trusted Users**: Only add trusted users to `docker_users`
3. **Container Security**: Use official images and scan for vulnerabilities
4. **Network Security**: Configure Docker networks appropriately
5. **Resource Limits**: Set container resource limits in production

## Updating the Role

To update to a newer version:

1. Update version in `requirements.yml`:
```yaml
roles:
  - name: geerlingguy.docker
    version: 7.9.0  # New version
```

2. Reinstall the role:
```bash
ansible-galaxy install -r requirements.yml -p ./roles --force
```

## Related Documentation

- [Official Role Repository](https://github.com/geerlingguy/ansible-role-docker)
- [Ansible Galaxy Page](https://galaxy.ansible.com/ui/standalone/roles/geerlingguy/docker/)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Configuration Guide](configuration.md)
