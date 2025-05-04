# Initiation à la cryptographie et au Software Defined Radio (SDR)

Comment transmettre un message en mode dégradé, sans qu'il puisse être intercepté ?

Poids: 3

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [Guide ANSSI](https://cyber.gouv.fr/publications/mecanismes-cryptographiques)

* [POC CW](https://github.com/Aif4thah/SecCW)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)

* Amplificateur RF

* `Dossier Toolbox RF`


## Contexte

### Introduction 

0. Parmi ces algorithmes, lesquels sont de type symétrique, asymétrique, de Hashage ? Lesquels ne devraient plus être utilisés ? 

    * AES 256 avec mécanisme XTS
    * AES 128 avec ECB
    * 3DES
    * SHA2
    * SHA1
    * MD5
    * RSA avec OAEP
    * RSA avec PKCS1


### Partie SDR

> [!CAUTION]
> Utiliser le LaNa peut endommager le SDR, Utiliser le **DC BLOCKER Obligatoirement** entre le SDR et l'ampli !

Protéger et échanger des messages confidentiels en Morse sur les ondes radio. (Pour les cours sans SDR on s'échangera le fichier `CS8` contenant le signal radio)

#### étape 1

1. Équipe 1 et 2 : créer ensemble une clé de chiffrement (ex: AES256)

#### étape 2

2. Équipe 1 : Chiffrer son message

3. Équipe 1 : Transformer son message (*une question de votre choix*) en code morse dans un fichier `CS8` (IQ)

4. Équipe 1 : L’envoyer à l’aide du HackRF à votre correspondant

#### étape 3

5. Équipe 2 : Recevoir le code morse (capture CS8 du HackRF ou SDR#)

6. Équipe 2 : Déchiffrer le message

7. Équipe 2 : Chiffrer le message contenant votre réponse et le convertir en code morse dans un fichier `CS8` (IQ)

8. Équipe 2 : L’envoyer à l’aide du HackRF à votre correspondant

#### étape 4

9. Équipe 1 : Recevoir le code morse (capture CS8 ou SDR#)

10. Équipe 1 : Déchiffrer le message



### Partie générale


11. Comment pourrait-on s'assurer de l'intégrité du message et de l'authenticité du destinataire ? Proposer des algorythmes

12. le message suivant a été intercepté: `"prggr grpuavdhr f'nccryyr yr puvsserzrag qr prnfre, vy a'rfg cyhf hgvyvft nhwbheq'uhv, pne crh ftphevft"`, il semble vulnérable à une attaque en fréquences ou une attaque par force brute. Déchiffrez-le !

13. Nous suspectons qu'un adversaire a implémenté une backdoor dans notre logiciel de messagerie sécurisé, pourtant nous utilisons AES-CBC (extrait des logs ci-dessous). Trouvez ce qui ne convient pas dans le chiffrement de ces messages.

```txt
Bob: '>s\x06\x14\x0c\xa7\xa6\x88\xd5[+i\xcc/J\xf7'
Alice: "3\x01\xeb\xcah\xf6\x1f\xc2[\xf9}P'A\xe0\xd5"
Bob: '\xf7\xb0\xc5\xccO\xab&\xee\xa4&6N?V\xbd\x85\x94b\xee\xc5\x18\x1f9\xe7\xe5\xe0\xffyf\xab\xfb\xb9
Alice: '\xde@=\x1ed\xc0Qe\x0fK=\x1c\xb3$\xd9\xcb'
Bob: '\xce\xbf\x0e\\\x8aX\x1c \xb2v\x97\xf5<\x86M\x86\x0c\xa1j\xa0\xe6\xa9\x11\xf9AyZ\xda9\x94ec'
Alice: "\xde@=\x1ed\xc0Qe\x0fK=\x1c\xb3$\xd9\xcb"
Bob: '\xfb\x0cc\xb0/\xd4:\xde\xe7a\x95_L\x8d\x108\xac\xff\xcep\x8e&\xcfq6ym\x0c\xf6\xccI\xed'
Alice: '\xee\xcb\xd0\x9aRt;\x12\xca\xfe\r\x01MN>\xde'
Bob: '\xab\x8aX\xef\xd4\xf3\x88a\x1a\x96\r\xec\x17\xe6s"\x94\xec6\xe0\xff \x82\xa1\xb4\xe2\xc1\x08\r!T\x89\xe2B\x1d^\xf7l\xd8\xc9\xa4\xcd\xa5\x8e\xb3\x1d\x1f\xe7'
Alice: '\xee\xcb\xd0\x9aRt;\x12\xca\xfe\r\x01MN>\xde'
Alice: '\x1f\xafV4\xcb\x116N\xc5.\xa8\xdfM\xcf\xda\x02\x98\xbb\x04\x04C}N{\xf95\x05e\xc6\xf9\xbe,'
Bob: '\xde@=\x1ed\xc0Qe\x0fK=\x1c\xb3$\xd9\xcb'
```


14. Nous avons intercepté le message suivant: `b'\xd72U\xc03.\xda\x99Q\xb5\x020\xc4\xb8\x16\xc6\xfa-\xb9U+\xda\\\x126L\xf3~\xbd8\x12q\x02?\x80\xeaVI\xa9\xe1'`. 

La première partie de la **Clé de 16 octets** est: `b'12345678bien'` et l'algorithme utilisé est celui-ci:

```python
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend

def des_encrypt(key, plaintext):
    cipher = Cipher(algorithms.TripleDES(key), modes.ECB(), backend=default_backend())
    encryptor = cipher.encryptor()
    padder = padding.PKCS7(64).padder()
    padded_data = padder.update(plaintext) + padder.finalize()
    ct = encryptor.update(padded_data) + encryptor.finalize()
    return ct

def des_decrypt(key, ciphertext):
    cipher = Cipher(algorithms.TripleDES(key), modes.ECB(), backend=default_backend())
    decryptor = cipher.decryptor()
    pt = decryptor.update(ciphertext) + decryptor.finalize()
    unpadder = padding.PKCS7(64).unpadder()
    unpadded_data = unpadder.update(pt) + unpadder.finalize()
    return unpadded_data
```

Quel était le message transmis ?

### Partie Scripting

* Forker le projet `SecCW` et proposer un algorithme de chiffrement Post quantique. 

* Dans l'idéal, le message chiffré doit être le plus court possible.

* Proposer la modification via une `Pull Request`.


## Modalités pédagogiques

Binôme

## Modalités d'évaluation

Relecture des scripts

## Livrables

* Scripts

* Réponses aux questions

## Critères de performance

* Aquisition des notions en cryptographie

* Pertinence des solutions proposées


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)