# Ansible

## Installation (Ubuntu)

```sh
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```

## téléchargement du rôle

```sh
ansible-galaxy search <role>
ansible-galaxy install <role>,<version>
```

le rôle est alors installé dans `~/.ansible/roles/`
`default` contient les variables
`tasks` contient les actions à effectuer

Il peut être ajusté manuellement.

## vérifier les tasks

```sh
ansible-playbook -i "localhost," -c local --list-tasks playbook.yml
```

## créer le snippet

playbook.yml

```yml
- hosts: all
  roles:
    - { role: <role> }
```

## deploy

```sh
ansible-playbook -i "localhost," -c local playbook.yml
```

## check

```sh
ansible-playbook -i "localhost," -c local --check playbook.yml
```
Certains requirements peuvent entrainer des erreurs et arrêter les checks 
L'option `--step` permet des tests manuels sans modification du template
