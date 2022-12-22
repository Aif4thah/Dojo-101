# Cryptographie

## Chiffrement symétrique

### principe 
Lorsque le chiffrement symétrique est mis en œuvre, la même clé permet de chiffrer et déchiffrer. Ce type de chiffrement est généralement utilisé pour la confidentialité des informations.
 
### algo

* 3DES (obsolètes)
* Rijndael, AES

### use case

* Pour la mise en œuvre de chiffrement de surface, par exemple la mise en œuvre de la technologie Bitlocker
* Lors de revues liées aux choix de suites cryptographiques (dont TLS)

## Chiffrement asymétrique :

### principe 

Le chiffrement asymétrique est composé d’une clé privée et d’une clé publique. L’une pouvant déchiffrer ce que la seconde a chiffré. Ce type de chiffrement est généralement utilisé pour l’authentification et la non-répudiation. 


### algo

* DSA
* RSA 
* ECDSA
 

### use case

* La signature de documents, de code ou de message (dont certificats X509 en combinaison avec RSA/ECDSA, avec un secret pour les signatures HMAC pour les Tokens JWT etc...)
* Lors de revues liées aux choix de suites cryptographiques (TLS, SSH, PGP…)
* Stockage des secrets


## Hash (Condensats)

### Principe 

le condensat (ou hash), est obtenu grâce à opération mathématique à sens unique. Les algorithmes utilisés peuvent être MD5, SHA1 aujourd’hui obsolètes ou SHA2. 

### algo

* SHA1, MD5 (obsolètes)
* SHA2, SHA3, SHA512

### use case 

* Pour le stockage de secret, par exemple des mots de passe en base de données
* Lors de revues liées aux choix de suites cryptographiques (HMAC, Oauth/JWT, TLS)


## Génération d'aléas:


2 cas de figures:

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

## théroie

### Mesure de la sécurité :

-	Mesure de l’entropie : -p1 x log2(p1) – p2 x log2(p2) -…- pn x log2(pn)
-	Notion « informal security » (ex : One-time-Pad)
-	Notations « computational security » : (t,ε)-secure où t est le nombre d’opérations et ε la probabilité de succès.
-	Notations n-bits security : log2(possibilités), seuil à 280 opérations

### Notions de preuve de sécurité (réduction) :

-	Notion de preuve de sécurité liée aux Mathématiques :
o	Problèmes de factorisation : « n=pq » où n et q sont premiers (RSA)
o	Problèmes de logarithmes discrets : 
	Déterminer y où x=gy dans Zp (mod p) et p premier (DH)
	Déterminer k à partir d’un point P où Q=kP (EC)
-	Notion de preuve de sécurité liée à la cryptographie
-	Notion de complexité :
o	Linéaire : n
o	Polynomiale : nk 
o	Exponentielle : 2n
o	Introduction au Classes TIME, SPACE, P < NP (solution candidate en P) < NP-Complet


#### Chiffrement Symétrique en mode « Block »

-	Rappel des « Round » : C = R3(R2 (R1(P))) et « Round Key » (Ki)
-	Rappel du « Feistel Scheme » : L⊕F(R) où P divisé en L et R
-	Notions de Codebook (2nx n bits en mémoire) et slide attack (P2=R(P1))
-	AES : KeyExpansion, AddRounKey, SubBytes, ShiftRows, MixColumns. (cf. figure chapitre 6)
-	Exemple d’implémentation Software et Natives Instructions
-	Modes : 
o	ECB (non sécurisé) : C1=E(K,P1),C2=E(K,P2),etc…
o	CBC : Ci=E(K,Pi⊕Ci-1) et IV
o	CTR : E(Counter, Nonce, K) ⊕ P
-	Principe DES et « Meet-In-The-Middle Attack »
-	Padding, CypherText Stealing et Padding Oracle Attack

### Chiffrement Symétrique en mode « Stream »

-	Principe : KeySream, Nonce, KS=SC(K,N) puis C=P⊕KS et P=C⊕KS
-	Principe de fonctionnement RC4 (non sécurisé), attaque WEP (N=24bits lié à K), Faiblesse TLS liées à RC4 (non-randomness)

### Condensats (Hashs)

-	Rappel « preimage resistance » et « one-way function »
-	Rappel « second preimage resistance » et collision (2n/2 au lieu de 2n)
-	Nombre de collisions possibles : N*(N-1)/2, Birthday Attack et Rho method : Hi+1=F(Hi), H’i+1=F(F(H’i)) jusqu’à Hi+1=H’i+1
-	Fonctions de compression, MD5, SHA-1, SHA-2
-	Fonctions de permutation, SHA-3

### Message Authentication Codes

-	Message authentication Codes (MAC), impossible à deviner < Pseudo Random Function (PRF), impossible un distinguer d’un aléa
-	HMAC : Hash((K⊕out-pad)||Hash((K⊕in-pad)||M))
-	Principes CBC-MAC (non sécurisé) et CMAC
-	Initiation Timing-Attack et constant-time implementation
-	Notions Encrypt-and-Mac, MAC-then-encrypt, Encrypt-then-MAC (AES-GCM)


### Chiffrement Asymétrique : RSA

-	Euler’s totient function : φ(n) = (p – 1)(q – 1), où n sera le modulus
-	Trapdoor permutation with e : y = xe mod n
-	Trapdoor permutation with d : yd mod n = xed mod n = x, car ed = 1
-	p et q doivent donc absolument rester secret
-	Notion « Optional Asymmetric Encryption Padding (OAEP)» et « Probabilistic Signature Scheme » (PSS)

### Diffie-Hellman

-	Principe : 
o	A = ga et B = gb échangés 
o	gab secret partagé où Ab= gab et Ba=gab
o	Contrainte : dans Zp il faut p et (p-1)/2 premiers
o	L’interception de ga et gb ne compromet pas gab

-	Avers Courbes Elliptiques (ECDH) : 
o	Soit un point G
o	PA=dAG et PB=dBG échangés
o	Secret partagé : dAdBG = dAPB = dBPA

### Courbes Elliptiques

-	Courbe de type y2=x3+ax+b dans Zp où p premier et a et b rigoureusement séléctionnés
-	Notions NIST Curves, Curve25519
-	Additionner 2 points tel que R = P+Q :
o	m=(yQ-yP)/(xQ-xP)
o	xR=m2-xP-xQ
o	yR=m(xP-xR)-yP
-	Additionner P et –P
o	P(xP,yp) + -P(xP,-yp)=O (infini)
-	Multiplication par 2 (2P) :
o	m=(3xP2+a)/(2yP)
o	xR=m2-xP-xQ
o	yR=m(xP-xR)-yP
-	Multiplication par k :
o	Algorithme « Square and Mutliply »
o	8P = 4P + 4P , etc…
-	Pour tout P, P+O=P
-	Sécurité : 
o	un groupe Zp compte approximativement p points (ordre)
o	Généralement p sur 256 bits
o	k secret où Q=kP
-	Notion collisions : c1P+d1Q = c2P+d2Q et k=(c1-c2)/(d2-d1)
-	Signature :
o	d clé privée et P = dG clé publique
o	G points de la courbe et ordre n sont connus
o	k aléatoire en 1 et n-1
o	kG point de coordonnées x,y
o	r = x mod n ( r sera connu du verifieur)
o	signature = (Hash + rd)/k mod n
-	Verification de signature :
o	w = 1/s
o	w.hash.G + w.r.P = Q (on vérifie xQ=R)

## refs

* Serious Cryptography de Jean-Philippe Aumasson (ISBN-13: 9781593278267)
* Crypto Dictionnay de Jean-Philippe Aumasson (ISBN-13: 9781718501409)
