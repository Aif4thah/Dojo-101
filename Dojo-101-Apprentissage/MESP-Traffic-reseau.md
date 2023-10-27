# Analyser la sécurité du trafic réseau

Analyse du trafic à l'aide de Wireshark

Durée: 1.5 jours

Ce contenu est publié sous licence "GNU GENERAL PUBLIC LICENSE Version 3" et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte d'en vos usages.

## Ressources

[Wireshark](https://www.wireshark.org/download.html)
[Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

## Contexte

Il vous est demandé de procéder à l'analyse des protocoles utilisés sur le réseau et de détecter d'éventuelles faiblesses.

à partir du Lab installé, ajouter les services nécessaires et répondre aux questions suivantes 

0. Quels sont les flags TCP ? 
1. Capturer le processus DORA du protocole DHCP
2. qu’est ce que le DHCP Starvation / snooping ? Rogue DHCP ?
3. Que ce passe lors du « ipconfig /release » (windows) ? D’un point de vue sécurité quel peut etre l'enjeu ? 
4. Quelle fonctionnalité propose CISCO pour se prémunir de ce type d’attaque ? 
5. Capturer une requête DNS et sa réponse
6. Qu’est-ce que le DSN Spoofing ? Comment s’en protéger ?
7. Qu’est-ce que DNS Sec ? DNS over TLS / HTTPS ?
8. Dans quels cas trouve-t-on du DNS sur TCP ?
9. Capturer un flux HTTP
10. Qu’est-ce que le HTTP Smuggling ? Donner un exemple de CVE
11. Comment mettre en place la confidentialité et l'authenticité pour HTTP ?
12. Qu’est-ce qu’une PKI ?
13. Capturer un mot de passe HTTP ou FTP ou Telnet (mettre en place les services si nécessaire)
14. Comment mettre en place la confidentialité pour ce service ? 
15. Capturer un handshake TLS
16. Déchiffrer le trafic TLS avec votre certificat et/ou votre clé de session
17. Qu’est-ce qu’une autorité de certification (AC) racine ? Qu'est qu'une AC intermediaire ?
18. Connectez-vous sur https://taisen.fr et affichez la chaine de confiance du certificat
19. Capturer une authentification Kerberos (mettre en place le service si nécessaire)
20. Capturer une authentification RDP (mettre en place le service si nécessaire)
21. Quelles sont les attaques connues sur NetLM ?
22. Capturer une authentification WinRM (Vous pouvez utiliser EvilWinRM si nécessaire côté client.)
23. Capturer une authentification SSH ou SFTP (mettre en place le service si nécessaire)
24. Intercepter un fichier au travers du protocole SMB
25. Comment proteger l'authenticité et la confidentialité d'un partage SMB ?


## Modalités pédagogiques

Binôme ou seul (au choix)

## Modalités d'évaluation

Lecture du livrable

## Livrables

Réponse aux questions avec captures décran des captures Wireshark et de la chaine de confiance du certificat

## Critères de performance

Pertinence et justesse des réponses

