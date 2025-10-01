# Utiliser un reverse shell

Poids: 1

> [!NOTE] 
> Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.


## Ressources

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [reverse shell generator](https://www.revshells.com/)

* [Shellcode db](https://www.exploit-db.com/shellcodes)

* [TOE : VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp/tree/main)

## Contexte


## Modalités pédagogiques

Binôme ou seul (au choix)

> [!WARNING]
> Attention à bien distinguer ReverseShell != Shellcode

> [!TIP]
> Pour plus de réalisme, *VulnerableLightApp* permet d'exploiter des vulnérabilités via ReverseShells et de ShellCodes.

1. Télécharger "netcat"

2. Lancer votre serveur

3. Connecter une victime

4. Commander votre première victime

5. Commander 2 victimes simultanément

6. Recommencer avec un `reverseShell` en bash

7. Recommencer avec un `reverseShell` en python

8. Recommencer avec un `reverseShell` en powershell

9. Recommencer avec un `reverseShell` que vous avez développé/modifié vous-même pour ne pas être vu par l'Anti-virus (Rust, Java, C# etc...)

10. Développez votre `ShellCode` ou prenez-en un sur internet, chargez-le avec un `Loader` approprié pour obtenir un Shell une la machine victime malgré la présence de l'Antivirus.

11. Si ce n'est pas déjà fait, utiliser un `reverseShell` et un `ShellCode` pour prendre le contrôle de *VulnerableLightApp*.

## Modalités d'évaluation

* Vérification des screenshots et relecture du code

## Livrables

* Screenshot de chaque `reverseShell`

* Code du `reverseShell` 

* ShellCode avec loader et documentation

## Critères de performance

*Furtivité* : Un bon `reverseShell` doit être capable de se cacher efficacement pour éviter la détection par les systèmes de défense de l’hôte, tels que les antivirus et les pare-feu.

*Stabilité* : Il doit être capable de maintenir une connexion stable avec l’attaquant, même en cas de conditions réseau défavorables. Il doit également être résilient face aux redémarrages du système.

*Fonctionnalités* : Un bon `reverseShell` doit offrir un ensemble complet de fonctionnalités qui permettent à l’attaquant d’exécuter des commandes à distance, de télécharger et d’uploader des fichiers, et d’effectuer d’autres actions sur le système cible.


## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)