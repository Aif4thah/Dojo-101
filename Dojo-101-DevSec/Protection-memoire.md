# protection de la mémoire


## cycles CPU vulgarisés

1. Déplacer l'EIP de la longueur de l'instruction
2. Exécuter l'instruction
3. Lire l'instruction pointée par l'EIP
retour à 1


## SSP (Stack-Smashing Protector) ou “canary”

### Description 

Valeur qui ne peut être modifiée sous peine d’arrêter le programme. 

### Contournement

Réécrire cette valeur à l’identique



## ASLR (Address Space Layout Randomization)

### Description 

La distribution aléatoire de l'espace d'adressage a pour effet de faire varier les adresses à chaque exécution du programme.

### Contournement

Certaines librairies ne sont parfois pas supportées pour l’ASLR, ainsi certaines instructions peuvent être utilisées (exemple : JMP ESP)

Les adresses peuvent être trouvées par force brute 

Ne réécrire que partiellement l’EIP, en « little indian » et rechercher le shellcode ou une instruction utile



## DEP (Data Execution Prevention)

### Description 

Prévention de l’exécution des informations sur la pile

### Contournement

Utilisation des techniques de « ROP chain »

Il existe certaines vulnérabilités connues (exemple : l’utilisation de la librairie libc).
