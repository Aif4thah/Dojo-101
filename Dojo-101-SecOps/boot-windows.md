# boot  windows

les images distribué par microsoft n'ont pas de partition gpt, il n'est pas possible de booter sur une clé usb en copiant l'image (ok pour un DVD ou une VM)
il faut créer la partition gpt manuellement ou avec un outil (rufus) et désactiver le secureboot pour booter sur la clé (secureboot=produit commercial=Microsoft=pas de signature des logiciel GPLv3)


