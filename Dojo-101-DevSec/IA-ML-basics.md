# Intelligence artificielle et Machine learning - basics

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

## libs et IA locales

* [Ollama](https://docs.ollama.com/)
* [PentestAgent](https://github.com/GH05TCREW/pentestagent)

## Mistral AI

* [site MISTRAL AI](https://mistral.ai/)
* [Le Chat Mistral](https://chat.mistral.ai/chat)
* API facturée à l'usage ou en auto hébergée. Abonement pour "Le chat".

## Claude

* [Claude](https://claude.ai/)

## Lumo - IA proton

* IA by Protonmail axée sur la protection de la confidentialité.
* [Lumo](https://lumo.proton.me/u/2/)
* [Privacy Policy](https://proton.me/support/lumo-privacy)

### Agent de pentest

* [KaliGPT - agent ChatGPT](https://chatgpt.com/)
* [Strix](https://www.strix.ai/)

### Misc

* [OpenClaw](https://openclaw.ai/)

### Copilot

* Info de session : `/id`

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

## Configuration de prompts

Exemple de prompt inspiré de [Zzoro](https://github.com/ZZ0R0/Auto-MySQL)

```python
import mysql.connector  # Connexion à MySQL
import openai           # Communication avec l'API OpenAI

# Clé API pour accéder à OpenAI (à remplacer)
openai.api_key = "api_Key"

# Connexion à MySQL (modifie selon ton environnement)
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password=passwd,
    database="ma_base")
cursor = mydb.cursor()

# Lecture de la structure d'une table
table_name = "clients"
cursor.execute(f"DESCRIBE {table_name}")
columns = cursor.fetchall()

# Création du prompt décrivant la table
prompt = f"La table '{table_name}' contient les champs suivants :\n"
for column in columns:
    prompt += f"- {column[0]} ({column[1]})\n"

# Ajout de la question de l'utilisateur
question = input("Quelle question veux-tu poser à propos de cette table ?\n")
prompt += f"\nQuestion : {question}\n"
prompt += "Donne-moi la requête SQL correspondante."

# Envoi à OpenAI
response = openai.Completion.create(
    engine="text-davinci-003",  # ou le moteur de ton choix
    prompt=prompt,
    max_tokens=150,
    temperature=0.5)

# ffichage de la réponse
sql_query = response.choices[0].text.strip()
print("\nRequête SQL générée :")
print(sql_query)
```
