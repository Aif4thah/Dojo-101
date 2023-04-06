# Demodulation du signal

## avec SDR# (SDR Sharp)

### Son, sans chiffrement

* Sélectionner la source SDR et lancer l'analyse de spectre.
* Trouver la Fréquence d'émission (plan de frequences ou recherche sur spectrogramme)
* Jouer avec le Gain, Sample rate, Bandwith et le type de modulation 

    * `WFM` pour la `radio FM`, LNA 16dB, VGA 0, Sample Rate: 10 MSPS
    * `AM` pour les `grandes ondes`
    * `NFM`, `AM`, `LSB`, `USB`, `SSB`, etc. pour la voix sur les `communication non chiffrées`

* Activer les hauts parleurs et écouter, un filtre est disponible pour limiter le bruit

De temps en temps il faut supprimer et dézipper à nouveau les fichiers SDR# pour recuperer la conf par défaut.

### Plugins FMSuite

Permet de scanner automatiquement des plages de frequences

## Numérique

### Universal Radio Hacker

Permet de déchiffrer la data