# python virtual env

Permets d'installer et maitriser ses dépendances avec pip

## creer

```bash
python -m venv venv
.\venv\Scripts\activate
pip freeze > requirements.txt
```

## (ré)installer localement

```bash
pip install -r requirements.txt
```

## retourner dans son venv

```bash
.\venv\Scripts\activate
```

## Upgrade des dépendances

```bash
pip install --upgrade -r requirements.txt
```

## préciser une version

contenu du fichier : `requirement.txt` 

```txt
Numpy == 1.24
```