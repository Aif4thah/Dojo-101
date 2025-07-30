# **Solution WireGuard : Client to site**

Mise en place sur Debian 11

Update :
```
apt-get update
``` 
 ## Installation :

``` 
 apt-get install wireguard
``` 
Génération de clées privée et public :
```
wg genkey | sudo tee /etc/wireguard/wg-private.key | wg pubkey | sudo tee /etc/wireguard/wg-public.key
```

 Créer et editer un fichier de configuration

```
 nano /etc/wireguard/wire.conf
```

On va définir un réseau logique restreint en /29 par exemple :
```
[Interface]
Address = 192.168.99.5/29
SaveConfig = true
ListenPort = 61202
PrivateKey = "private key" 
```
On change aussi le port par défaut, pour écouter sur le port 61202 par exemple.
La PrivateKey se trouve dans le fichier /etc/wireguard/wg-private.key

Une nouvelle carte réseau va pouvoir être créée, portant le nom de notre fichier de configuration :
```
wg-quick up wire
```

On peut ainsi vérifier la présence de la nouvelle carte réseau "wire" : 
``` 
ip a
```
```
3: wire: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    link/none 
    inet 192.168.99.1/29 scope global wire
       valid_lft forever preferred_lft forever
```
Pour activer le démarrage automatique de la carte Wireguard ainsi que du service : 
```
systemctl enable wg-quick@wire.service
```

Pour rajouter une couche de sécurité supplémentaire nous allons générer une Pre-Shared Key. Celle-ci devra être utilisée uniquement pour un seul client et le serveur. Pour tout autre client, il faudra générer à chacun une nouvelle Pre-Shared Key. Cette clé nous servira un peu plus tard.
```
wg genspk
<redacted>
```
### Configuration 
Nous allons activer l'IP Forwading : 
```
nano /etc/sysctl.conf
```
Puis rajouter à la dernière ligne : 
```
net.ipv4.ip_forward = 1
```

Nous installerons ufw pour les règles de parefeu : 
```
apt install ufw
```
Nous allons ainsi éditer une première règle autorisant le traffic VPN WireGuard sur notre port 61202 personnalisé : 
```
ufw allow 61202/udp
``` 
Puis dans notre cas nous voulons autoriser seulement le réseau 172.20.10.0/28 à accèder aux services web Intranet et DNS via l'interface "wire" à travers le VPN : 
``` 
ufw allow in on wire proto tcp from 172.20.10.0/28 to any port 80
ufw allow in on wire proto tcp from 172.20.10.0/28 to any port 443
ufw allow in on wire proto udp from 172.20.10.0/28 to any port 53
``` 
Il nous reste à éditer le fichier de configuration pour permettre l'IP masquerade ainsi que le forwarding réseau autorisé : 
``` 
nano /etc/ufw/before.rules
``` 
On va pouvoir ajouter notre carte réseau eth0 pour le NAT : 
``` 
# NAT - IP masquerade
*nat
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o eth0 -j MASQUERADE
```
Puis rajouter dans ce même fichier de configuration : 
```
# autoriser le forwarding pour le réseau distant et le réseau VPN WireGuard
-A ufw-before-forward -s 192.168.99.0/29 -j ACCEPT
-A ufw-before-forward -d 192.168.99.0/29 -j ACCEPT
-A ufw-before-forward -s 172.20.10.0/28 -j ACCEPT
-A ufw-before-forward -d 172.20.10.0/28 -j ACCEPT
```
Redémarrons le service ufw et activons le service afin qu'il soit persistant : 
```
ufw enable
systemctl restart ufw
```

Nous pouvons vérifier la configuration ufw : 
``` 
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 61202/udp                  ALLOW IN    Anywhere                  
[ 2] 80/tcp on wire             ALLOW IN    172.20.10.0/28            
[ 3] 443/tcp on wire            ALLOW IN    172.20.10.0/28            
[ 4] 53/udp on wire             ALLOW IN    172.20.10.0/28            
[ 5] 61202/udp (v6)             ALLOW IN    Anywhere (v6)             
``` 

#### **Configuration Client** 

Le lien de téléchargement du client est ici : https://download.wireguard.com/windows-client/wireguard-installer.exe

Il suffit ensuite de suivre les instruction puis de lancer le client. Ensuite cliquer sur "Ajouter le tunnel" puis "Ajouter un tunnel vide".

Configuration du tunnel : 
On va définir l'interface dans le même réseau que l'interface "wire" du serveur, récupérer la clée publique du serveur, et permettre de joindre les réseaux à atteindre, y compris notre réseau VPN. On spécifie également la Pre-Shared Key généré au préalable.
```
[Interface]
PrivateKey = "clé privée"
Address = 192.168.99.3/29

[Peer]
PublicKey = "clée publique serveur"
PresharedKey = <redacted>
AllowedIPs = 192.168.99.0/29, 192.168.1.0/24
EndPoint = "ip publique VPN":61202 
```
On retourne côté Serveur :
On va éteindre l'interface wire pour pouvoir modifier le fichier /etc/wireguard/wire.conf
 ```
 wg-quick down wire
 nano /etc/wireguard/wire.conf
 ```
 Le fichier de configuration sera comme ci-dessous. On spécifie notre adresse ip de la carte réseau "wire", ainsi que le port d'écoute du serveur, la clé publique du client concerné, tout en spécifiant son ip avec /32 pour ne permettre que ce client, ainsi que la Preshared Key. 
 ```
 [Interface]
Address = 192.168.99.5/29
SaveConfig = true
ListenPort = 61202
PrivateKey = "clé privée"

[Peer]
PublicKey = "clée publique client"
AllowedIPs = 192.168.99.3/32
PresharedKey = <redacted>
```
On relance Wireguard : 
```
wg-quick up wire
```
On peut maintenant retourner côté client et cliquer sur "Activer".
On obtient bien l'adresse IP 192.168.99.3 comme spécifiée dans le fichier de configuration. 
Si on souhaite utiliser le full tunnel WireGuard, pour passer tout le flux à travers le VPN, il suffit de modifier le fichier client en spécifiant : 
```
AllowedIPs = 0.0.0.0/0
```
Pour tester le bon fonctionnement de notre VPN, on peut accèder à la page de notre serveur web via Powershell :
``` 
PS C:\Users\administrateur> curl http://192.168.99.5:80 | select Statuscode

StatusCode
----------
       200
```
Notre recevons le StatusCode 200 signifiant la réussite de notre requête.

Dans le cadre d'un VPN en production, ne pas oublier la redirection de port sur le routeur, ou sur la Box FAI.
Dans notre cas présent, nous avons établi une règle de redirection vers le port 61202 de notre serveur WireGard, depuis notre ip publique sur le port 61202 également. 


#### **Scan sécurité** 

Il existe un outil nommé Ike-Scan qui permet de scanner les potentielles vulnérabilités sur les serveurs VPN, utilisant le protocle IKE (Internet Key Exchange).
Testons sur notre serveur WireGuard en spécifiant le port 61202 que nous avons configuré : 
```
──(root💀sayan)-[~]
└─# ike-scan 192.168.1.72 -p 61202
WARNING: Specifying a backoff pattern file with --patterns or -p does not
         have any effect unless you also specify --showbackoff or -o

Starting ike-scan 1.9.5 with 1 hosts (http://www.nta-monitor.com/tools/ike-scan/)

Ending ike-scan 1.9.5: 1 hosts scanned in 2.435 seconds (0.41 hosts/sec).  0 returned handshake; 0 returned notify
──
```
Visibilement, notre WireGuard n'est pas vulnérable.
Nous allons donc essayer avec Nmap en spécifiant les arguments -sU pour réaliser le scan en UDP, -p pour le port, ainsi que --script vuln pour utiliser le script qui va exécuter un ensemble de script pour scanner les vulnérabilités les plus connues.
```
┌──(root💀sayan)-[~]
└─# nmap -sU 192.168.1.72 -p 61202 -sV --script vuln
Starting Nmap 7.93 ( https://nmap.org ) at 2022-10-20 16:12 UTC
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for kali.lan (192.168.1.72)
Host is up (0.034s latency).

PORT      STATE         SERVICE VERSION
61202/udp open|filtered unknown

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 147.78 seconds
```
Nmap nous renvoie aucune vulnérabilités. Notons ici que le port a pu être reconnu à l'état "open" grâce à l'argument -sU qui réalise le scan en UDP.  




