# Scan du code et des dépendances avec dependencyCheck - CHAMOULAUD Rémi

## Téléchargement de Dependency-Check

    1. Vous pouvez télécharger Dependency-Check ici : 
[owasp.org/www-project-dependency-check/](https://owasp.org/www-project-dependency-check/)

    2. Scroller puis cliquer sur "Command Line" dans la liste des liens à droite, un .zip sera alors téléchargé
    3. Déplacer ce .zip à l'emplacement souhaité

## Téléchargement du code du projet open source

    1. Une fois sur la page github de ce projet, sélectionner le bouton Code -> Download ZIP
    2. Extraire ce .zip à l'emplacement souhaité.

## Scan du code

### Récupérer la ligne de commande à exécuter

    1. Entrer comme URL "taisen.fr"
    2. Aller dans l'onglet Dojo-101 puis "Consulter le projet", vous allez être redirigés vers github.com
    3. Une fois sur la page github, aller dans le dossier "Dojo-101-DevSec"
    4. Scroller jusqu'à trouver le fichier "SAST-dependance-middleware", vous trouverez à la ligne 7 la commande à exécuter :

```powershell
.\dependency-check.bat --scan <fichier.jar ou lib folder> --out <output>
```

### Exécuter la commande

#### Dans PowerShell

    1. Se déplacer dans le dosser de Dependency-Check extrait précédemment (vous devez arriver au niveau de "dependency-check-7.4.1-release")
    2. Se déplacer maintenant au niveau du /bin soit :
```powershell
cd .\dependency-check\bin\
```

    3. Exécuter la commande vue précédemment :

```powershell
.\dependency-check.bat --scan <fichier.jar ou lib folder> --out <output>
```

Avec le nom du fichier .zip (exemple : 'fichier.zip') à la place du `<fichier.jar ou lib folder>` et à la place de `<output>` vous mettrez le nom du ficher dans lequel vous souhaitez que le rapport soit fait (en .html de préférence, exemple : rapport.html). La commande avec nos exemples donnerait alors :

```powershell
.\dependency-check.bat --scan '.\...votre chemin...\fichier.zip' --out rapport.html
```

    4. Le fichier rapport.html sera créé dans le /bin de Dependency-Check
    5. En exécutant ce fichier sur votre navigateur vous obtiendrez :
        - Le récapitulatif des informations de scan trouvées (version de dependency-check, dépendances scannées, vulnérabilité)
        - Le sommaire qui montrera les dépendances, le package, la sévérité, le compte de CVE et le compte des évidences (vous avez aussi la possibilité de voir uniquement les dépendances où des vuln sont détectées)
        - Le détail des dépendances soit principalement les evidences et les CVE trouvées ainsi que leur détail
