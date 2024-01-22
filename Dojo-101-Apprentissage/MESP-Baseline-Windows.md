# Implémenter une baseline sur une machine Windows

Savoir protéger ses informations sur sa machine personnelle Windows

Durée estimée: 2 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

[MSCT](https://learn.microsoft.com/fr-fr/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10)
[auditpol](https://learn.microsoft.com/fr-fr/windows-server/administration/windows-commands/auditpol)
[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)
[Privesc bins](https://lolbas-project.github.io/)

## Contexte

Un de vos collaborateurs par à l'étranger et il vous est demandé de lui fournir une machine vierge de toute donnée, 
bénéficiant d'un niveau de sécurité acceptable afin qu'il puisse consulter ses mails sur Office 365 durant son déplacement.


## Modalités pédagogiques

0. Installer une Machine Windows (VM) cliente et ne **PAS** joindre l'Active Directory.

1. Utiliser auditpol pour logger les erreurs d'authentification et les escalades de privilèges

2. Prouver la bonne configuration d'auditpol en retrouvant les evenements dans les logs

3. Lire la documentation MSCT et le télécharger

4. Se documenter sur LGPO

5. Comprendre puis exécuter le script de durcissement

6. Vérifier la configuration avec PolicyAnalyzer

7. Activer le chiffrement de surface

8. Renforcer la configuration Antivirus

9. Votre configuration Auditpol initiale est elle persistante ? Pourquoi ?


## Modalités d'évaluation

Lecture des livrables

## Livrables

1. Comparatif des LGPO / GPO de la baseline avec celles appliquées à l'aide de l'outil `PolicyAnalyzer`
2. Résultat de la commange `Get-BitLockerVolume`
3. Résultat de la commande `Get-MpPreference`
4. Résultat de la commande `auditpol.exe /get /category:*` 
5. Captures des logs avec échec d'authentification et escalade de privilèges

## Critères de performance

Pertinence des mesures de sécurité et concision de la procédure

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajoutez une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)