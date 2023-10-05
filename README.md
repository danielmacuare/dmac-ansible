The purpose of this repo is to store a collection of commonly used Ansible playbooks, roles and inventories.


## Links


## How to use
- Generate password for users:
``` python
poetry add passlib or pip install passlib
python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"

Password:
$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ.


ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."

```

## Requirements
- To setup the Ansible control node.
python3 + pip or poetry
sudo apt install sshpass

## TO-DO
- Role ubuntu
    - Create groups
    - Create users
    - Create SSH File
    - Add SSH Authorized
    - Update APT
    - Install Apps
- Configure and test pre-commit
- Add syntax higlihhting vscode
- Test ansible-lint in vscode (Suppose to come wit the Ansible extension)
- Docs for the role
    - The role expected the ssh_key to match the name of the username. Exampel user: dmac and pub key dmac.pub
- pre-commit hook to avoid leaking vault files unencrypted