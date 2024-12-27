# Android Forensics

## Ressources

* [ADB](https://developer.android.com/tools/releases/platform-tools)

* [MVT Mobile Verification Toolkit](https://github.com/mvt-project/mvt)

* [ALEAPP](https://github.com/abrignoni/ALEAPP)

* [Android Triage](https://github.com/RealityNet/android_triage)

* [Android Security Reference](https://github.com/doridori/Android-Security-Reference/tree/master)

## Structure du Système de fichier
 
| Chemin | Description |
|--------|-------------|
| /boot | Kernel |
| /system | ROM system et applications préinstallées|
| /data | données utilisateurs, dont contact et messages |
| /sdcard | données externes ou internes, fichiers multimédias et documents |
| /cache | Fichiers et données applicatives temporaires |
| /data | Données utilisateur |
| /data/data | Données des applications |
| /dev | Devices |
| /mnt/asec | applications chiffrées |
| /mnt/emmc | carte SD interne |
| /mnt/sdcard | carte SD externe |
| /proc | process |
| /recovery | pour le mode restauration |


## Type d'autorisations d'applications

* Installation : contient des autorisation normales et signature.
* Normales (protection `normal`)
* Signatures (protection `signature`)
* Execution (protection `dangerous`)
* Spéciales (protection `appop`)


## Procedure

### Device allumé avec connaissance des Credentials

1. Mode avions, désactivation Wifi et Bluetooth

2. Activation du débogage USB

4. Étendre le Lock Timeaout

5. Collecter les identifiants

6. Transport au Lab (NE PAS etiendre)


## Android mode Dev + debug USB

1. `Paramètres` -> `à propos du téléphone` -> `Numéro de build`*4

2. `Paramètres` -> `Systèmes` -> `Options pour les développeurs` -> `Debogage USB`


## Adb

Avant la collecte d'artefact, penser à **ajouter le timestamp au prompt**

### lancement du serveur adb : 

```powershell
.\adb.exe version
.\adb.exe start-server
```

### devices

```powershell
.\adb.exe devices
.\adb.exe get-serialno > Artefacts/serialNo.txt
.\adb.exe get-state
```

### Dump Système

```powershell
.\adb.exe shell dumpsys > Artefacts/Dumpsys.txt
```

### Processus

```powershell
.\adb.exe shell ps > Artefacts/ps.txt
```

### Logs

```powershell
#.\adb.exe logcat -G 1M
#.\adb.exe logcat -g
.\adb.exe logcat -d -b all V:* > .\Artefacts\log.txt
```

Pour spécifier une date `.\adb.exe logcat -d -T "2024-11-29 16:00:00.000"`

### Packages

```powershell
.\adb.exe shell pm list packages -f > .\Artefacts\packages.txt
```

### Permissions

```powershell
.\adb.exe shell pm list permissions > .\Artefacts\permissions.txt
.\adb.exe shell "dumpsys package packagename | grep permission" > .\Artefacts\DumpsysPermissions.txt
```

### Contacts

```powershell
.\adb.exe shell content query --uri content://com.android.contacts/contacts > .\Artefacts\contact.txt
.\adb.exe shell content query --uri content://contacts/phones > .\Artefacts\phone.txt
```

### Appels/SMS/MMS :

```powershell
.\adb.exe shell content query --uri content://sms > .\Artefacts\sms.txt
.\adb.exe shell content query --uri content://mms > .\Artefacts\mms.txt
.\adb.exe shell content query --uri content://call_log/calls > .\Artefacts\calls.txt
```

### Usages des applicaitons

```powershell
.\adb.exe shell dumpsys usagestats > .\Artefacts\DumpsysUsagetats.txt
```

### Pull de fichiers

téléchargement des documents utilisateur

```powershell
.\adb.exe pull /storage/emulated/ Artefacts/storage
.\adb.exe pull /sdcard Artefacts/sdcard
```

### Montages

```powershell
.\adb.exe shell mount > .\Artefacts\mount.txt
```

### Réseaux

```powershell
.\adb.exe shell netstat -a > .\Artefacts\netstat.txt
.\adb.exe shell dumpsys wifi > .\Artefacts\Wifi.txt
.\adb.exe shell dumpsys telephony.registry > Artefacts/telephony.txt
.\adb.exe shell dumpsys bluetooth_manager > .\Artefacts\bluetooth.txt
```

### Configuration

```powershell
.\adb.exe shell content query --uri content://settings/secure/ > .\Artefacts\secure.txt
.\adb.exe shell content query --uri content://settings/global > .\Artefacts\global.txt
```


### Backup

> Ce type de backup est déprécié par Google.

```powershell
.\adb.exe backup -all -shared -system -keyvalue -apk -obb -f .\Artefacts\backup.ab
```


### Vérifier l'absence de rootage

```powershell
.\adb.exe root
.\adb.exe shell id
.\adb.exe shell su
.\adb.exe shell "su -c whoami"
```

### Fastboot 

* vérifier le `secure boot` : yes
* vérifier le `Device state` : locked

```powershell
.\adb.exe reboot bootloader
.\fastboot.exe oem device-info
.\fastboot.exe reboot
```

### Parcourir les fichiers manuellement

```powershell
.\adb.exe shell ls /
```


### Arrêt du serveur adb : 

```powershell
.\adb.exe kill-server
```

## Analyse des applications suspectes


* Peut se faire localement avec `Google Play Protect` depuis le Play Store

* Revue des permissions localement via `Paramètres` -> `Applications` et `Paramètres` -> `Sécurité et Confidentialité`, mieux vaut privilégier `adb`.

* Signatures des Apps ou Fichiers suspects : à mettre sur `VirusTotal` ou [Pestudio](https://www.winitor.com/download) une fois l'APK téléchargée via `adb`

* Analyse plus complète via [pithus](https://beta.pithus.org/)

```powershell
.\adb.exe pull /data/app/chemin/base.apk base.apk
```


## Compte google

* [google security checkup](myaccount.google.com/security-checkup)

* [Support Google](https://support.google.com/accounts/answer/6294825?)



## Pour aller plus loin, en cas d'élements probants

### Autres solutions de Backup

Via Google :

`Paramètres` -> `Système` -> `Sauvegarde`, ensuite visible sur [Google](https://drive.google.com/drive/backups)


Via bu :

```powershell
.\adb.exe shell 'bu backup -apk -all' > BUbackup.adb
```

Extraction des backups adb :

* via [ABE](https://github.com/nelenkov/android-backup-extractor) : 

```powershell
java -jar .\abe-3e9a273.jar unpack .\backup.ab backup.tar
```

via dd :

```sh
dd if=myAndroidBackup.ab bs=4K iflag=skip_bytes skip=24 | openssl zlib -d > myAndroidBackup.tar
```

via l'outil `MVT` :

```sh
mvt-android check-backup --output /path/to/results/ /path/to/backup.ab`
```


### Consomation / temps passé sur une app

Sur le device : `paramètres` -> `bien être numérique et controle parental`


### Recherche d'IoCs

Lorsqu'on sait ce que l'on cherche, trouver les IoCs Correspondants

```sh
mvt-android check-backup --iocs ~/iocs/malware.stix2 /path/to/android/backup/
```


### Web (rooté)

```powershell
 .\adb.exe shell content query --uri content://com.android.chrome.browser/history
```


### Codes IHM

Redirection d'appel : `*#21#`

Appel en absence : `*#62#` 

> Pour info, à ne pas faire en forensic : désactiver les redirection :  #002# 


### Traffic réseau

Mise en proxy / derrière un firewall


### Misc

from [@PraveenAdithya](https://github.com/PraveenAdithya/Android-Forensics-Cheatsheet) et complété

```txt
Android-Forensics-Cheatsheet

Android forensic artifacts cheat sheet :

.\data\system\users%USERNUMBER%\settings_secure.xml - Android ID, Bluetooth name, Bluetooth address

..\data\system\usagestats%USERNUMBER%\version - OS version, Build codename, Build version

..\data\drm\pvt\ahrh - IMEI

..\data\user_de%USERNUMBER%\com.android.providers.telephony\databases\telephony.db - Display name, ICCID, IMSI, Country (SIM card details)

..\data\misc\bootstat\factory_reset - Factory reset time (UTC)

..\data\misc\bootstat\last_boot_time_utc - Last boot time (UTC)

..\data\misc\adb\adb_keys. - host connects to the device through adb.

..\data\system_ce%USERNUMBER%\accounts_ce.db - users’ application account details, including login credentials, account IDs, authentication tokens, and more

..\data\system_de%USERNUMBER%\accounts_de.db - users’ application account details, including login credentials, account IDs, authentication tokens, and more

..\data\user%USERNUMBER%\com.google.android.apps.turbo\shared_prefs\app_usage_stats.xml - hardware and software usage statistics.

.\data\data\com.google.android.apps.wellbeing\databases\app_usage - Digital Wellbeing service that collects usage statistic

..\data\data\com.samsung.android.forest\databases\dwbCommon.db - Digital Wellbeing service Samsung

.\data\data\com.android.vending\databases\frosting.db - application is installed or updated

..\data\data\com.android.vending\databases\suggestions.db - Google Play Store searches

..\data\data\com.WhatsApp\databases\msgstore.db - WhatsApp stores account data

..\data\data\com.WhatsApp\files - WhatsApp encrypts and decrypts database backups with a key

..\Android\media\com.whatsapp\WhatsApp\Media. - WhatsApp Media files

/data/datacom.instagram.android/shared_prefs/com.instagram.android_preferences.xml - Instagram -User ID,Username,account type,user account accesstime, biography, profile photo

/data/datacom.instagram.android/shared_prefs/_userBootstrapService.xml - Instagrams followers,following, close friends list

/data/data/com.android.providers.settings/databases/settings.db - secrets, dont salt

/data/system/password.key -	secret lockScreen

/data/data/com.android.chrome/databases/webview.db - Chrome history

/data/data/com.whatsapp/ - wa.db et msgstore.db contient les messages WhattsAp

/sdcard/Android/media/com.whatsapp/WhatsApp - Fichiers partagés WhattsApp et wa.db et msgstore.db

Backup/apps/com.android.launcher3 - Historique de luncher dans des fichiers de log

```