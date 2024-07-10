# Implémenter une baseline sur une machine Windows

Savoir protéger ses informations sur sa machine personnelle Windows

Durée estimée: 2 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [MSCT](https://learn.microsoft.com/fr-fr/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10)
* [auditpol](https://learn.microsoft.com/fr-fr/windows-server/administration/windows-commands/auditpol)
* [MS Security Blog](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/bg-p/Microsoft-Security-Baselines)
* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

## Contexte

Un de vos collaborateurs par à l'étranger et il vous est demandé de lui fournir une machine vierge de toute donnée, 
bénéficiant d'un niveau de sécurité acceptable afin qu'il puisse consulter ses mails sur Office 365 durant son déplacement.


## Modalités pédagogiques

0. Installer une Machine Windows (VM) cliente et ne **PAS** joindre l'Active Directory.

1. Configurer **auditpol** pour logger les erreurs d'authentification et les escalades de privilèges

2. Prouver la bonne configuration d'auditpol en retrouvant les événements dans les logs

3. Lire la documentation **Microsoft Security Compliance Toolkit** et télécharger la version correspondante à vote OS.

4. Se documenter sur **LGPO** et comparer votre GPO actuelle à celle recommandée grâce à **PolicyAnalyzer**.

5. Comprendre puis exécuter la baseline correspondante (script fourni) à votre OS.

6. Vérifier la configuration avec **PolicyAnalyzer**

7. Activer le chiffrement de surface (**bitlocker** recommandé)

8. Renforcer la configuration **Antivirus** à l'aide de powershell (le niveau de sécurité doit etre supérieur à celui par défaut)

9. Votre configuration **Auditpol** initiale est elle persistante ? Pourquoi ?


## Modalités d'évaluation

Lecture des livrables

## Livrables

1. Comparatifs `PolicyAnalyzer` avant et apres le durcissement.
2. Résultat de la commange `Get-BitLockerVolume`
3. Résultat de la commande `Get-MpPreference`
4. Résultat de la commande `auditpol.exe /get /category:*` 
5. Captures des logs (ou resultat powershell) avec échec d'authentification et escalade de privilèges

## Critères de performance

Pertinence des mesures de sécurité et concision de la procédure

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)