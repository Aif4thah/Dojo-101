# Ansible


## En local sous Linux


### Installation les binaires (Ubuntu)


```bash
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```


### téléchargement du rôle ansible


```bash
ansible-galaxy search <role>
ansible-galaxy install <role>,<version>
```

le rôle est alors installé dans `~/.ansible/roles/`
`default` contient les variables
`tasks` contient les actions à effectuer


Le rôle peut ensuite être ajusté manuellement


### vérifier les tasks d'un playbook

On appelle généralement la conf via le playbook : `playbook` -> `role` > `tasks`


```bash
ansible-playbook -i "localhost," -c local --list-tasks playbook.yml
```

### créer le snippet

Le playbook va ensuite spécifier le rôle à appliquer.

playbook.yml

```yml
- hosts: all
  roles:
    - { role: <role> }
```

### déployer la configuration à partir du playbook


```bash
ansible-playbook -i "localhost," -c local playbook.yml
```


### check la configuration à partir du playbook


```bash
ansible-playbook -i "localhost," -c local --check playbook.yml
```

## Push vers une machine Windows


> Attention ces confs sont pour du POC, la bonne pratique est d'avoir un serveur dans le domaine et de s'appuyer sur Kerberos.


### Exemple hors prod : d'authent winrm en NTLM (mieux, mais toujours NON SÉCURISÉ pour des comptes à privilèges)

```yml
[windows]
MSCT.LOCAL


[windows:vars]
ansible_user=Ansible
ansible_password=█████████
ansible_connection=winrm
ansible_port=5985
ansible_winrm_transport=ntlm
```

### Conf côté serveur pour ces authentifications (non recommandé en prod) :


### Conf WINRM

Conf winRM rapide et **peu sécurisé selon l'authent choisie** côté windows, configurer le chiffrement et les certificats reste recommandé ! 


```powershell
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Get-Service winrm |Restart-Service
```

Conf winrm affiché en sortie :


```yml
Service
    RootSDDL = O:NSG:BAD:P(A;;GA;;;BA)(A;;GR;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
    MaxConcurrentOperations = 4294967295
    MaxConcurrentOperationsPerUser = 1500
    EnumerationTimeoutms = 240000
    MaxConnections = 300
    MaxPacketRetrievalTimeSeconds = 120
    AllowUnencrypted = true
    Auth
        Basic = true
        Kerberos = true
        Negotiate = true
        Certificate = false
        CredSSP = false
        CbtHardeningLevel = Relaxed
    DefaultPorts
        HTTP = 5985
        HTTPS = 5986
    IPv4Filter = *
    IPv6Filter = *
    EnableCompatibilityHttpListener = false
    EnableCompatibilityHttpsListener = false
    CertificateThumbprint
    AllowRemoteAccess = true
```


### Push de la conf

```bash
ansible-playbook -i inventory.yml role.yml -vvv
```


## Axe pour la sécurisation : 


### Kerberos


```YML
[windows]
VULN.LAN


[windows:vars]
ansible_user=Ansible
ansible_password=█████████
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_transport=kerberos
```

### HTTPS


générer un certificat et activer HTTPS (port 5986) 


```powershell
winrm quickconfig -transport:HTTPS
```


désactiver les paramètres non sécurisés côté serveur et vérifier :


```powershell
winrm enumerate winrm/config/listener
```


### Utilisation du vault ansible


```bash
ansible-vault encrypt files/secrets/credentials.yml
```

## Debug


### Organisation du rôle


```
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

