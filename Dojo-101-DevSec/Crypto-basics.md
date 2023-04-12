# Cryptographie

## Chiffrement symétrique

### Principe

Lorsque le chiffrement symétrique est mis en œuvre, la même clé permet de chiffrer et déchiffrer. Ce type de chiffrement est généralement utilisé pour la confidentialité des informations.
 
### Algo

* 3DES (obsolètes)
* Rijndael, AES

### Use case

* Pour la mise en œuvre de chiffrement de surface, par exemple la mise en œuvre de la technologie Bitlocker
* Lors de revues liées aux choix de suites cryptographiques (dont TLS)

## Chiffrement asymétrique :

### Principe 

Le chiffrement asymétrique est composé d’une clé privée et d’une clé publique. L’une pouvant déchiffrer ce que la seconde a chiffré. Ce type de chiffrement est généralement utilisé pour l’authentification et la non-répudiation. 

### Algo

* DSA
* RSA 
* ECDSA
 
### Use case

* La signature de documents, de code ou de message (dont certificats X509 en combinaison avec RSA/ECDSA, avec un secret pour les signatures HMAC pour les Tokens JWT etc...)
* Lors de revues liées aux choix de suites cryptographiques (TLS, SSH, PGP…)
* Stockage des secrets

## Hash (Condensats)

### Principe 

le condensat (ou hash), est obtenu grâce à opération mathématique à sens unique. Les algorithmes utilisés peuvent être MD5, SHA1 aujourd’hui obsolètes ou SHA2. 

### Algo

* SHA1, MD5 (obsolètes)
* SHA2, SHA3, SHA512

### Use case 

* Pour le stockage de secret, par exemple des mots de passe en base de données
* Lors de revues liées aux choix de suites cryptographiques (HMAC, Oauth/JWT, TLS)

## Génération d'aléas:

### Le niveau d’exigence est élevé 	

Je me réfère aux référentiels d’audits, aux guides ANSSI et à la qualification (critères communs) du produit utilisé.
Je m’assure que mon travail soit complété par une démarche d’homologation ou de certification appropriée.

### Le niveau d’exigence est modéré

Le premier niveau de contrôle concerne le respect des cas d’usage et la détection de vulnérabilités publiques présentes dans les librairies utilisées. 

Le code de l’application, lorsque disponible, peut ensuite être passé en revue. Je peux alors être amené adresser des recommandations à partir des éléments suivants :

* La vérification à partir de la documentation que le « pseudo random number generator » (PRNG) est bien conçu pour un usage cryptographique (non prédictible).

* La vérification à partir de la documentation que le PRNG est appelé avec la bonne configuration et avec les contrôles de sécurité adéquats.

* L’absence de comportement biaisé, par exemple la valeur de « seed » fixe lors de l’appel à un DRBG.

* Le calcul théorique de l’entropie obtenue en bits log2(possibilités d’un élementnombre d’élements)

* Dans une moindre mesure : les sources de l’entropie utilisées par le « random number génération » (RNG). Dans le cas du mouvement de la souris, il faudra s’assurer de son mouvement. Dans le cas d’écriture disque, prendre en compte la machine utilisée, etc.

## attaques

| Type | Description |
|------|-------------|
| Cypher text attack | L’auditeur à accès au message chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. Il s’agit du cas le plus fréquent. |
| Choosen plaintext attack | L’auditeur peut définir le contenu du message en clair chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. |
| Known plaintext attack | L’auditeur connait le contenu du message en clair chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. |

## refs

* Serious Cryptography de Jean-Philippe Aumasson (ISBN-13: 9781593278267)
* Crypto Dictionnay de Jean-Philippe Aumasson (ISBN-13: 9781718501409)
