# SIEM

## splunk in docker

| Port | Usage |
|-----|----|
| 8088 | API HTTP Event Collector (HEC) |
| 9997 | Pour les forwarders |
| 8000 | Interface web de Splunk |

Exemple de lancement de splunk en mode POC, le partage de volume est à adapter.

```sh
docker run -d --name splunk \
  -p 8000:8000 -p 8088:8088 -p 9997:9997 \
  -e SPLUNK_START_ARGS="--accept-license" \
  -e SPLUNK_PASSWORD="changeme" \
  -v /root/splunk:/opt/splunk/var/run/dispatch \
  splunk/splunk:latest
```

longin à l'url : `http://localhost:8000/`

### Ajouts de log :

>[!WARNING]
> POC hors prod : pas d'authent du client.

`Settings` > `Data Inputs` > `HTTP Event Collector`

tester ensuite l'envoi d'event : 

```sh
curl -k https://localhost:8088/services/collector -H "Authorization: Splunk <token>" -d '{"event": "test"}'
```

### Import des logs manuels

`Settings` > `AddData` > `Upload a file`