# Development Guide

## Development Environment Setup

### 1. Install Tools

Install uv:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Install dependencies:
```bash
uv sync
```

Activate virtual environment:
```bash
source .venv/bin/activate
```

### 2. Install Pre-commit Hooks

Install pre-commit hooks:
```bash
pre-commit install
```

Run hooks manually:
```bash
pre-commit run --all-files
```

## Code Quality

### Linting

Run ansible-lint:
```bash
ansible-lint
```

Check specific files:
```bash
ansible-lint playbooks/ubuntu.yml
ansible-lint roles/ubuntu/
```

### Syntax Checking

Check playbook syntax:
```bash
ansible-playbook playbooks/ubuntu.yml --syntax-check
```

### Testing

Test in check mode (dry run):
```bash
ansible-playbook playbooks/ubuntu.yml -K --check
```

Test specific roles:
```bash
ansible-playbook playbooks/ubuntu.yml -K --tags ubuntu --check
```

Test connectivity:
```bash
ansible all -m ping
```

## Development Workflow

### Adding a New Role

1. Create role directory structure:
```bash
mkdir -p roles/newrole/{defaults,files,handlers,tasks,templates,vars}
```

2. Create main task file:
```bash
cat > roles/newrole/tasks/main.yaml << 'EOF'
---
- name: "newrole | Example task"
  ansible.builtin.debug:
    msg: "Hello from newrole"
EOF
```

3. Add role to playbook:
```yaml
# playbooks/ubuntu.yml
- name: Configure servers
  hosts: all
  gather_facts: true
  roles:
    - {role: ubuntu, tags: ['ubuntu']}
    - {role: newrole, tags: ['newrole']}
```

4. Test the role:
```bash
ansible-playbook playbooks/ubuntu.yml -K --tags newrole --check
```

### Adding a New User

For detailed instructions on adding users, see the [Ubuntu Role - Adding New Users](../roles/ubuntu/README.md#examples) documentation.

Quick steps:
1. Generate SSH key pair
2. Add public key to `roles/ubuntu/files/`
3. Generate password hash (see [Password Generation](password-generation.md))
4. Add user to `vars.yaml`
5. Add password hash to `vault.yaml`
6. Create user-specific templates (optional)

### Modifying Variables

1. Edit vars.yaml for plain variables:
```bash
vim inventories/group_vars/all/vars.yaml
```

2. Edit vault.yaml for sensitive data:
```bash
ansible-vault edit inventories/group_vars/all/vault.yaml
```

3. Test changes:
```bash
ansible-playbook playbooks/ubuntu.yml -K --check
```

## Naming Conventions

### Files
- YAML files: Use `.yaml` extension (not `.yml`)
- Task files: Lowercase with underscores (e.g., `apt_packages.yaml`)
- Template files: Use `.j2` extension for Jinja2 templates
- SSH public keys: Match username (e.g., `dmac.pub` for user `dmac`)

### Variables
- Use snake_case: `^[a-z_][a-z0-9_]*$`
- Vault variables: Prefix with `vault_` (e.g., `vault_dmac_ssh_pass`)
- Role-specific variables: Use role name as prefix (e.g., `zerotier_network_id`)

### Tasks
- Task names: Use prefix pattern `{role_name} | {description}`
- Example: `"ubuntu | Install packages"`
- Include tasks conditionally: `when: "variable is defined"`

## Debugging

### Verbose Output

Run with increased verbosity:
```bash
# Basic verbose
ansible-playbook playbooks/ubuntu.yml -K -v

# More verbose (shows task results)
ansible-playbook playbooks/ubuntu.yml -K -vv

# Very verbose (shows connection debugging)
ansible-playbook playbooks/ubuntu.yml -K -vvv
```

### Debug Variables

Add debug tasks:
```yaml
- name: Debug | Show variable value
  ansible.builtin.debug:
    var: variable_name
```

### Limit to Specific Hosts

Test on single host:
```bash
ansible-playbook playbooks/ubuntu.yml -K --limit server01
```

## Git Workflow

1. Make changes
2. Run linting:
```bash
ansible-lint
pre-commit run --all-files
```

3. Test changes:
```bash
ansible-playbook playbooks/ubuntu.yml -K --check
```

4. Commit (pre-commit hooks will run automatically):
```bash
git add .
git commit -m "Description of changes"
```

5. Push:
```bash
git push
```

## Common Issues

### Pre-commit Hooks Failing

Run manually to see errors:
```bash
pre-commit run --all-files
```

Fix issues and try again.

### Ansible-lint Errors

Check `.ansible-lint` for skipped rules. Add `# noqa` comments sparingly for legitimate exceptions:
```yaml
- name: ubuntu | Special task  # noqa: rule-name
  ansible.builtin.command: some-command
```

### Vault Decryption Issues

Verify vault password:
```bash
ansible-vault view inventories/group_vars/all/vault.yaml
```

Check ansible.cfg points to correct vault password file.

## Resources

### External Documentation
- [Ansible Documentation](https://docs.ansible.com/)
- [ansible-lint Rules](https://ansible.readthedocs.io/projects/lint/rules/)
- [Jinja2 Templates](https://jinja.palletsprojects.com/)
- [uv Documentation](https://docs.astral.sh/uv/)

### Role Documentation
- [Ubuntu Role](../roles/ubuntu/README.md)
- [ZeroTier Role](../roles/zerotier/README.md)
- [ZSH Role](../roles/zsh/README.md)
