# Cryptographie basics

## Chiffrement symétrique

### Principe

Lorsque le chiffrement symétrique est mis en œuvre, la même clé permet de chiffrer et déchiffrer. Ce type de chiffrement est généralement utilisé pour la confidentialité des informations.
 
### Algo

* 3DES (obsolète)
* Rijndael, AES

En complément de l'algo, les modes de chiffrement doivent être choisis avec soin.

### Use case

* Chiffrement de données
* Pour la mise en œuvre de chiffrement de surface, par exemple la mise en œuvre de la technologie Bitlocker
* Lors de revues liées aux choix de suites cryptographiques (dont TLS)

### exemple

/!\ Attention: contrairement à la clé, les IVs ne doivent pas être réutilisés. Ce script est utilisé à titre éducatif et n'est pas là pour garantir la confidentialité d'échanges en production.

en python

```bash
pip install cryptography
```

```python

import base64
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend
import secrets

# Chiffrer une chaîne de caractères
def chiffre_message(cle, iv, message):
    padder = padding.PKCS7(128).padder()
    message = message.encode()
    message = padder.update(message) + padder.finalize()
    cipher = Cipher(algorithms.AES(cle), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    ct = encryptor.update(message) + encryptor.finalize()
    return ct

# Déchiffrer un message
def dechiffre_message(cle, iv, ct):
    cipher = Cipher(algorithms.AES(cle), modes.CBC(iv), backend=default_backend())
    decryptor = cipher.decryptor()
    message = decryptor.update(ct) + decryptor.finalize()
    unpadder = padding.PKCS7(128).unpadder()
    message = unpadder.update(message) + unpadder.finalize()
    return message.decode()

k = secrets.token_bytes(32) # generation d'une cle AES
i = secrets.token_bytes(16) # generation d'IVs
c = chiffre_message(k,i,'test')
dechiffre_message(k,i,c)
```


en powershell:

```powershell

function Chiffrer-message
{
    param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string] $Message,

    [Parameter(Mandatory=$true, Position=1)]
    [System.Byte[]] $Key,
  
    [Parameter(Mandatory=$true, Position=2)]
    [Byte[]] $IVs
    )

    $AES = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $AES.Key = $Key
    $AES.IV = $IVs
    $AES.Mode = "CBC"
    $Encryptor = $AES.CreateEncryptor()
    $EncryptedBytes = $Encryptor.TransformFinalBlock([Text.Encoding]::UTF8.GetBytes($Message), 0, $Message.Length)

    return [BitConverter]::ToString($EncryptedBytes) -replace '-', ''
}


## déchiffrement

function Dechiffrer-message
{
    param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string] $EncryptedString,

    [Parameter(Mandatory=$true, Position=1)]
    [System.Byte[]] $Key,

    [Parameter(Mandatory=$true, Position=2)]
    [Byte[]] $IVs
    )

    $EncryptedBytes = [byte[]]::new($EncryptedString.Length / 2)
    for ($i = 0; $i -lt $EncryptedBytes.Length; $i++) {
        $EncryptedBytes[$i] = [Convert]::ToByte($EncryptedString.Substring($i * 2, 2), 16)
    }
    $AES = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $AES.Key = $Key
    $AES.Mode = "CBC"
    $AES.IV = $IVs
    $Decryptor = $AES.CreateDecryptor()
    $DecryptedBytes = $Decryptor.TransformFinalBlock($EncryptedBytes, 0, $EncryptedBytes.Length)
    return [Text.Encoding]::UTF8.GetString($DecryptedBytes)
}

[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes(($k = New-Object Byte[] 32)) # generation d'une cle AES
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes(($i = New-Object Byte[] 16)) # generation d'IVs
$msgchiffre = Chiffrer-message -Message "test" -Key $k -IVs $i
$msgchiffre
Dechiffrer-message -EncryptedString $msgchiffre -Key $k -IVs $i
```

## Chiffrement asymétrique :

### Principe 

Le chiffrement asymétrique est composé d’une clé privée et d’une clé publique. L’une pouvant déchiffrer ce que la seconde a chiffré. Ce type de chiffrement est généralement utilisé pour l’authentification et la non-répudiation. 

### Algo

* DSA
* RSA 
* ECDSA
 
### Use case

* La signature de documents, de code ou de message (dont certificats X509 en combinaison avec RSA/ECDSA, avec un secret pour les signatures HMAC pour les Tokens JWT etc...)
* Utilisé avec d'autres protocoles dans des suites cryptographiques (TLS, SSH, PGP…)
* Stockage des secrets

### exemple

Certificats X509:

```powershell
$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
New-SelfSignedCertificate @params
Set-AuthenticodeSignature .\test.ps1 ((Get-ChildItem cert:\CurrentUser\My -codesigning)[0])
gc .\test.ps1
```


## Hash (Condensats)

### Principe 

le condensat (ou hash), est obtenu grâce à opération mathématique à sens unique. Les algorithmes utilisés peuvent être MD5, SHA1 aujourd’hui obsolètes ou SHA2. 

### Algo

* SHA1, MD5 (obsolètes)
* SHA2, SHA3, SHA512

### Use case 

* Pour le stockage de secret, par exemple des mots de passe en base de données
* Utilisé avec d'autres protocoles dans des suites cryptographiques (HMAC, Oauth/JWT, TLS)

### exemple

#### hashage

en python

```python
import hashlib
hashlib.sha256('test'.encode()).hexdigest()
```


en powershell

```powershell
Get-FileHash -Algorithm SHA512 <fichier>
```

#### Signature à base de hashs

en python:

```python
import hashlib
import hmac
secret = b"<secret>"
msg = "<message to sign>"
(hmac.new(secret, msg.encode(), hashlib.sha256)).hexdigest()
```

en powershell:

```powershell
$secret = "<secret>"
$message = "<votre message"
$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secret)
$signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($message))
$signature = [Convert]::ToBase64String($signature)
write-host -ForegroundColor Cyan $signature
```



## Génération d'aléas

| Caractéristique | RNG (Random Number Generator) | PRNG (Pseudo Random Number Generator) |
|----|----|----|
| Source d'entropie | Externe | Interne |
| Prédictibilité | Impossible | Possible |
| Uniformité | Uniforme | Uniforme si "seed" correcte |
| Sécurité | Idéal | Non-Idéal |

### Le niveau d’exigence est élevé 	

Je me réfère aux référentiels d’audits, aux guides ANSSI et à la qualification (critères communs) du produit utilisé.
Je m’assure que mon travail soit complété par une démarche d’homologation ou de certification appropriée.

### Le niveau d’exigence est modéré

Le premier niveau de contrôle concerne le respect des cas d’usage et la détection de vulnérabilités publiques présentes dans les librairies utilisées. 

Le code de l’application, lorsque disponible, peut ensuite être passé en revue. Je peux alors être amené adresser des recommandations à partir des éléments suivants :

* La vérification à partir de la documentation que le « pseudo random number generator » (PRNG) est bien conçu pour un usage cryptographique (non prédictible).

* La vérification à partir de la documentation que le PRNG est appelé avec la bonne configuration et avec les contrôles de sécurité adéquats.

* L’absence de comportement biaisé, par exemple la valeur de « seed » fixe lors de l’appel à un DRNG (Deterministic RNG).

* Le calcul théorique de l’entropie obtenue en bits log2(possibilités d’un élément / nombre d’éléments)

* Dans une moindre mesure : les sources de l’entropie utilisées par le « random number génération » (RNG). Dans le cas du mouvement de la souris, il faudra s’assurer de son mouvement. Dans le cas d’écriture disque, prendre en compte la machine utilisée, etc.

## attaques

| Type | Description |
|------|-------------|
| Cypher text attack | L’auditeur à accès au message chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. Il s’agit du cas le plus fréquent. |
| Choosen plaintext attack | L’auditeur peut définir le contenu du message en clair chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. |
| Known plaintext attack | L’auditeur connait le contenu du message en clair chiffré et a pour objectif de trouver la clé de chiffrement à partir de cet élément. |


# exemple de chiffrement post-quantique

[SPHINCS+ pypcx](https://github.com/sphincs/pyspx)

```python
import pyspx.shake_128f as sphincs
import secrets

# Key generation
seed = secrets.token_bytes(sphincs.crypto_sign_SEEDBYTES)
public_key, secret_key = sphincs.generate_keypair(seed)

# Sign message and verify
message = b"<message>"
signature = sphincs.sign(message, secret_key)
sphincs.verify(message, signature, public_key)
```
