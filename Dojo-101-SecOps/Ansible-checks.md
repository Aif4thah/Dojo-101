# Ansible

## Installation les binaires (Ubuntu)

```sh
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```


## téléchargement du rôle ansible

```sh
ansible-galaxy search <role>
ansible-galaxy install <role>,<version>
```

le rôle est alors installé dans `~/.ansible/roles/`
`default` contient les variables
`tasks` contient les actions à effectuer

Le rôle peut ensuite être ajusté manuellement.


## vérifier les tasks d'un playbook

```sh
ansible-playbook -i "localhost," -c local --list-tasks playbook.yml
```


## créer le snippet

Le playbook va ensuite spécier le role à appliquer.

playbook.yml

```yml
- hosts: all
  roles:
    - { role: <role> }
```


## deployer la configation à partir du playbook

```sh
ansible-playbook -i "localhost," -c local playbook.yml
```


## check la configation à partir du playbook

```sh
ansible-playbook -i "localhost," -c local --check playbook.yml
```

## Debug

Certains requirements peuvent entrainer des erreurs et arrêter les checks 
L'option `--step` permet des tests manuels sans modification du template
