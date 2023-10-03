# DOJO-101

[![License: GNU GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/Aif4thah/Dojo-101/pulls)

## Base de connaissances et procédures de cybersécurité

* [Développement sécurisé](https://github.com/Aif4thah/Dojo-101/tree/main/Dojo-101-DevSec)
* [Administration sécurisée](https://github.com/Aif4thah/Dojo-101/tree/main/Dojo-101-SecOps)
* [Pentest](https://github.com/Aif4thah/Dojo-101/tree/main/Dojo-101-Pentest)
* [Forensic](https://github.com/Aif4thah/Dojo-101/tree/main/Dojo-101-Forensic)
* [Radiofréquences](https://github.com/Aif4thah/Dojo-101/tree/main/Dojo-101-RF)

## Avis de non-responsabilité

Les informations de ce projet sont partagées afin d'assurer la transparence de **prestations professionnelles** et le respect des **licences open sources**. L'utilisation de ces informations et outils reste sous l'entière responsabilité de la personne physique ou morale qui les met en oeuvre, notamment concernant le **respect du cadre légal et la maitrise des actions réalisées**.

*Autrement dit, la cybersécurité, comme toutes sciences, appartient à tous. Mais attention, le risque d'enfreindre la loi et de causer des dommages est élevé. Les **tests de sécurité et les émissions radio** sont **strictement règlementés**, y compris pour des projets éducatifs. Renseignez-vous avant toute utilisation et restez vigilant!*

En cas de doute, voici une liste non exhaustive de ressources:

* [ANSSI](https://www.ssi.gouv.fr/)
* [ANFR](https://www.anfr.fr/accueil)
* [Légifrance](https://www.legifrance.gouv.fr/)

## Disclaimer

This repository, together with its tools, is provided by Taisen-Solution on an “as is” basis. Taisen-Solution makes no representations or warranties of any kind, express or implied, as to the operation of the information, content, materials, tools, services and/or products included on the repository. Taisen-Solution disclaims, to the full extent permissible by applicable law, all warranties, express or implied, including but not limited to, implied warranties of merchantability and fitness for a particular purpose.

## Usage

![demo](./demo.gif)

1. télécharger le projet
2. Ouverture du répertoire entier dans un éditeur de texte moderne (ex: `VScode`)
3. rechercher par mots clé dans l'ensemble des fichiers (ex: `basics`, `windows`, `linux`)
4. visualiser le contenu au format html (`ctrl`+`shift` +`V`)

## Script d'installation

```powershell
winget install git.git
git clone https://github.com/Aif4thah/Dojo-101.git
code .\Dojo-101\
```

## Antivirus

Ce projet contient des signatures pouvant entrainer des faux positifs. Vous pouvez laisser votre AV faire le ménage, au détriment des informations contenues dans les fichiers supprimés, ou mettre en place une exclusion.

## Mise à jour

Le contenu est mis à jour régulièrement, pensez à faire un `git pull` avant de l'utiliser.

## Contributions

Pour contribuer, dites "comment vous avez fait", pas "comment il faut faire"

* [Fork](https://docs.github.com/fr/get-started/quickstart/fork-a-repo)
* Ajout du contenu au format Markdown/Text/Scripts - Keep It Simple Stupid
* [Pull request](https://docs.github.com/fr/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)

## ❤ Aidez-moi à garder Dojo-101 libre et open source

* [Ethereum donation](https://etherscan.io/address/0xcC424e30Ff6eEAb4E6B3A900c5446038F858b314)
* [Buy me a coffee](https://www.buymeacoffee.com/taisensolutions)

# Méthode de fork puis envoie PR (pull request)

D'après la documentation de GitHub **https://docs.github.com/fr/get-started/quickstart/fork-a-repo?tool=cli&platform=windows** ainsi que **https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork**.

* Installer l'application `https://cli.github.com/`

* S'authentifier avec la commande `gh auth login`

* Créer le fork avec la commande `gh repo fork [URL du dépôt à forker]`

```
Pendant la procédure de fork, répondre "yes" à la demande de clonage local pour avoir une copie locale en même temps que le fork est créé.
```

* Effectuer les modifications désirées dans votre éditeur de code, enregistrer le fichier avec les modifications.

