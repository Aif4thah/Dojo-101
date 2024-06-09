# **Playbook de correction de vulnérabilités**

## **Correction sous Linux**

[from @Jrb62](https://github.com/Jrb62/Formation-AIS-et-DevOps/tree/main/Ansible)

### Liste des actions réalisé par le playbook : 

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


### **Le playbook**

````

---
- name: Secure Ubuntu 22.04 Server
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

````


### Preuve de fonctionnement :

![alt tag](https://github.com/Jrb62/Formation-AIS-et-DevOps/blob/main/screenshot/preuvelinux.png)