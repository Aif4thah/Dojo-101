# Communiquer en mode dégradé (morse / Software Defined Radio )

Communication en Morse et Cryptographie : initiation au chiffrement des communications. 

Poids: 1

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* `Dossier Toolbox RF`

* [POC CW](https://github.com/Aif4thah/SecCW)

* [HackRF](https://greatscottgadgets.com/hackrf/one/)


## Contexte

> [!CAUTION]
> Utiliser le LaNa peut endommager le SDR, Utiliser le **DC BLOCKER Obligatoirement** entre le SDR et l'ampli !

Protéger et échanger des messages confidentiels en Morse sur les ondes radio.

## Modalités pédagogiques

* Binôme

### étape 1

1. Équipe 1 et 2 : créer ensemble une clé de chiffrement (ex: AES256)

### étape 2

2. Équipe 1 : Chiffrer son message

3. Équipe 1 : Transformer son message (*une question de votre choix*) en code morse dans un fichier `CS8` (IQ)

4. Équipe 1 : L’envoyer à l’aide du HackRF à votre correspondant

### étape 3

5. Équipe 2 : Recevoir le code morse (capture CS8 du HackRF ou SDR#)

6. Équipe 2 : Déchiffrer le message

7. Équipe 2 : Chiffrer le message contenant votre réponse et le convertir en code morse dans un fichier `CS8` (IQ)

8. Équipe 2 : L’envoyer à l’aide du HackRF à votre correspondant

### étape 4

9. Équipe 1 : Recevoir le code morse (capture CS8 du HackRF ou SDR#)

10. Équipe 1 : Déchiffrer le message



## Modalités d'évaluation

* présentation ou Livrable


## Livrables

* screenshots


## Critères de performance

* réussite


# Hardware

* HackRF
* Hub et adaptateur USB

*NB : Si vous n'avez pas de HackRF, envoyez-vous directement les fichiers CS8*


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)
