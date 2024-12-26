# Notes JIRA:

## indicateurs

Pour les indicateur se rendre dans le menu dashbord de JIRA, crééer un nouveau Dashboard et selectionner les gadgets (ex: Graphique Circulaire)
(par défaut on ne voit rien, il faut cliquer sur "Charger tous les gadgets" )

Les queries doivent etre enregistrées dans "gérer les filtres." c'est pourquoi il faut faire ses filtres JQL avant de gérer les Graphs et indicateurs

Avec le graph un ou plusieurs critères sont choisis en plus des queries (exemple: trier par criticité/priorité, par projets etc...)

## JQL

Se rendre dans ticket et faire une recherche avancée.
(La quantité de tickets retournés est affichée à droite, l'export Excel est possible)

## tous les ticket du projet DD avec des status spécifique qui me sont attribués:

```jql
project = DD AND status in (Ouvert, "In Progress", Réouvert, "Being Analyzed", Suspendu, "To be done", "A planifier", "Fin de recette sécu", Reportée, "Attente décision Métier", "Attente Environnement Opérationnel") AND assignee in (currentUser()) 
```

## toutes les failles de sécurité non cloturée avec le status critique

```jql
issuetype = "Faille de Sécurité" AND status != Clôturé AND priority = Critical
```
