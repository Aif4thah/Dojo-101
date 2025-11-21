# Forensic Windows

## Collecte d'Artefacts Windows

* [FASTIR](https://github.com/SekoiaLab/Fastir_Collector)

* [FIR](https://github.com/certsocietegenerale/FIR)

* [KAPE](https://www.kroll.com/en/insights/publications/cyber/kroll-artifact-parser-extractor-kape)

éléments d'interet :

* Journaux d’événement Windows (EVTX),

* Ruches de la base de registre,

* Logs d’anti-virus,

* Logs de pare-feu,

* Recherche d’Email suspect avec pièce jointe.

## Dump de la RAM

* [Winpmem](https://github.com/Velocidex/c-aff4/releases) Compatible avec Volatility.

```powershell
C:\winpmem_v3.3.rc3.exe --output memdump.raw --format raw --volume_format raw
```

* `Dumpit.exe`

* `NotMyFault.exe`

* `Windows` : système -> avancé -> sauvegarde et restauration -> vidage de la RAM

* [process hacker](https://processhacker.sourceforge.io/) On peut visualiser les process mais aussi directement lire les strings en ram etc : `click droit sur le process -> proprietés -> memory -> strings`

* `Sysinternals: procdump`

```powershell
C:\Users\Chase\Documents>.\procdump.exe -accepteula -ma <pid> 
.\procdump.exe -accepteula -ma 6800
```

## Logs Windows Event

### Outils de mise en forme des logs

* [sysmon](https://learn.microsoft.com/fr-fr/sysinternals/downloads/sysmon)

### Event ID

| Id | Description  | Log Name |
|----|--------------|----------|
| 4624 | Successful Logon | Security |
| 4625 | Failed Login | Security |
| 4673 | Sensitive Privilege Use | Security |
| 4776 | Successful /Failed Account Authentication | Security |
| 4720 | A user account was created | Security |
| 4732 | A member was added to a security-enabled local group |  Security |
| 4728 | A member was added to a security-enabled global group | Security |
| 7030 | Service Creation Errors | System |
| 7040 | The start type of the IPSEC Services service was changed from disabled to auto start. | System |
| 7045 | Service Creation | System |

### Logon Types

 | type | title | Description |
 |--|--|--|
 | 2 | Interactive | A user logged on to this computer.|
 | 3 | Network | A user or computer logged on to this computer from the network.|
 | 4 |  Batch | Batch logon type is used by batch servers, where processes may be executing on behalf of a user without their direct intervention.|
 | 5 | Service | A service was started by the Service Control Manager.|
 | 7 |  Unlock |  This workstation was unlocked.|
 | 8 | NetworkCleartext | A user logged on to this computer from the network. The user’s password was passed to the authentication package in its unhashed form. The built-in authentication packages all hash credentials before sending them across the network. The credentials do not traverse the network in plaintext (also called cleartext).|

### MS Office

outil d'analyse de macros :

* [oletools](https://github.com/decalage2/oletools)
* olevba
* oledump

## Dump de la SAM

```sh
crashdump2 SYSTEM SAM
```

## Dump de la clé Wifi

```powershell
netsh wlan show profile name="nom du ssid" key=clear
```
