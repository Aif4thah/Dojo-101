# Linux Firewalld

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


# Tuto d'Imad:

# Firewalld



## Installer firewalld
    sudo apt install firewalld

## Verifier quelle zone est actuellement séléctionnée

    sudo firewalld-cmd --get-default-zone
    
    = public


## Attribuer une interface à notre zone par defaut
    
    sudo firewall-cmd --zone=public --change-interface=enp0s3

    = success

### Vérifier que la modification est correcte 
    
    sudo firewall-cmd --get-active-zones

    = public
        interface : enp0s3


## Activation d'un nouveau service

> Nous allons créer un service http2. Pour gagner du temps, nous allons copier/coller le service http puis modifier la conf en http2

    sudo cp /usr/lib/firewalld/services/http.xml /etc/firewalld/services/http2.xml

> Modification du ficher
    
    sudo nano /etc/firewall/service/http2.xml


> Utilisation du protocol TCP/UDP sur le port 8000

    <?xml version="1.0" encoding="utf-8"?>
    <service>
        <short>WWW (HTTP)</short>
        <description>HTTP is the protocol used to serve Web pages. If you plan to make your Web server publicly available, enable this option. This option is not required for viewing pages locally or developing Web pages.</description>
        <port protocol="tcp" port="8000"/>
        <port protocol="udp" port="8000"/>
    </service>


## Application du service dans la zone par default 
    
    sudo firewall-cmd --zone=public --add-service=http2
    
    sudo firewall-cmd --zone=public --add-service=http2 --permanent
    
    = success

> **ATTENTION PENSER A RELOAD LE FIREWALL**
    
    sudo firewall-cmd --reload


### Recap des services disponibles

    sudo firewall-cmd --zone=public --list-services

    dhcp dns http2 https ssh

> Les services DHCP, DNS, HTTPS & SSH sont des services activés précédement, pour désactiver les services inutiles

    sudo firewall-cmd --zone=public --remove-service=(service)



## Tester le firewalld depuis KALI LINUX


    ┌──(kali㉿kali)-[~]
    └─$ nmap -sT 172.20.10.5 -p 8000
    Starting Nmap 7.92 ( https://nmap.org ) at 2022-10-21 12:19 CEST
    Nmap scan report for 172.20.10.5
    Host is up (0.0020s latency).

    PORT     STATE    SERVICE
    8000/tcp filtered http-alt

    Nmap done: 1 IP address (1 host up) scanned in 6.57 seconds
                                                                                                                                                                                                                                            
    ┌──(kali㉿kali)-[~]
    └─$ nmap -sA 172.20.10.5 -p 8000
    You requested a scan type which requires root privileges.
    QUITTING!
                                                                                                                                                                                                                                            
    ┌──(kali㉿kali)-[~]
    └─$ sudo nmap -sA 172.20.10.5 -p 8000
    [sudo] Mot de passe de kali : 
    Starting Nmap 7.92 ( https://nmap.org ) at 2022-10-21 12:21 CEST
    Nmap scan report for 172.20.10.5
    Host is up (0.00055s latency).

    PORT     STATE    SERVICE
    8000/tcp filtered http-alt
    MAC Address: 08:00:27:4D:E9:05 (Oracle VirtualBox virtual NIC)

    Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds
