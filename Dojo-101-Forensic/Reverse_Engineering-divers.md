# Reverse

## objdump 

info liées à la compiloation (objects files)

`objdump -d <fichier>`

### nm

nm afficher les symbole et permet de rechercher des adresses:

`nm ch7 | grep -E '( username|_atexit)'`

## misc

* en x86 les parametre sont sous la stack

* en amd64 les parametres sont dans les registre (ex: eax)

