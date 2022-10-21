#!/bin/sh
# pour configuration au boot:
# 1 - lancer ce script
# 2 - # iptables-save > ~michael/Documents/Firewall.cfg
# 3 - Ajouter "pre-up iptables-restore < /home/michael/Documents/Firewall.cfg" a la fin du fichier /etc/network/interfaces
# 4 - faire la meme manipulation pour IPV6: "ip6tables-save > Firewall6.cfg" puis ajout du "pre-up ip6tables-restore" a la fin du fichier interfaces
########
# IPV4 #
########
### suppression des anciennes regles
iptables -F && iptables -X && iptables -t nat -F
### Default policy 
iptables -P FORWARD DROP
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT
#traffic local
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
### Allow established connections + ports dynamiques
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Autoriser toute nouvelle demande de connexion HTTP et HTTPS
iptables -A INPUT -p tcp --tcp-flags SYN SYN --dport 80 -j ACCEPT -m state --state NEW
iptables -A INPUT -p tcp --tcp-flags SYN SYN  --dport 443 -j ACCEPT -m state --state NEW
iptables -A INPUT -p tcp --tcp-flags SYN SYN --dport 8000 -j ACCEPT -m state --state NEW
iptables -A INPUT -p tcp --tcp-flags SYN SYN --dport 10443 -j ACCEPT -m state --state NEW

########
# IPV6 #
########
ip6tables -F && ip6tables -X && ip6tables -t nat -F
ip6tables -P FORWARD DROP
ip6tables -P INPUT   DROP
ip6tables -P OUTPUT  DROP
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT


