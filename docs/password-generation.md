# Password Generation Guide

User passwords must be hashed before storing in vault variables. Never store plaintext passwords to avoid leaking secrets. 

## Method 1: mkpasswd (Recommended)

Install whois package (includes mkpasswd):
```bash
sudo apt install whois
```

Generate password hash:
```bash
mkpasswd
```

You'll be prompted to enter a password. The output will be a hash like:
```
$y$j9T$ugEXXXflDJbz.yBSt4qm3/$9xnQ9gTo2FBvF7vcuEb8QklB7twM/oZwM7bxB1Y54HA
```

Add to vault.yaml:
```yaml
vault_username_ssh_pass: "$y$j9T$ugEXXXflDJbz.yBSt4qm3/$9xnQ9gTo2FBvF7vcuEb8QklB7twM/oZwM7bxB1Y54HA"
```

## Method 2: Python passlib

Using uv (passlib is already in dependencies):
```bash
uv run python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"
```

You'll be prompted to enter a password. The output will be a hash like:
```
$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ.
```

Add to vault.yaml:
```yaml
vault_username_ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."
```

## Adding to Vault

Edit the vault file:
```bash
ansible-vault edit inventories/group_vars/all/vault.yaml
```

Add the password hash with the correct variable name:
```yaml
---
# User passwords (hashed)
vault_dmac_ssh_pass: "$6$your_hash_here"
vault_user2_ssh_pass: "$6$another_hash_here"

# API tokens
vault_zerotier_api_token: "your-api-token"
```

## Variable Naming Convention

Vault variables must follow this pattern:
- Prefix with `vault_`
- Use snake_case
- Match the username for user passwords: `vault_<username>_ssh_pass`

Example:
- User: `dmac` → Vault variable: `vault_dmac_ssh_pass`
- User: `john_doe` → Vault variable: `vault_john_doe_ssh_pass`

## Security Best Practices

1. Never commit plaintext passwords
2. Always use hashed passwords for user creation
3. Store all sensitive data in vault.yaml (encrypted)
4. Keep vault password file (`~/.vault_pass`) secure with 600 permissions
5. Use strong, unique passwords for each user
6. Rotate passwords regularly

## Verifying Password Hashes

Test that a password hash works:
```bash
# On the target system after user creation
su - username
# Enter the original password (not the hash)
```

Or verify the hash format:
```bash
# SHA-512 hashes start with $6$
# yescrypt hashes start with $y$
echo "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ." | grep -E '^\$[0-9y]\$'
```
