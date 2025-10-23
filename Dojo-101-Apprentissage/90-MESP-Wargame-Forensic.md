# WarGame (Attaque / Défense) & Forensic

Vous êtes chargé de défendre votre VM et d'attaquer celles des autres groupes. Il faudra ensuite démontrer les attaques subies sur votre machine.

Poids: 5

> [!NOTE]
> Ce contenu est publié sous licence *GNU GENERAL PUBLIC LICENSE Version 3* et les sources sont sur le projet Github Dojo-101, merci d'en tenir compte dans vos usages.

## Ressources

* [Target Of Evaluation](https://github.com/Aif4thah/VulnerableLightApp)

* [Gestes professionnels](https://github.com/Aif4thah/Dojo-101)

* [réflexes incidents](https://www.cert.ssi.gouv.fr/les-bons-reflexes-en-cas-dintrusion-sur-un-systeme-dinformation/)

* [Éthique et cadre légal](https://github.com/Aif4thah/Dojo-101/blob/main/CODE_OF_CONDUCT.md)

* [Interpol Guidelines](https://www.interpol.int/content/download/16243/file/Guidelines_to_Digital_Forensics_First_Responders_V7.pdf)

### Partie Forensic

## Contexte

Vous êtes des experts en sécurité informatique, engagés pour défendre une infrastructure sensible.

Votre mission est de défendre votre Machine tout en lançant des attaques sur celles de vos adversaires.

À l'issue une investigation légale sera menée sur la VM défendue.

## Modalités pédagogiques

### Partie Wargame

> [!WARNING]  
> Interdiction d'attaquer d'autres IP que celles transmises par les adversaires. Les hyperviseurs, les machines physiques, ainsi que les équipements réseau doivent rester intègres.

Binôme ou seul (au choix) :

0. Installer une VM Windows serveur dans un hyperviseur à jour, lui-même sur une machine physique de test, vierge de toutes données et à jour.

1. Téléchargez *VulnerableLightApp* sur votre VM et exposez-la sur le réseau du Lab : 

    * Choisissez un port TCP entre 80 et 3000 qui sera utilisé par l'application et n'en changez plus.
    * Le service doit être accessible aux autres groupes en permanence.
    * Le firewall est désactivé, l'antivirus est absent sous Linux ou configuré par défaut sous Windows, pas de WAF.
    * Créer un fichier `flag.txt` dans votre `$HOME`, qui contiendra un GUID (commande pwsh : `New-Guid`)

2. Sans modifier l'application, configurer l'OS pour être en mesure de détecter les attaques. Vous pouvez configurer les Logs, la stratégie d'audit, utiliser un IDS, un SIEM.

3. Communiquer votre IP, vos cibles (et la surface d'attaque) seront les IP adverses.

4. **Une fois que tout le monde est prêt**, hackez les machines adverses, tout en détectant les intrusions sur votre Machine. 

5. **À la fin de l'exercice**, Arrêt des machines et décompte des points

### Partie Forensic

0. À partir d'une procédure d'investigation légale que vous aurez déterminée. Copiez le Disque et collectez les éléments dignes d'intérêt (Artefacts) sur votre VM.

    * exemple 1 : Dumper la RAM et faire un DD du disque de la VM
    * exemple 2 : Copiez le dossier `/var/log` et les logs applicatifs

1. Identifier les attaques de vos adversaires (6 à 10 exploits)

2. Retracez-la `Timeline` des évènements

3. Comprendre ce qu'il s'est passé

4. Savoir quels applications, services et comptes utilisateur ont été compromis

5. Supprimer les VM.

## Modalités d'évaluation

> [!IMPORTANT]
> Chaque vulnérabilité ne peut être exploitée qu'une seule fois sur chaque VM

* Décompte des points :

  * Chaque détection d'intrusion rapporte **1 point**
  * Chaque connexion TCP/UDP `victime -> attaquant` déclenchée par un exploit rapporte **1 point**
  * Chaque création de fichiers pourtant le nom de l'attaquant sur la machine de la victime rapporte **2 points**
  * Chaque GUID du fichier `flag.txt` rapporte **3 points**
  * Une perte de disponibilité de votre service de plus de 30 secondes prouvée par un attaquant = **-10 points**

* Lecture des rapports d'activités et forensic.

## Livrables

* Pour la partie Wargame, rapport d'activité avec :

  * Le nombre de points revendiqué
  * Captures d'écran des traces des incidents de sécurité sur votre machine
  * Captures d'écran prouvant les exploitations réussies sur les machines adverses

* Partie Forensic, rapport d'investigation avec :

  * Hashs des éléments analysés
  * Timeline des actions menées
  * Preuves / traces des compromissions découvertes.

## Critères de performance

* Score final au Wargame

* Découvertes des attaques et reconstitution de la timeline pour la partie forensic

## Pour finir

Si vous avez apprécié ce cours et souhaitez valoriser votre travail, n'hésitez pas à ajouter une ⭐ au [projet](https://github.com/Aif4thah/Dojo-101)