The purpose of this repo is to store a collection of commonly used Ansible playbooks, roles and inventories.


## Links

## Notes
- TO BE FIXED: In the group_vars/all/vars file all the usernames and ssh_pub_key names should match. Example
```yaml
users:
  - username: dmac
    sudo_access: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'dmac.pub') }}"
    ssh_pass: "{{ vault_dmac_ssh_pass }}"
```


## How to use

### Pre-requisites

- Install uv: https://docs.astral.sh/uv/getting-started/installation/
- Add a file with a password to decrypt Vault variables on the following path `~/.vault_pass`. This is controlled by the `ansible.cfg` file.
- Install all python dependencies: `uv sync`
- Enable your virtual environment: `source .venv/bin/activate` (or use `uv run` prefix)
- Modify the ansible inventory with your user
- Update the inventory file at [inventories/inventory.ini](inventories/inventory.ini)


### Update your vars

- Update the [inventories/group_vars/all/vars](inventories/group_vars/all/vars) file
    - SSH Public Keys need to be added to the [roles/ubuntu/files/](roles/ubuntu/files/) folder.
```bash
cd roles/ubuntu/files/
echo "SSH-PUB-KEY-HASH" > dmac.pub
echo "SSH-PUB-KEY-HASH" > svmt.pub
```
- All Sensitive vars will be stored in the [inventories/group_vars/all/vault.yaml](inventories/group_vars/all/vault.yaml) file so make sure to create 
```bash
grep -r vault_ inventories/group_vars   # This will tell you which vault variables need to be defined.
ansible-vault create inventories/group_vars/all/vault.yaml # Then create this file with the variables above.
```


### Using this project

```bash
ansible-playbook playbooks/ubuntu.yml -K

# Or run directly with uv
uv run ansible-playbook playbooks/ubuntu.yml -K
```


### Generate password for users:
#### Method 1 (mkpasswd utility)
```bash
sudo apt install whois
mkpasswd

Password:
$y$j9T$ugEXXXflDJbz.yBSt4qm3/$9xnQ9gTo2FBvF7vcuEb8QklB7twM/oZwM7bxB1Y54HA

ssh_pass: "$y$j9T$ugEXXXflDJbz.yBSt4qm3/$9xnQ9gTo2FBvF7vcuEb8QklB7twM/oZwM7bxB1Y54HA"
```

#### Method 2 (Python with uv)
``` python
# passlib is already in dependencies
uv run python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"

Password:
$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ.


ssh_pass: "$6$ckQnPlokpK7pgQ8/$OYVyTArxJMDguRdERhzF0ia9f5YcRiy8fVaqzRvj1J4P0sUkRwSgwWNT/3Pbic0Z2gZs4mW6jQPviosCBdmwJ."
```
- Update the [inventories/group_vars/all/vars](inventories/group_vars/all/vars) file

## Requirements
- To setup the Ansible control node:
    - `uv` (https://docs.astral.sh/uv/getting-started/installation/)
    - `sudo apt install sshpass`

## TO-DO
- Role ubuntu
    - Create groups (Done)
    - Create users (Done)
    - Create SSH File (Done)
    - Add SSH Authorized (Done)
    - Update APT (Done)
    - Install Apps (Done)
    - Add Aliases "~/.aliases" (Done)
    - Add functions "~/.custom_functions" (Done)
- Installing SNAP (Done)
- ZeroTier Role (Done)
    - Example role1: https://github.com/m4rcu5nl/ansible-role-zerotier
    - Exmaple Role 2: https://gitlab.com/tobkern1980/ansible-role-zerotierone/-/tree/master/tasks?ref_type=heads
    - Installing Zerotier (Done)
    - Enabling to survive a restart 
    - Authorize_node (Done)
    - Join_network (Done)
- Role ZSH
    - Install ZSH (Done)
    - Install Oh-my-ZSH (Done)
    - Install Powerlevel10K ZSH Theme (Done)
        - P10k Configured with a config file (Done)
    - Install extra plugins for ZSH (Check if they ar eonly aliases, don't use them)
        - autojump
        - zsh-autosuggestions
        - poetry
        - zsh-syntax-high
        - pyenv
        - git
        - ripgrep
        - terraform
        - copypath

- Configure and test pre-commit (Done)
- Add syntax higlihting vscode
- Test ansible-lint in vscode (Suppose to come wit the Ansible extension)
- Docs for the role
    - The role expected the ssh_key to match the name of the username. Example user: dmac and pub key dmac.pub
- pre-commit script to make sure all your vault files are encrypted before committing.
