# DAST Test and Fuzz with ZAP (OWASP Zed Attack Proxy)

utilisé en alternative de Burp (cf pentest) car gratuit

besoin du Java JDK sous windows (JRE ne suffit pas)

## Documentation

https://www.zaproxy.org/docs/desktop/start/
https://www.zaproxy.org/docs/desktop/addons/fuzzer/

## Fuzzing

Click droit sur la requete puis fuzz / generer du bruit

fichier -> charger un fichier des seclists
processeurs -> encoder son payload

# si plusieurs parametre

pour choisir l'ordre ou la combinaison des tests, generer soit meme la liste avec les combinaison

exemple pour les paramètres `bar` et `foo`, on injecte après `bar=` avec la wordlist suivantes:

```
1&foo=1
2&foo=2
3&foo=3
4&foo=4
5&foo=5
6&foo=6
7&foo=7
8&foo=8
9&foo=9
10&foo=10
```

## Tips

Intecrepter le requetes, bouton rouge puis click droit

.1 possibilité de les sauvegarder pour un passage à sqlmap
.2 possibilité de les rejouer manuellement
.3 attaquer pour les envoyer au au fuzzer (generer du bruit)
.4 selectionner du texte et envoyer vers encodeur/decodeur/hash



## Identifier les vulns:

Filtrer les resultats par

* taille
* reponse http (ex: 500)
* recherche / regex