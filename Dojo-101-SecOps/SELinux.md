# SELinux

## installation

```sh
sudo systemctl disable apparmor
sudo apt install policycoreutils selinux-basics selinux-utils -y
```

## activation

```sh
sudo selinux-activate
```

## status

```sh
sestatus
```

## labels

```sh
ls -Z
ps -Z
```

## Multi-Level Security (MLS) policy

```sh
apt install selinux-policy-mls
```

remplacer default par mls dans le fichier de conf:

```sh
root@vaca-virtual-machine:~# cat /etc/selinux/config
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
# enforcing - SELinux security policy is enforced.
# permissive - SELinux prints warnings instead of enforcing.
# disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
# default - equivalent to the old strict and targeted policies
# mls     - Multi-Level Security (for military and educational use)
# src     - Custom policy built from source
SELINUXTYPE=mls

# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0
```

activer le mode permissif dans un premier temps (autorise mais log les accès qui ne matchent pas avec les règles)

```sh
setenforce 0
```

ajouter les labels

```sh
fixfiles -F onboot
reboot
```

Consulter les logs pour affiner les permissions:

```sh
grep "SELinux is preventing" /var/log/messages
```

## gerer les permissions / habilitation

lister:

```sh
semanage login -l
```

octroyer à un user existant:

***s15 est le niveau le plus élevé / restreint***

```sh
semanage login -a -s staff_u -r s0-s2:c100.c100 vaca
root@vaca-virtual-machine:~# chcon -R -l s2:c100 /home/vaca
```

modifier les permission

```sh
semanage login --modify --range s2:c100 vaca
```
