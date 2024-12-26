# Ansible

## Arborescence d'un rôle ansible

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

## Sécurisation : 

## Vault

### Chiffrer les fichiers sensibles à l'aide du Vault (chiffrement au repos uniquement)

fichier `inv.yml` **contenant des secrets** en clair :

```yml
[windows]
WIN-M0QSK6K1QJ7.MSCT.LOCAL

[windows:vars]
ansible_user=Ansible@MSCT.LOCAL
ansible_password="<donnée sensible à chiffrer ici>"
ansible_connection=winrm
ansible_port=5985
ansible_winrm_transport=kerberos
``` 

Chiffrement du fichier à l'aide du vault, demandera un mot de passe

```bash
Ansible-vault encrypt inv.yml
```

Contenu du fichier après chiffrement :

```yml
$ANSIBLE_VAULT;1.1;AES256
65633265613764343435663334363862633466326364383465323536333138623861613735376633
6630646532373063363735366666613331623435396165300a386234323066633866333839353138
35323232366530333333396639366130356333626464323939656139623336383465353231653938
3333383665663866610a633839633531383865646265626537396663633634393534666661303931
35616435616361623135346131323231653634323561343833313066363261313963663463333961
63653663353438313531343861366333383366653934623739303766653736663130613135313466
65356364366632306362313363363864666361393333303261396466336632396339333864356230
63646530303836343733616563303338626334356137613462666463353639653432656663373864
63306563333236626432376665646139393934626332303932323035393064353730613839613131
34643862346331316234653833633862333734653737376631663764663131323765306161386637
32333861356336363661633661373632316134373332383337306264386130396136663232376265
30633833353566663036353737303166656536343063333439326338356336616565373964383538
32653439663339653732316265636130653661646531353862343862633263326438336536656436
6365323235346131343764646161616637363430356532303137
```

Execution du playbook sans déchiffrer les données sensibles

```bash
ansible-playbook --ask-vault-pass -i inv.yml -vvv rol.yml
```

Si besoin, déchiffrement du fichier :

```bash
ansible-vault decrypt inv-crypt.yml
```

### Configuration du dossier Vault et du fichier credentials.yml

[From Jojlg](https://github.com/jojlg)

```bash
mkdir /home/ansible/nom_du_projet/vault
nano vault/credentials.yml
```

```bash
ansible_become_password: <password>
vault_ansible_user: <user>
```

Chiffrer le fichier credentials.yml

```bash
ansible-vault encrypt credentials.yml
```

### WinRM

générer un certificat et activer HTTPS (port 5986) 

```powershell
winrm quickconfig -transport:HTTPS
```

### Kerberos

inventory.yml

```yml
<SNIP>
ansible_winrm_transport: kerberos
<SNIP>
``` 




## Playbooks exemple

[from @Jrb62](https://github.com/Jrb62/Formation-AIS-et-DevOps/)

### Checks Linux

| N°  | Action                                                 |
|-----|--------------------------------------------------------|
| 1   | Mettre à jour et mettre à niveau les paquets apt       |
| 2   | Installer les paquets nécessaires                      |
| 3   | Activer UFW et autoriser uniquement SSH et HTTP        |
| 4   | Définir les politiques par défaut de UFW               |
| 5   | Configurer fail2ban                                    |
| 6   | Configurer les mises à jour automatiques               |
| 7   | S'assurer que le serveur OpenSSH est installé          |
| 8   | Renforcer la configuration SSH                         |
| 9   | Redémarrer le service SSH                              |
| 10  | Ajouter un utilisateur non-root avec des privilèges sudo|
| 11  | Définir le mot de passe pour le nouvel utilisateur     |
| 12  | Désactiver l'accès SSH root                            |
| 13  | S'assurer que le groupe sudo peut utiliser sudo sans mot de passe |
| 14  | Activer UFW (gestionnaire)                             |


### Playbook Linux

```yml
---
- name: Ubuntu Server
  hosts: all
  become: yes
  tasks:

    - name: Update and upgrade apt packages
      apt:
        update_cache: yes
        upgrade: dist
        autoremove: yes

    - name: Install necessary packages
      apt:
        name: 
          - ufw
          - fail2ban
          - unattended-upgrades
        state: present

    - name: Enable UFW and allow only SSH and HTTP
      ufw:
        rule: allow
        port: "{{ item }}"
        proto: tcp
      with_items:
        - 22
        - 80
      notify: enable_ufw

    - name: Set UFW default policies
      ufw:
        state: enabled
        policy: "{{ item.policy }}"
      with_items:
        - { policy: 'deny', direction: 'incoming' }
        - { policy: 'allow', direction: 'outgoing' }

    - name: Configure fail2ban
      copy:
        dest: /etc/fail2ban/jail.local
        content: |
          [sshd]
          enabled = true
          port = ssh
          logpath = %(sshd_log)s
          maxretry = 5
          bantime = 3600

    - name: Configure unattended-upgrades
      copy:
        dest: /etc/apt/apt.conf.d/50unattended-upgrades
        content: |
          Unattended-Upgrade::Allowed-Origins {
              "${distro_id}:${distro_codename}";
              "${distro_id}:${distro_codename}-security";
          };
          Unattended-Upgrade::Automatic-Reboot "true";

    - name: Ensure OpenSSH Server is installed
      apt:
        name: openssh-server
        state: present

    - name: Harden SSH configuration
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
      with_items:
        - { regexp: '^#?PermitRootLogin', line: 'PermitRootLogin no' }
        - { regexp: '^#?PasswordAuthentication', line: 'PasswordAuthentication no' }
        - { regexp: '^#?ChallengeResponseAuthentication', line: 'ChallengeResponseAuthentication no' }
        - { regexp: '^#?UsePAM', line: 'UsePAM yes' }
        - { regexp: '^#?X11Forwarding', line: 'X11Forwarding no' }
        - { regexp: '^#?AllowTcpForwarding', line: 'AllowTcpForwarding no' }
        - { regexp: '^#?MaxAuthTries', line: 'MaxAuthTries 3' }

    - name: Restart SSH service
      service:
        name: ssh
        state: restarted

    - name: Add a non-root user with sudo privileges
      user:
        name: myuser
        state: present
        groups: sudo
        append: yes
        createhome: yes
        shell: /bin/bash

    - name: Set password for the new user
      user:
        name: myuser
        password: "{{ 'mysecurepassword' | password_hash('sha512') }}"

    - name: Disable root SSH access
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'

    - name: Ensure sudo group can use sudo without password
      lineinfile:
        path: /etc/sudoers
        state: present
        regexp: '^%sudo'
        line: '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL'

  handlers:
    - name: enable_ufw
      ufw:
        state: enabled
```

### Checks Windows

| N°  | Action                                                      |
|-----|-------------------------------------------------------------|
| 1   | S'assurer que WinRM est configuré                           |
| 2   | Définir la politique de mot de passe                        |
| 3   | Désactiver le compte invité                                 |
| 4   | Désactiver NTLMv1                                           |
| 5   | Activer la pré-authentification Kerberos pour tous les comptes utilisateurs |
| 6   | S'assurer que tous les comptes administrateurs ont la pré-authentification Kerberos activée |
| 7   | Détecter les utilisateurs avec des droits administratifs indirects |
| 8   | Mesures de sécurité de base - Désactiver le compte administrateur par défaut |
| 9   | Mesures de sécurité de base - Activer le pare-feu            |
| 10  | Mesures de sécurité de base - Activer Windows Defender       |


### playbook Windows

```yml
---
- name: Windows Server Domain Controller
  hosts: windows
  gather_facts: no
  tasks:

     - name: Ensure WinRM is configured
       win_service:
          name: WinRM
          start_mode: auto
          state: started

     - name: Set password policy
       win_shell: |
         Import-Module ActiveDirectory
         Set-ADDefaultDomainPasswordPolicy -Identity "AIS.FR" -MinPasswordLength 12
       register: set_password_policy

     - name: Disable guest account
       win_user:
         name: guest
         state: absent

     - name: Disable NTLMv1
       win_shell: |
         Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LmCompatibilityLevel -Value 5
       register: disable_ntlmv1

     - name: Enable Kerberos preauthentication for all user accounts
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter * -Properties KerberosEncryptionType | Set-ADUser -KerberosEncryptionType AES128,AES256
       register: kerberos_pre_auth

     - name: Ensure all administrator accounts have Kerberos preauthentication enabled
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter {memberof -recursiveMatch "CN=Administrateurs,CN=Builtin,DC=AIS,DC=FR"} -Properties   KerberosEncryptionType | Set-ADUser -KerberosEncryptionType AES128,AES256
       register: admin_kerberos_pre_auth

     - name: Detect users with indirect admin rights
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter {memberof -recursiveMatch "CN=Administrateurs,CN=Builtin,DC=AIS,DC=FR"} -Properties MemberOf | Select-Object -Property SamAccountName, MemberOf
       register: indirect_admin_users

     - name: Basic security measures - Disable default administrator account
       win_user:
         name: Administrator
         state: absent

     - name: Basic security measures - Enable firewall
       win_feature:
         name: Windows-Defender
         state: present

     - name: Basic security measures - Enable Windows Defender
       win_shell: |
         Set-MpPreference -DisableRealtimeMonitoring $false

```




## Utilisation en local sous Linux (POC)


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




## Push vers WINDOWS (POC depuis Linux, hors domaine AD)


> Attention ces confs sont pour du POC, la bonne pratique est d'avoir un serveur dans le domaine et de s'appuyer sur Kerberos.


### NTLM

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

### Push de la conf

```bash
ansible-playbook -i inventory.yml role.yml -vvv
```


## Debug

### Downgrade sécurité winRM pour débug (plus de chiffrement et mdp en clair)

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


### Check étape par étape

Certains requirements peuvent entrainer des erreurs et arrêter les checks 
L'option `--step` permet des tests manuels sans modification du template

