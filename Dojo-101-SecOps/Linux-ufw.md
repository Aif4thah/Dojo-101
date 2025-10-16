## UFW

### Comandes pour configurer simplement un firewall avec UFW sous Linux

* On veut fermer tout le traffic entrant et autoriser le traffic sortant
* On veut aussi autoriser les protocoles ssh (port 22 en tcp), http/https (ports 80/443 en tcp), dns (port 53 en udp) et dhcp (port 68 en udp)

commande de démarrage de ufw

```sh
ufw enable
```

### autorisation d'IPV6 si nécessaire

```sh
nano /etc/default/ufw
# vérifier qu'il y a la ligne IPV6=yes
```

### auotrisations des entrées et sorties

```sh
ufw default deny incoming
ufw default allow outgoing
```

### configuration des protocoles

```sh
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 53/udp
ufw allow 68/udp
```
