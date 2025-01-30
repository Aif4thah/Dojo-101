# Audit et Durcissement / Hardning Linux

## Permissions

* AppArmor
* SELinux

## Audit

### Lynis

* [Lynis](https://github.com/CISOfy/lynis)

Une fois installé depuis le dépot ou le gestionnaire de paquets, 

l'ajustement du référentiel et de la compliance se fait dans le fichier : `/etc/lynis/default.prf`

Log file: `/var/log/lynis.log`
Report file: `/var/log/lynis-report.dat`

lancement de l'audit:

```sh
lynis audit system
```

* propose également des modes "pentest" et "forensic"
* propose de l'audit docker.



### Nuclei

* [Nuclei](https://github.com/projectdiscovery/nuclei)

* [Contient des templates de configuration pour le scan](https://github.com/projectdiscovery/nuclei-templates/tree/main/code/privilege-escalation/linux)
* Implémentation et personnalisation des scans possible


## Hardening IaC

* [Ansible](https://www.ansible.com/)

## Ressources

* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-relatives-un-systeme-gnulinux)
* [Privesc](https://github.com/carlospolop/PEASS-ng)
* [Privesc bins](https://gtfobins.github.io/)


