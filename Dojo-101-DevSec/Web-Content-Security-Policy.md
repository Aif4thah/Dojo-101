# Content Security Policy

| Directive  | Description          | 
| :--------------- |:---------------| 
| default-src  |   sert de fallback      |  
| script-src  | Fichiers Javascript et script inline  | 
| style-src  | feuilles de style         | 
| child-src  | Frames/Iframes et Web brokers | 
| worker-src  | web brokers      | 
| font-src  | polices de caractères  | 
| connect-src  | WebSocket, XMLHttpRequest, Fetch, attribut de ping de balise <a>  | 
| object-src  | balises <object>, <embed>, <applet>   | 
| form-action  | attribut action des balises <form>   | 
| navigate-to  | window.location, windows.open        | 
| frame-ancestors  | idem X-Frame: restreint la mise de la page dans un Iframe     | 
| base-uri  | url de base pour les url relatives      | 
| report-uri | endpoints des rapports de signalement  |
| report-to | groupe de reporting des rapports de signalement |
| block-all-mixed-contents | HTTPS pas mixé avec HTTP |
| upgrade-insecure-requests | réécrit HTTP vers HTTPS |

## valeur des sources

> unsafe-inline et unsafe-eval à proscrire ! 

* 'none' = doit etre seul, restriction totale
* 'self' = meme origine (protocole et port)
* unsafe-inline' = autorise <style>, <script>, onerror, onclick...
* 'unsafe-eval' = autorise `eval, funciton, setTimeout, setInterval()`
* https://site...
* https://site/fichier
* domaine.com
* data: = données seulement
* 'nonce-ch4hvvbHDpv7xCSvXCs3BrNggHdTzxUA = 'nonce-<base64>' est une méthode permettant d'autoriser spécifiquement les ressources inline avec l'attribut none="<base64>". Le principe est de créer un nonce aléatoire qui change à chaque fois que l'entête CSP est renvoyé par le serveur
* 'sha256-XrP50Mq6s78GLH2Vyt4BfKhn8rx40dU6FYqQGbxRuzc=' = 'sha256-<base64>' est une méthode permettant d'autoriser spécifiquement les ressources inline dont le hash cryptographique du contenu est présent dans la déclaration de la politique Les algorithmes supportés sont : sha256, sha384 et sha512

## Notes

* Sur un site recent et mature pas de 'unsafe-inline' au CSP : on remplace les methodes :

```html
<button id="btn" onclick="faireQuelqueChose()"></button>
```

par 

```js
document.getElementById("btn").addEventListener("click", faireQuelqueChose);
```