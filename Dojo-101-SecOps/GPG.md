# GPG PGP

> generer clé: gpg --full-generate-key
> lister mes cles: gpg --list-keys
> exporter ma clé publique: gpg --export -a "User Name" > public.key
> importer une clé publique: gpg --import keys.asc
> to import a private key: gpg --allow-secret-key-import --import private.key
> To encrypt data, use: gpg -e -u "Sender User Name" -r "Receiver User Name" somefile
> To decrypt data, use: gpg -d mydata.tar.gpg
> To export a private key: gpg --export-secret-key -a "User Name" > private.key
> 
> extraire les PJ une fois déchiffré:
> ```sh
> $ sudo apt-get install mpack
> $ munpack msg
> ```

