# Intelligence artificielle et Machine learning - basics

> [!NOTE]
> L'IA évolue très vite et la mode est de faire abstraction du code, ci dessous quelques règles de base coté sécu : 

1. Toujours spécifier les limites et regles de sécurités dans `.agent/.rules.md` , validation humaines et règles pour interdire (limiter le risque dans les faits) les fuites
2. Limites les MCP au sctict nécéssaire
3. Limiter les dossiers de contexte et whitelister petit à petit les commandes autorisées


## ressources

* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-pour-un-systeme-dia-generative)
* [OWASP LLM TOP 10](https://genai.owasp.org/llm-top-10/)
* [CERT FR 2026 CTI](https://www.cert.ssi.gouv.fr/uploads/CERTFR-2026-CTI-001.pdf)

## Concepts

| Concept IA | définition |
|-------|------------|
| IA | simule l'intelligence humaine à partir du ML |
| ML | Machine learning, Apprentissage et modèles prédictifs / probabilistes |
| IA générative | Sous-ensemble axé sur la création de contenu (texte, image...) |
| LLM | Large Language Model, entrainé sur un large ensemble de données pour simuler un langage humain |
| SLM | Petit modèle de donnée |
| Data | Analyse et Statistiques |
| Word Embedding | Méthode de représentation des mots pour l’apprentissage automatique |
| RAG | Retrieval Augmented Generation, génération amélioré par récupération (stockage sous forme de vecteurs) |
| réseau neuronaux | moteur de l'IA |
| Token | fais souvent reference au découpage des mots - pas forcément à la sécu |

## Cycle de vie

1. Entrainement : création du modèle, affinage, tests, etc.
2. Déploiement : **Test et Audit de sécurité**, build, intégration, mise en prod
3. Production : MCO/MCS (Maintien en conditions opérationnelles et de sécurité)

### Principe du Word Embedding

* Initialisation: Chaque mot unique dans le corpus de texte est associé à un vecteur de nombres aléatoires.
* Contexte: L’algorithme examine ensuite chaque mot dans le contexte des mots qui l’entourent dans le corpus.
* Ajustement: Les vecteurs sont ajustés de manière à ce que les mots qui apparaissent dans des contextes similaires aient des vecteurs plus proches les uns des autres.
* Résultat: À la fin de ce processus, chaque mot est représenté par un vecteur qui encode quelque chose de son sens.

## Apprentissages

L'Apprentissage se fait à partir d'une `knowledge base(KB)`:

* soit l'IA réapprends totalement le KB
* soit on untilise le `fine tuning` pour mettre à jour le KB

## Attaques et vulnérabilités

* Porter atteinte aux Critères D.I.C.T.
* Injection de requêtes, directement dans le prompt ou via un contenu externe (sites et fichiers malveillants).
* Injections classiques (Saisies utilisateurs non nettoyées, XSS, CSRF prompt injection, etc.).
* Infection,  corruption du modèle, data poisonning, Injection de contexte. Par exemple : faire lire au serveur le contenu d'un fichier sensible ou malveillant qui sera ajouté au modèle et modifiera les réponses de l'IA.
* Manipulation du modèle / fonctionnalité non prévue. Par exemple faire compléter des mots ou des listes, jusqu'a obtenir des informations ou un comportement non prévu par le modèle.
* Fuite de données sensibles ou protegées du fait du Modèle ou de l'absence de restriction.

### protection du modèle pour des requêtes éfficaces

* Informer de spécificité de la mission / requete
* Préciser `répondre/agir en tant que <metier> ou <outil de traduction python vers .NET>`
* rester en anglais :  `act as <...>`
* Donner des tâches `1. <...>, 2. <...>, 3. <...>`
