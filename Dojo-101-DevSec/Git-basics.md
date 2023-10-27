# Git and Github Basics


## Trunk-based development workflow

* Create a branch
* Add commits
* Open a pull request
* Code review
* Deploy
* Merge

## Forking Worflow

* fork : copie du repo coté serveur

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