# LUKS
  
## Prérequis

Le paquet cryptsetup doit être installé :

```sh
sudo apt-get install cryptsetup
```

## Voir les volumes chiffrés et leur état

```sh
lsblk --fs
sudo cryptsetup luksDump /dev/sda4
```

## Initialisation

### Trouver le disque

```sh
sudo tail -f /var/log/messages
```

Lors du branchement du disque, plusieurs lignes similaires à celles-ci doivent apparaître :

```txt
Jul 20 21:25:29 pc kernel: [678.139988] sd 7:0:0:0: [sdb] 976754645 4096-byte logical blocks: (4.00 TB/3.63 TiB)
```

## (optionnel) Effacer le disque

```sh
sudo dd if=/dev/zero of=/dev/sdb bs=4K
```

## Créer la partition chiffrée

```sh
sudo cryptsetup luksFormat -h sha256 /dev/sdb
sudo cryptsetup luksOpen /dev/sdb <name>
```

## Formater la nouvelle partition chiffrée

```sh
sudo mkfs.ext4 /dev/mapper/lenomquevousvoulez -L unlabel
```

## fermer le volume

```sh
sudo cryptsetup luksClose <name>
```

## Montage

```sh
sudo cryptsetup luksOpen /dev/sdb <name>
sudo mkdir -p /media/mydisk
sudo mount -t ext4 /dev/mapper/lenomquevousvoulez /media/mydiskLe contenu est alors accessible dans /media/mydisk.
```

## Gestion des passphrases

### ajouter une passphrase

```sh
sudo cryptsetup luksAddKey /dev/sdb
```

### supprimer une passphrase

```sh
sudo cryptsetup luksRemoveKey /dev/sdb
```

## changer une passphrase

```sh
sudo cryptsetup luksChangeKey /dev/sdb
```

## sauvegarde des headers (indispensable pour la recovery)

```sh
cryptsetup luksHeaderBackup /dev/sda4 --header-backup-file /tmp/luks.img
```
