# Intelligence artificielle et Machine learning - basics


## Concepts

**Data** : Analyse et Statistiques
**Machine learning** : Apprentissage et modèles prédictifs / probabilistes
**IA** simule l'intelligence humaine à partir du ML
**Word Embedding** : éthode de représentation des mots pour l’apprentissage automatique


### Principe du Word Embedding

Initialisation: Chaque mot unique dans le corpus de texte est associé à un vecteur de nombres aléatoires.

Contexte: L’algorithme examine ensuite chaque mot dans le contexte des mots qui l’entourent dans le corpus.

Ajustement: Les vecteurs sont ajustés de manière à ce que les mots qui apparaissent dans des contextes similaires aient des vecteurs plus proches les uns des autres.

Résultat: À la fin de ce processus, chaque mot est représenté par un vecteur qui encode quelque chose de son sens.


### protection du model

* Informer de spécificité de la mission / requete
* Préciser `répondre/agir en tant que <metier> ou <outil de traduction python vers .NET>`
* rester en anglais :  `act as <...>`
* Donner des tâches `1 <...>, 2 <...>, 3 <...>`


## Chat GPT - OpenAI / Microsoft - Copilot

* Questions generalistes
* Faire vérifier un bout de code
* toujours besoin de vérifier les infos


### Github Copilot

* Disponible pour Visual Studio Code, Visual Studio, Neovim, JetBrains


## ML.NET - Technologie .NET pour le Machine Learning

* Pour les projets .NET / C#
* Repose sur ML builder (AutoML) qui facilite l'utilisation pour un projet simple
* On met en forme les données, et donne notre objectif
* la feature nous propose l'algorithme le plus adéquat


## Azure ML et Azure AI services

* ML -> permet notamment de publier une API à partir du modèle ML entrainé
* IA -> dont la recherche cognitive qui permet d'indexer et rechercher des données (notamment à partir de texte afin de sortir le sentiment global et les mots clés)
* Bots et applications C# / Python


## Mistral AI

* [site](https://mistral.ai/)
* API facturé à l'usage
* ou en auto-hébergé


