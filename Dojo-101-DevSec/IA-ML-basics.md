# Intelligence artificielle et Machine learning - basics

> [!NOTE]
> L'IA évolue très vite et la mode est de faire abstraction du code, ci-dessous quelques règles de base coté sécu et gestion d'agents : 

1. Toujours spécifier les limites et règles de sécurité dans `.agent/.rules.md` : validation humaine et règles pour interdire (limiter le risque dans les faits) les fuites
2. Limiter les MCP au strict nécessaire
3. Limiter les dossiers de contexte et whitelister petit à petit les commandes autorisées
4. Exclure systématiquement les fichiers sensibles (`.env`, secrets, builds, logs) via un fichier d'exclusion dédié
5. Gérer le cycle de vie des conversations : ne pas laisser un thread s'éterniser pour éviter la pollution de contexte et la dérive de l'agent


## ressources

* [Guide ANSSI](https://cyber.gouv.fr/publications/recommandations-de-securite-pour-un-systeme-dia-generative)
* [OWASP LLM TOP 10](https://genai.owasp.org/llm-top-10/)
* [CERT FR 2026 CTI](https://www.cert.ssi.gouv.fr/uploads/CERTFR-2026-CTI-001.pdf)
* [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)

## Concepts

| Concept IA | Définition |
|---|---|
| IA | Simule l'intelligence humaine à partir du ML |
| ML | Machine Learning, apprentissage et modèles prédictifs / probabilistes |
| IA générative | Sous-ensemble axé sur la création de contenu (texte, image, code...) |
| LLM | Large Language Model, entraîné sur un large ensemble de données pour simuler un langage humain |
| SLM | Small Language Model, modèle plus léger adapté aux tâches ciblées ou au local |
| Data | Analyse et statistiques |
| Word Embedding | Méthode de représentation vectorielle des mots pour l’apprentissage automatique |
| RAG | Retrieval Augmented Generation, génération augmentée par récupération (stockage sous forme de vecteurs) |
| Réseau de neurones | Moteur de l'IA |
| Token | Unité de base de traitement du texte (mots, syllabes ou caractères) — coût et limite de contexte |
| Context Window | Quantité maximale de tokens que le modèle peut traiter en mémoire à un instant T |
| MCP | Model Context Protocol, protocole standard pour connecter l'agent à des outils et données externes |

## Fichiers de configuration et cadrage (Agents / IDE)

Pour piloter et sécuriser un agent local sans saturer son contexte :

* **`.agentignore` (ou `.aiignore`) :** bloque l'indexation des secrets (`.env`), des dépendances (`node_modules`) et des builds lourds (`dist`, logs).
* **`.agent/.rules.md` :** instructions système persistantes, contraintes de sécurité, style de code et actions interdites.
* **`ARCHITECTURE.md` :** vue d'ensemble technique, flux de données autorisés et patterns imposés dans le projet.
* **`SCRATCHPAD.md` :** bloc-notes temporaire partagé avec l'agent pour suivre l'état d'un refactoring complexe sans surcharger l'historique du fil.
* **`mcp.json` :** déclaration et restriction des outils/serveurs externes mis à disposition de l'agent.

## Cycle de vie

1. Entraînement : création du modèle, affinage, tests, etc.
2. Déploiement : **Test et Audit de sécurité**, build, intégration, mise en prod
3. Production : MCO/MCS (Maintien en conditions opérationnelles et de sécurité)

### Principe du Word Embedding

* **Initialisation :** Chaque mot unique dans le corpus de texte est associé à un vecteur de nombres aléatoires.
* **Contexte :** L’algorithme examine ensuite chaque mot dans le contexte des mots qui l’entourent dans le corpus.
* **Ajustement :** Les vecteurs sont ajustés de manière à ce que les mots apparaissant dans des contextes similaires aient des vecteurs plus proches les uns des autres.
* **Résultat :** À la fin de ce processus, chaque mot est représenté par un vecteur qui encode une partie de son sens sémantique.

## Apprentissages

L'apprentissage se fait à partir d'une `knowledge base (KB)` :

* Soit l'IA réapprend totalement la KB
* Soit on utilise le `fine tuning` pour spécialiser le modèle sur la KB
* Soit on passe par du `RAG` pour interroger dynamiquement la KB sans réentraîner

## Attaques et vulnérabilités

* Porter atteinte aux critères D.I.C.T.
* Injection de requêtes (Prompt Injection), directement dans le prompt ou indirectement via un contenu externe (sites web, fichiers vérolés).
* Injections classiques (saisies utilisateurs non assainies, XSS, CSRF prompt injection, etc.).
* Infection, corruption du modèle, data poisoning.
* **Pollution de contexte et biais d'ancrage :** accumulation d'erreurs dans l'historique menant l'agent à s'obstiner dans une mauvaise direction.
* Manipulation du modèle / fonctionnalité non prévue (jailbreak, extraction d'instructions système).
* Fuite de données sensibles ou protégées du fait du modèle ou de l'absence de restriction de lecture locale.

## Bonnes pratiques : requêtes et gestion des agents

### Cadrage des requêtes

* Spécifier le contexte métier et la tâche : `répondre/agir en tant que <métier>` ou en anglais `act as <...>`
* Donner des contraintes claires et numérotées : `1. <...>, 2. <...>, 3. <...>`
* Préciser les contraintes négatives (ce qu'il **ne doit pas** modifier ou utiliser)
* Cibler les fichiers avec précision (`@src/fichier.ts`) plutôt que de laisser l'agent explorer tout le dépôt

### Commandes utiles pour l'Agent (Slash Commands)

L'utilisation de commandes permet de forcer le comportement de l'IA et d'éviter qu'elle ne code de manière chaotique. Si elles ne sont pas natives à ton outil, tu peux les utiliser comme mots-clés dans tes prompts.

* **/plan :** Force l'agent à se comporter en architecte. Il doit lister les étapes logiques d'un développement, les fichiers ciblés et les risques, sans écrire une seule ligne de code. Idéal pour amorcer une tâche.
* **/explain (ou /ask) :** Oblige l'agent à expliquer un comportement, un fichier ou une erreur, en lui interdisant strictement de modifier ou générer du code.
* **/fix :** Demande à l'agent de se concentrer exclusivement sur la résolution d'une erreur ciblée (souvent accompagné d'un copier-coller des logs).
* **/test :** Limite le périmètre de l'agent à la génération de tests unitaires ou d'intégration pour le composant ou le fichier ciblé.
* **/refactor :** Lance une session d'optimisation (clean code, renommage, factorisation) sans modifier le comportement fonctionnel de la cible. À utiliser souvent après un `/plan` validé.

### Hygiène des conversations (nouveau thread)

* **Règle d'or :** 1 tâche = 1 fil de discussion propre.
* Commiter le code fonctionnel avant d'ouvrir un nouveau fil.
* Couper court et relancer un fil dès que l'agent boucle ou échoue deux fois sur le même problème.
* Relancer un fil dès l'apparition de signaux de saturation (lenteur anormale, oubli des consignes de base, hallucinations).