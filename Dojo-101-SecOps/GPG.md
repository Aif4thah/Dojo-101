# GPG PGP

## generer clé 

```sh
gpg --full-generate-key
```

## lister mes cles: 

```sh
gpg --list-keys
```

## exporter ma clé publique: 

```sh
gpg --export -a "User Name" > public.key
```

## importer une clé publique: 

```sh
gpg --import keys.asc
```

## to import a private key: 

```sh
gpg --allow-secret-key-import --import private.key
```

## encrypt data 

```sh
gpg -e -u "Sender User Name" -r "Receiver User Name" somefile
```

## decrypt data 

```sh
gpg -d mydata.tar.gpg
```

## To export a private key: 

```sh
gpg --export-secret-key -a "User Name" > private.key
```

## extraire les PJ une fois déchiffré:

```sh
sudo apt-get install mpack
munpack msg
```

