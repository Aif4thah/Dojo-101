# **NODE TOR** 

By Gaël Rousseau & Timothy Ringard

## 1.Installer une debian  

  
## 2.Installer tor sur la debian  

    apt-get install tor
 
## 3.Configurer le fichier /etc/tor/torrc

 Paramètre | Utilité 
:--------|:--------
 RunAsDaemon 1                   | Démarre Tor en tant que tâche de fond 
 DirPort 9030                    | Port pour le référencement du relais 
 ORPort 9001                     | Port du relais 
 Nickname RelayName              | Nom du relais 
 ContactInfo contact@domain.tld  | Adresse e-mail de contact 
 Exitpolicy reject :             | Rejette le trafic sortant afin de devenir un nœud intermédiaire 
 RelayBandwidthRate 1250 KBytes  | Limite de la bande passante pour le relais 
 RelayBandwidthBurst 1450 KBytes | Burst de bande passante pour le relais (au cas où la bande passante maximum est atteinte)

 
## 4.Redémarrer le service et réactiver le service :

    systemctl restart tor && systemctl enable tor
 
## 5. Autoriser le passage sur notre machine avec le pare-feu

    iptables -A INPUT -i eth0 -p tcp --dport 9001 -m state --state NEW,ESTABLISHED -j ACCEPT 
    iptables -A OUTPUT -o eth0 -p tcp --sport 9030 -m state --state ESTABLISHED -j ACCEPT 
    service iptables restart && service tor restart

### ***Si vous utilisez un routeur/modem ou la box de votre FAI, vous devrez ouvrir les ports 9001 et 9030 (TCP)***
 
## 6.Vérifier le bon fonctionnement dans les logs : 
    vim /var/log/tor/log  

**OU**  

##  [Vérification de l'existence de notre noeud tor](https://metrics.torproject.org/rs.html "Vérification de l'existence du noeud tor")  


**OU**

## Installer un anonymizing relay monitor via la commande: 

    apt-get install tor-arm

## Puis taper la commande :

    nyx

## ***7.Welcome to the World Wide Secret Web***

