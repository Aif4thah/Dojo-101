# Forensic

## Ressources

* [Interpol Guidelines](https://www.interpol.int/content/download/16243/file/Guidelines_to_Digital_Forensics_First_Responders_V7.pdf)

* [Cybermalveillance Collecte de preuve](https://www.cybermalveillance.gouv.fr/tous-nos-contenus/document-prestataire/guide-collecte-preuve)

## Avant intervention

1. Disposer du matériel adéquat : duplicateur (Hardware write blocker), appareil photo, softwares, etc.

2. Disposer des templates de document : timeline, rapport

3. Informer les parties prenantes et faire valider la méthodologie de conservation des preuves en vue d'un dépôt de plainte.

## Pendant intervention

1. Horodater chaque action sur la timeline.

2. Après collecte, toujours travailler sur les copies

## Collecte des preuves

```mermaid
flowchart TD
    A{Machine compromise}
    A --> |Si allumée| B[Isoler du réseau]
    B --> C[Dumper la RAM]
    C --> D[Déchiffrer le Disque]
    D --> E[Arret]
    E --> F[Copie du disque]

    A--> |Si éteinte|G[Ne pas allumer]
    G--> F
    F--> H(Investigation sur copies...)
```

## Copie du Disque

> privilégier la copie physique afin de garantir l'intégrité des preuves.

* Intérêt forensique de la copie intégrale (recherche d’artefacts),

* Interopérabilité des formats pour exploitation ultérieure (statique, dynamique, virtualisation),

* Admissibilité judiciaire, force probatoire et traçabilité (rapportde copie, hash).

* **Device to Device (clone)** : This can be performed by obtaining an exact bit-by-bit replica of an original device in another - previously wiped - device with equal or greater capacity.

* **Device to File (image)** : This can be performed by generating one or more files that contain, linked together, an identical copy of the original device. The most widespread is `DD` (`raw`) or `E01` formats

* Copie de mémoire vive (Dump de RAM) : nécessite un support de taille supérieure à celle de la RAM.

* à défaut de copie physique : Privilégier un format interopérable `AD1`.

## à défaut de copie : collecte d'artefacts (souches)

* Toujours mentionner les emplacements physiques / logiques des éléments découverts.

* calculer un hash

* Placer les éléments dans des fichiers .zip avec le mot de passe unique : « infected »

# A MINIMA, éléments à fournir aux services enquêteurs

*  Un ensemble de fichiers chiffrés (de types différents)

* La note de rançon dans tous ses formats (txt, hta, html, etc.)


## Calul d'integrité

```powershell
Get-FileHash -alg SHA256 .\Artefact.zip
```

## Ajouter le timestamp au prompt et sauvegarder la session : 

```powershell
function prompt {
    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
    "$timestamp PS > "
}
Start-Transcript -Path Artefacts/Timeline.txt
```
