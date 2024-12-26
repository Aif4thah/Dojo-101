# python virtual env

Permets d'installer et maitriser ses dépendances avec pip

## creer

```powershell
python -m venv venv
.\venv\Scripts\activate
pip freeze > requirements.txt
```

## installer localement

```powershell
pip install -r requirements.txt
```

## retourner dans son venv

```powershell
.\venv\Scripts\activate
```

## préciser une version dans le requirement.txt

exemple: 

```
Numpy == 1.24
```