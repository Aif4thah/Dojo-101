# Git and Github Basics

## Definitions

* VCS : version control system 
* SCM : software configuration management
* Fork : copie du repo coté serveur


## rechercher depuis la barre github

* Opérateurs: `OR, AND, NOT`
* Repo: `repo:Aif4thah/Dojo-101 windows`
* User: `user:Aif4thah`
* Owner: `owner:Aif4thah`

### exemples:

* `is:open is:issue assignee:@me` : Open issues assigned to the current user (@me)
* `is:closed is:pr author:contoso`: Closed pull requests created by @contoso
* `is:pr sidebar in:comments` : Pull requests where "sidebar" is mentioned in the comments
* `is:open is:issue label:bug -linked:pr` : Open issues labeled as bugs that do not have a linked pull request

## Type de compte

* Personal
* Organization
* Enterprise

### plans

* GitHub Free for personal accounts and organizations
* GitHub Pro for personal accounts
* GitHub Team
* GitHub Enterprise

[more info here](https://learn.microsoft.com/en-us/training/modules/github-introduction-products/2-what-are-github-products)

## Features générales

* Copilote (IA)
* CodeSpace (VM & storage lié à une extension de l'éditeur)
* Projects (Boards (Kanban), Data, Insight (Indicateurs), Automation (API, Github Actions))
* InnerSource -> application des pratiques OpenSource sur des dépots privés d'entreprises

## Features de Securité

* PSSI dans `SECURITY.md`
* **Security advisories** pour discuter ou corriger une vuln
* `.gitignore` pour ne pas commit de fichiers sensibles
* **Branch protection rules**
* fichiers `CODEOWNERS` pour déterminer des responsable à la racine du repo ou `.github` ou dossiers `docs`
* Scan des dépendances (dependabot)
* Scan du code (CodeQL)
* Scan des secrets 

## Authentification

* Login / passwd
* Token (PAT : *personal access token*)
* SSH keys
* Deploy key (SSH single repo)

* 2 Factors (TOTP)
* SAML SSO (with SCIM *System for Cross-domain Identity Management* and a Identity Provider (IdP) )
* LDAP

## Trunk-based development workflow

* Create a branch
* Add commits
* Open a pull request
* Code review
* Deploy
* Merge

## repo permissions level

* Read : Recommended for non-code contributors who want to view or discuss your project. This level is good for anyone that needs to view the content within the repository but doesn't need to actually make contributions or changes.
* Triage : Recommended for contributors who need to proactively manage issues and pull requests without write access. This level could be good for some project managers who manage tracking issues but don't make any changes.
* Write : Recommended for contributors who actively push to your project. Write is the standard permission for most developers.
* Maintain : Recommended for project managers who need to manage the repository without access to sensitive or destructive actions.
* Admin : Recommended for people who need full access to the project, including sensitive and destructive actions like managing security or deleting a repository. These people are repository owners and administrators.

[more info](https://learn.microsoft.com/en-us/training/modules/github-introduction-administration/4-how-github-organization-permission-works)



## Commandes de base

```bash
git status
git add # start keeping track of changes in certain files
git commint # save your work to a snapshot
git log
git help
```

## commandes de configuration, commit et push

```bash
git config --global user.email <mail>
git config --global user.name <mail>
git add *
git commit -m "update MM-YYYY"
git push origin main
```

## Lister les branches

```bash
git branch
```

## afficher l'historique d'un fichier

```bash
git blame
```

## créer une pull request:

Cliquer sur le bouton `fork` via l'interface Web, on obtient un fork sous la forme

`https://github.com/<YourUserName>/demo`

cloner ensuite votre fork pour travailler:

```bash
git clone https://github.com/<YourUserName>/demo
```

Une fois les changements `commit` et `push`, utiliser le bouton `Compare & pull request button` sur Github

## Hooks

/!\ d'un point de vue sécu, les hooks peuvent permettre des actions malveillantes et doive être contrôlés

Stockés dans `.git/hooks`, exécute du code avant ou après un événement cible

Shebang sous windows: `#!C:/Program\ Files/Git/usr/bin/sh.ex`

Un hooks n'est pas commit par défaut, il faut utiliser les paramètres globaux

```shell
Git config --global core.hooksPath '~/.githooks
```

Si pbm avec les hooks

```shell
Git commit --no-verify
```

## Suppression de l'historique (perfectible)

```sh
git checkout --orphan latest_branch
git add -A
git commit -am "Init" 
git branch -D main # suppression
git branch -m main # renommage de la branche en main
git push -f origin main #push vers la branche main
git gc --aggressive --prune=all # supression des anciens fichiers
```