# PKI (Public key infrastructure) / IGC Infrastructure de gestion de clés

## definition

* Autorité de certification (AC): Agit comme racine de confiance dans une infrastructure à clé publique et fournit des services qui authentifient l’identité des personnes, des ordinateurs et d’autres entités dans un réseau. (source: microsoft)

* Autorité d’inscription: Est certifié par une autorité de certification racine pour émettre des certificats pour des utilisations spécifiques autorisées par la racine. Dans une infrastructure à clé publique Microsoft, une autorité d’inscription (RA) est généralement appelée autorité de certification subordonnée. (source: microsoft)

* Base de données de certificats: Enregistre les demandes de certificat et les certificats émis et révoqués et les demandes de certificat sur l’autorité de certification ou l’autorité de certification. (source: microsoft)

* Magasin de certificats: Enregistre les certificats émis et les demandes de certificat en attente ou rejetées sur l’ordinateur local. (source: microsoft)

* Serveur d’archivage de clé : Enregistre les clés privées chiffrées dans la base de données de certificats pour une récupération après perte. (source: microsoft)

* AC Racine :

* AC Intermediaire :

* Chaine de confiance: 

* HSM: Hardware Security Module


## emplacement des certificats

### Certstore Windows

mmc: certmgr.msc

```powershell
ls Cert:\CurrentUser\
ls Cert:\CurrentUser\My\* |fl
```

## lire un certificat depuis un fichier

```sh 
openssl x509 -in certificate.crt -text -noout
```

```powershell
Get-PfxCertificate .\cert.cer |fl *
```

