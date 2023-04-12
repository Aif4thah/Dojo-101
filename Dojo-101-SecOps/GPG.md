# GPG PGP

## generer clé 

gpg --full-generate-key

## lister mes cles: 

gpg --list-keys

## exporter ma clé publique: 

gpg --export -a "User Name" > public.key

## importer une clé publique: 

gpg --import keys.asc

## to import a private key: 

gpg --allow-secret-key-import --import private.key

## encrypt data 

gpg -e -u "Sender User Name" -r "Receiver User Name" somefile

## decrypt data 

gpg -d mydata.tar.gpg

## To export a private key: 

gpg --export-secret-key -a "User Name" > private.key

## extraire les PJ une fois déchiffré:

sudo apt-get install mpack
munpack msg

