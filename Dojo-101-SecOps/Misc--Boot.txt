## Boot

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

