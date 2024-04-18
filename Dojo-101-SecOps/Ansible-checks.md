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

Le rôle peut ensuite être ajusté manuellement

## Organisation du role

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



## vérifier les tasks d'un playbook

On appel généralement la conf via le playbook : `playbook` -> `role` > `tasks`

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


