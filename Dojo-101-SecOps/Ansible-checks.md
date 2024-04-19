# Ansible

Ansible pour une utilisation quick and dirty en audit ou en POC

## En local sous Linux

### Installation les binaires (Ubuntu)

```sh
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```


### téléchargement du rôle ansible

```sh
ansible-galaxy search <role>
ansible-galaxy install <role>,<version>
```

le rôle est alors installé dans `~/.ansible/roles/`
`default` contient les variables
`tasks` contient les actions à effectuer

Le rôle peut ensuite être ajusté manuellement




### vérifier les tasks d'un playbook

On appelle généralement la conf via le playbook : `playbook` -> `role` > `tasks`

```sh
ansible-playbook -i "localhost," -c local --list-tasks playbook.yml
```


### créer le snippet

Le playbook va ensuite spécier le rôle à appliquer.

playbook.yml

```yml
- hosts: all
  roles:
    - { role: <role> }
```


### deployer la configation à partir du playbook

```sh
ansible-playbook -i "localhost," -c local playbook.yml
```


### check la configation à partir du playbook

```sh
ansible-playbook -i "localhost," -c local --check playbook.yml
```


## Push vers une machine Windows

### Exemple de winrm en basic (non sécurisé)

inventory.yml coté Linux-Ansible

```yml
[windows]
VULN.LAN

[windows:vars]
ansible_user=Ansible
ansible_password=azerty1234+-
ansible_connection=winrm
ansible_port=5985
ansible_winrm_scheme=http
ansible_winrm_transport=basic
```

Conf winRM coté windows **non sécurisé!**

```powershell
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Get-Service winrm |Restart-Service
```

La conf winRM downgradé ressemble alors à ça :

Service
    RootSDDL = O:NSG:BAD:P(A;;GA;;;BA)(A;;GR;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
    MaxConcurrentOperations = 4294967295
    MaxConcurrentOperationsPerUser = 1500
    EnumerationTimeoutms = 240000
    MaxConnections = 300
    MaxPacketRetrievalTimeSeconds = 120
    **AllowUnencrypted = true**
    Auth
        **Basic = true**
        Kerberos = true
        Negotiate = true
        Certificate = false
        CredSSP = false
        CbtHardeningLevel = Relaxed
    DefaultPorts
        **HTTP = 5985**
        HTTPS = 5986
    IPv4Filter = *
    IPv6Filter = *
    EnableCompatibilityHttpListener = false
    EnableCompatibilityHttpsListener = false
    CertificateThumbprint
    AllowRemoteAccess = true

### Push de la conf

```sh
ansible-playbook -i inventory.yml role.yml -vvv
```

## Pour aller plus loin sécuriser la connexion : 

### HTTPS

```batch
Winrm quickconfig -transport:https
```

### Utilisation du vault ansible

```sh
ansible-vault encrypt files/secrets/credentials.yml
```


## Debug

### Organisation du rôle

```txt
roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case
```

### Check étape par étape

Certains requirements peuvent entrainer des erreurs et arrêter les checks 
L'option `--step` permet des tests manuels sans modification du template
