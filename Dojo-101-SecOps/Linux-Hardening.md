# Linux Hardning

## Ressources

* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-relatives-un-systeme-gnulinux)
* [Lynis](https://cisofy.com/lynis/)
* [Nuclei](https://github.com/projectdiscovery/nuclei)
* [Privesc](https://github.com/carlospolop/PEASS-ng)
* [Privesc bins](https://gtfobins.github.io/)

## Audit

### Lynis

* [Lynis](https://github.com/CISOfy/lynis)

Une fois installé depuis le dépot ou le gestionnaire de paquets, 

l'ajustement du référentiel et de la compliance se fait dans le fichier : `/etc/lynis/default.prf`

lancement de l'audit:

```sh
lynis audit system
```

## Automatisation

* Ansible
