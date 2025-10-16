# Memento réseau

## Modele OSI

| Couche OSI | Couche TCP/IP | Exemples de protocoles |
|---------|--------------|-------------|
| 7 Application |Application | HTTP, FTP, SMTP, DNS |
| 6 Présentation| Application | SSL, TLS |
| 5 Session | Application | NetBIOS, RPC |
| 4 Transport | Transport |TCP, UDP |
| 3 Réseau | Internet | IP, ICMP, ARP |
| 2 Liaison de données | réseau | Ethernet, PPP |
| 1 Physique | réseau | Ethernet, Wi-Fi |

## Classes d’adresses IPv4

### Classe A

* Plage d’adresses publiques : 1.0.0.0 à 127.0.0.0
* Plage d’adresses privées : 10.0.0.0 à 10.255.255.255
* Masque de sous-réseau : 255.0.0.0 (/8)

### Classe B

* Plage d’adresses publiques : 128.0.0.0 à 191.255.0.0
* Plage d’adresses privées : 172.16.0.0 à 172.31.255.255
* Masque de sous-réseau : 255.255.0.0 (/16)

### Classe C

* Plage d’adresses publiques : 192.0.0.0 à 223.255.255.0
* Plage d’adresses privées : 192.168.0.0 à 192.168.255.255
* Masque de sous-réseau : 255.255.255.0 (/24)

### Plages privées IPV4

* Classe A : 10.0.0.0 à 10.255.255.255
* Classe B : 172.16.0.0 à 172.31.255.255
* Classe C : 192.168.0.0 à 192.168.255.255

### Boucles locales

* 127.X.X.X

## Adresses IPv6

### Type

* Unicast : Identifie une seule interface réseau.
* Anycast : Attribué à un groupe d’interfaces, généralement appartenant à différents nœuds. Un paquet envoyé à une adresse anycast est livré à une seule des interfaces membres.
* Multicast : Utilisé par plusieurs hôtes qui acquièrent l’adresse de destination multicast en participant au protocole de distribution multicast parmi les routeurs réseau.

### exemple de notation

* Adresse complète : FE80:0000:0000:0000:0202:B3FF:FE1E:8329
* Adresse avec suppression des zéros : FE80::0202:B3FF:FE1E:8329
* Adresse normale : 2001:db8:3333:4444:5555:6666:7777:8888
* Adresse avec des segments de zéros : 2001:db8:: (implique que les six derniers segments sont zéro)
* Adresse avec des segments de zéros au début : ::1234:5678 (implique que les six premiers segments sont zéro)

### Plages privées IPV6

* Bloc d’adresses fc00::/7 = RFC 4193 Unique Local Addresses (ULA)2
* Bloc d’adresses fec0::/10 = dépréciées (RFC 3879)2

## Boucles locales IPv4

* ::1

## Exemple de calcul d’adresse réseau avec CIDR

* Adresse IP : 192.168.1.1 => 11000000.10101000.00000001.00000001
* Masque de sous-réseau : /24 => 11111111.11111111.11111111.00000000
* Adresse réseau : 11000000.10101000.00000001.00000000 => 192.168.1.0
* L’adresse réseau pour 192.168.1.1/24 est donc 192.168.1.0.

## Misc

* TCP Handshake : Syn, Syn-Ack, Ack
* afficher la table de routage sous windows: `route print`
* afficher la table de routage sous linux: `ip route`
* afficher le cache ARP: `arp -a`
