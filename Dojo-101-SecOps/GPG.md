# GPG et openPGP

## Principe 

### génération des clés

Alice: KpubAlice + **KprivAlive**
Bob: Kpubbob + **KprivBob**

**Les clés privées sont secrètes**

### procedure

1. Alice et Bob partagent leurs clés publiques

Alice: **KprivAlice** + KpubAlice + KpubBob
Bob:  **KprivBob** + KpubBob + KpubAlice

2. Envoi: Alice fait un message pour Bob

    * le message est signé avec **KprivAlice** : `KprivAlive.Sign(Message)` [1]
    * le message est chiffré avec KpubBob: `KpubBob(Message)` [2]

3. Réception: Bob reçoit le message

    * le message est déchiffré avec **KprivBob** : `KprivBob.Dechiffre(Message)`
    * l'authenticité du message est vérifiée avec KpubAlice: `KpubAlive.Verif(Message)`

### plus de détail

[1] le hash de message est calculé, ce hash est ensuite signé

[2] une clé symétrique est générée afin de chiffrer le message, cette clé symétrique est chiffrée par la clé publique du destinataire


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

