## notes token jwt

## En 3 parties pour un token JWT signé (JWS) :

 - Header JWS.

 - Payload.

- Signature. Dans l'exemple ci-dessous cette signature est calculée en réalisant un hash HMAC du header JWS et du payload : 
Signature = HMAC-SHA256((base64url(HEADER) + "." + base64url(PAYLOAD)), secret).

## ressources

https://jwt.io/
https://developer.okta.com/blog/2017/08/17/why-jwts-suck-as-session-tokens

 
## notes

Le token JWT est hébergé dans le Local Storage du navigateur qui ne bénéficie pas du même niveau de sécurité qu'un cookie (pas de

flag « Secure » pour forcer l’usage de HTTPS, pas de flag « HTTPOnly » pour éviter sa manipulation par du Javascript). En conséquence :

Un token JWT est particulièrement sensible à l'exploitation d'une faille XSS, mais est nativement résilient à l'exploitation d'une

faille CSRF (ce dernier n’étant pas systématiquement envoyé dans les headers HTTP).

Inversement, un cookie (avec le flag HttpOnly) est insensible aux failles XSS mais manipulable via une faille CSRF. L’usage de tokens anti-CRSF est cependant natif dans la plupart des frameworks applicatifs, là où les failles XSS restent plutôt répandues.

Les implémentations manquent de maturité d’un point de vue sécurité et sont hétérogènes :

Le support des attributs standards (en particulier la gestion de l'expiration) est variable suivant les implémentations.

Les contrôles relatifs aux algorithmes de chiffrement utilisés présentent / ont présenté de nombreuses failles facilement

### exploitables :

Remplacement de la valeur "alg" du header JWS par "None" pour bypasser tous les contrôles de sécurité (source). Exploitation d’une mauvaise implémentation des contrôles pour valider un token JWT en HMAC-SHA256 à partir une clé

publique RSA au niveau du serveur (source).

Attaque liée à l’implémentation de ECDH-ES (Invalid Curve Attack) pour récupérer la clé privée du serveur signant les tokens (source).

Une attaque par recherche exhaustive offline est réalisable sur les tokens JWT obtenus. Cette attaque a peu de chance d’aboutir (sauf si la clé de signature est présente dans un dictionnaire), la compromission de la clé partagée peut cependant permettre de forger des tokens JWT. Suivant leur contenu et leur usage, ces tokens forgés peuvent permettre d’accéder à d’autres éléments de l’infrastructure et d’élever ses privilèges.