## LUKS
  
Chiffrer un disque dur externe (ou une clé USB) avec LUKS
  20 Jul 2014    Un disque dur externe contenant vos données n’a pas de raisons de ne pas être chiffré. Voici quelques commandes utiles pour l’utilisation de LUKS.

Prérequis
Le paquet cryptsetup doit être installé :
sudo apt-get install cryptsetup
Initialisation

Trouver le disque
Tout d’abord, il faut déterminer l’emplacement du disque dur dans /dev. Pour cela, avant de le brancher, exécuter la commande :
sudo tail -f /var/log/messagesLors du branchement du disque, plusieurs lignes similaires à celles-ci doivent apparaître :
Jul 20 21:25:29 pc kernel: [  678.139988] sd 7:0:0:0: [sdb] 976754645 4096-byte logical blocks: (4.00 TB/3.63 TiB)
Ici, [sdb] signifie que l’emplacement est /dev/sdb. Dans la suite, je noterai cet emplacement /dev/XXX.
Il est très important de ne pas se tromper d’emplacement, afin de ne pas formater un autre disque…

Effacer le disque
Si des données étaient présentes sur ce disque, il est plus sûr de tout supprimer physiquement :
sudo dd if=/dev/zero of=/dev/XXX bs=4KCette commande peut prendre beaucoup de temps, puisqu’elle consiste à réécrire physiquement tous les octets du disque dur.

Créer la partition chiffrée
Pour initialiser la partition chiffrée :
sudo cryptsetup luksFormat -h sha256 /dev/XXXLa passphrase de déchiffrement sera demandée.
Maintenant que nous avons une partition chiffrée, ouvrons-la :
sudo cryptsetup luksOpen /dev/XXX lenomquevousvoulezCette commande crée un nouveau device dans /dev/mapper/lenomquevousvoulez, contenant la version déchiffrée (en direct).

Formater
Pour formater cette partition en ext4 :
sudo mkfs.ext4 /dev/mapper/lenomquevousvoulez -L unlabelPour l’initialisation, c’est fini, nous pouvons fermer la vue déchiffrée :
sudo cryptsetup luksClose lenomquevousvoulez
Montage manuel
Il est possible de déchiffrer et monter la partition manuellement en ligne de commande :
sudo cryptsetup luksOpen /dev/XXX lenomquevousvoulez
sudo mkdir -p /media/mydisk
sudo mount -t ext4 /dev/mapper/lenomquevousvoulez /media/mydiskLe contenu est alors accessible dans /media/mydisk.
Pour démonter et fermer, c’est le contraire :
sudo umount /media/mydisk
sudo cryptsetup luksClose /dev/XXX lenomquevousvoulezMais c’est un peu fastidieux. Et je n’ai pas trouvé de solution pour permettre le luksOpen par un utilisateur (non-root) en ligne de commande.

Montage semi-automatique
Les environnement de bureau permettent parfois de monter un disque dur chiffré simplement, avec la demande de la passphrase lors de l’ouverture du disque. Voici ce que j’obtiens avec XFCE :

Mais par défaut, le nom du point de montage est peu pratique : /media/rom/ae74bc79-9efe-4325-8b4d-63d1506fa928. Heureusement, il est possible de le changer. Pour cela, il faut déterminer le nom de la partition déchiffrée :
$ ls /dev/mapper/luks-*
/dev/mapper/luks-8b927433-4d4f-4636-8a76-06d18c09723e
Le nom très long correspond en fait à l’UUID du disque, qui peut aussi être récupéré grâce à :
sudo cryptsetup luksUUID /dev/XXXou encore :
sudo blkid /dev/XXXL’emplacement désiré, ainsi que les options qui-vont-bien, doivent être rajoutés dans /etc/fstab :
/dev/mapper/luks-8b927433-4d4f-4636-8a76-06d18c09723e /media/mydisk ext4 user,noauto
Ainsi, le disque sera désormais monté dans /media/mydisk.
Si en plus, nous souhaitons spécifier un nom user-friendly pour la partition déchiffrée (celui dans /dev/mapper/), il faut ajouter une ligne dans /etc/crypttab (en adaptant l’UUID) :
mydisk UUID=8b927433-4d4f-4636-8a76-06d18c09723e none luks,noauto
Et utiliser celle-ci à la place dans /etc/fstab :
/dev/mapper/mydisk /media/mydisk ext4 user,noauto

Gestion des passphrases
Il est possible d’utiliser plusieurs passphrases (jusqu’à 8) pour déchiffrer le même disque.
Pour en ajouter une :
sudo cryptsetup luksAddKey /dev/XXXPour en supprimer une :
sudo cryptsetup luksRemoveKey /dev/XXXPour changer une unique passphrase, il suffit d’en ajouter une nouvelle puis de supprimer l’ancienne.
Ou alors d’utiliser :
sudo cryptsetup luksChangeKey /dev/XXXmais man cryptsetup dit qu’il y a un risque.

État
Pour consulter l’état d’une partition LUKS :
sudo cryptsetup luksDump /dev/XXX
Gestion de l’en-tête
L’en-tête LUKS est écrit au début du disque. L’écraser empêche définivement le déchiffrement de la partition.
Il est possible d’en faire une sauvegarde dans un fichier :
cryptsetup luksHeaderBackup /dev/XXX --header-backup-file fichierEt de les restaurer :
cryptsetup luksHeaderRestore /dev/XXX --header-backup-file fichierPour supprimer l’en-tête (et donc rendre les données définitivement inaccessibles s’il n’y a pas de backup) :
cryptsetup luksErase /dev/XXX
Conclusion
Une fois configuré la première fois, et après les quelques modifications pénibles pour choisir les noms pour le déchiffrement et le montage, l’utilisation au quotidien est vraiment très simple : il suffit de rentrer la passphrase directement à partir du navigateur de fichiers.


