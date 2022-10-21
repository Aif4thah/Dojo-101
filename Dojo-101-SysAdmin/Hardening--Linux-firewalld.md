# Firewalld

contribution d'Antoine BARLOT

```shell
sudo systemctl enable firewalld
sudo systemctl start firewalld
 ```


```shell
sudo firewall-cmd --state
```

## lister et affecter une zone

```shell
firewall-cmd --get-active-zones
```

```shell
firewall-cmd --zone=zone-name --change-interface=<interface-name>
```




## lister les services

```shell
firewall-cmd --zone=public --list-services
```


## Autoriser un service

### Pour activer le service SSH :

```shell
sudo firewall-cmd --zone=public --add-service=ssh --permanent
```

### désactiver tous les services inutiles

```shell
sudo firewall-cmd --zone=public --remove-service=XXXX --permanent
```

### fermer les ports inutiles

```shell
sudo firewall-cmd --remove-port= port-number/port-type
```
