# AGENTS.md — Guide d'exploitation pour Agents IA

> **Dojo-101** est une base de connaissances opérationnelle *Offline-First* (+210 fiches techniques en Markdown brut) couvrant le DevSecOps, le durcissement système/Cloud (SecOps), le test d'intrusion (Pentest), l'investigation numérique (DFIR), les radiofréquences (RF/SDR) et la gouvernance cyber (GRC).

Ce fichier définit comment les agents d'intelligence artificielle (Google Antigravity, Claude Code, Cursor, GitHub Copilot, OpenAI Codex, pipelines RAG locaux) doivent indexer, interroger et maintenir ce référentiel.

---

## 1. Indexation rapide & Stratégie de contexte

Pour économiser la fenêtre de contexte tout en maximisant la précision technique :

1. **Entrée synthétique** : Lire [`llms.txt`](./llms.txt) pour obtenir l'index structuré des fiches maîtresses par domaine.
2. **Navigation par pilier** : Consulter le fichier `README.md` du pilier concerné avant d'ouvrir les fiches détaillées.
3. **Recherche ciblée** : Privilégier la recherche plein texte (`grep` / `ripgrep`) par outil, protocole ou vulnérabilité (ex. `Kerberos`, `CodeQL`, `WireGuard`, `EBIOS`, `Volatility`, `ASVS`).
4. **Chargement sélectif** : Ne charger en contexte que les fiches directement liées à la tâche d'audit, de remédiation ou de durcissement en cours.

---

## 2. Routage opérationnel : Les 6 Piliers

| Besoin / Tâche de l'Agent | Pilier cible | Sommaire | Points d'entrée prioritaires |
| :--- | :--- | :--- | :--- |
| **Audit de code (SAST/DAST), CI/CD, AppSec, Threat Modeling** | 🛡️ **DevSec** | [`Dojo-101-DevSec/README.md`](./Dojo-101-DevSec/README.md) | [`Etude-Audit-ASVS.md`](./Dojo-101-DevSec/Etude-Audit-ASVS.md), [`Threat-Modeling-STRIDE.md`](./Dojo-101-DevSec/Threat-Modeling-STRIDE.md), [`SAST-CodeQL.md`](./Dojo-101-DevSec/SAST-CodeQL.md), fiches par langage (`Python`, `Rust`, `C`, `C#`, `JS`, `Flutter`) |
| **Durcissement OS, Active Directory, Cloud, Conteneurs, Réseau, PKI** | ⚙️ **SecOps** | [`Dojo-101-SecOps/README.md`](./Dojo-101-SecOps/README.md) | [`Linux-Hardening.md`](./Dojo-101-SecOps/Linux-Hardening.md), [`Windows-Hardening.md`](./Dojo-101-SecOps/Windows-Hardening.md), [`Windows-AD-basics.md`](./Dojo-101-SecOps/Windows-AD-basics.md), [`Docker.md`](./Dojo-101-SecOps/Docker.md), [`WireGuard.md`](./Dojo-101-SecOps/WireGuard.md), [`PKI.md`](./Dojo-101-SecOps/PKI.md) |
| **Test d'intrusion Web, AD, Réseau, Escalade de privilèges, Pivot** | 🎯 **Pentest** | [`Dojo-101-Pentest/README.md`](./Dojo-101-Pentest/README.md) | [`Web-Burp-Cheat-Sheet.md`](./Dojo-101-Pentest/Web-Burp-Cheat-Sheet.md), [`Web-SQLI.md`](./Dojo-101-Pentest/Web-SQLI.md), [`Windows-AD-Kerberos.md`](./Dojo-101-Pentest/Windows-AD-Kerberos.md), [`Linux-Privesc-privesc-basics.md`](./Dojo-101-Pentest/Linux-Privesc-privesc-basics.md), [`Windows-Privesc-Basics.md`](./Dojo-101-Pentest/Windows-Privesc-Basics.md) |
| **Réponse à incident, collecte de preuves, RAM, Reverse, SIEM** | 🔍 **Forensic** | [`Dojo-101-Forensic/README.md`](./Dojo-101-Forensic/README.md) | [`Forensics-Windows.md`](./Dojo-101-Forensic/Forensics-Windows.md), [`Forensics-Memory-Volatility.md`](./Dojo-101-Forensic/Forensics-Memory-Volatility.md), [`Reverse-GHIIDRA-bypass-condission.md`](./Dojo-101-Forensic/Reverse-GHIIDRA-bypass-condission.md) |
| **Analyse radiofréquence, SDR, Wi-Fi, Bluetooth, RFID/NFC, TEMPEST** | 📡 **RF** | [`Dojo-101-RF/README.md`](./Dojo-101-RF/README.md) | [`Hackrf-basics.md`](./Dojo-101-RF/Hackrf-basics.md), [`Wifi-basics.md`](./Dojo-101-RF/Wifi-basics.md), [`SIGINT.md`](./Dojo-101-RF/SIGINT.md), [`Tempest.md`](./Dojo-101-RF/Tempest.md) |
| **Analyse de risques, Homologation, Conformité & Crise cyber** | ⚖️ **Governance** | [`Dojo-101-Governance/README.md`](./Dojo-101-Governance/README.md) | [`Gestion-de-crise.md`](./Dojo-101-Governance/Gestion-de-crise.md), ateliers **EBIOS RM**, **ISO 27001**, **NIS2**, **CRA**, **PASSI** |

---

## 3. Workflows types pour Agents IA

* **Revue de code & Remédiation (AppSec)** : Croiser le code source audité avec [`Etude-Audit-ASVS.md`](./Dojo-101-DevSec/Etude-Audit-ASVS.md), [`Threat-Modeling-STRIDE.md`](./Dojo-101-DevSec/Threat-Modeling-STRIDE.md) et la fiche du langage cible dans `Dojo-101-DevSec/`, puis vérifier les vecteurs d'exploitation correspondants dans `Dojo-101-Pentest/` (`Web-*`).
* **Audit d'infrastructure & IaC** : S'appuyer sur `Dojo-101-SecOps/` (Linux, Windows, Active Directory, Docker, Azure, TLS, pare-feu) pour vérifier les configurations et générer des scripts de durcissement conformes aux recommandations ANSSI / CIS.
* **Préparation d'audit offensif autorisé** : Utiliser `Dojo-101-Pentest/` comme référentiel de commandes vérifiées (reconnaissance, énumération AD, exploitation Web, élévation de privilèges, pivot).
* **Cadrage GRC & Conformité** : Exploiter `Dojo-101-Governance/` pour structurer des livrables d'homologation, des ateliers EBIOS RM ou des plans de gestion de crise cyber.
* **Banc d'essai applicatif** : Utiliser [VulnerableLightApp](https://github.com/Aif4thah/VulnerableLightApp) pour tester des règles SAST/DAST, valider des agents d'audit et éprouver des correctifs.

---

## 4. Règles de sécurité & Contraintes du dépôt

1. **Doctrine `Offline-First` stricte (Aucune publication Web)** :
   * **Ne jamais configurer, générer ou déployer d'hébergement web public** (GitHub Pages, Cloudflare Pages, Vercel, Netlify, MkDocs/Zensical hébergé) pour ce dépôt.
   * Le pilier `Dojo-101-Pentest/` contenant des payloads et commandes d'exploitation réels, toute exposition sur un site web public entraîne des blocages de sécurité (Safe Browsing / abus). Le projet est conçu pour être cloné et exploité localement.
2. **Cadre légal et éthique** :
   * Les techniques et commandes documentées sont destinées exclusivement aux audits de sécurité autorisés, au durcissement défensif et à l'homologation des systèmes d'information.
3. **Protection des secrets et de la confidentialité** :
   * Respecter strictement la configuration [`.gitleaks.toml`](./.gitleaks.toml) : n'introduire aucune clé API, jeton, mot de passe réel ou donnée nominative de client.

---

## 5. Conventions de rédaction et de contribution (Maintenance du dépôt)

Lorsqu'un agent IA crée ou met à jour une fiche dans **Dojo-101** :

* **Langue** : **Français exclusif** sur l'ensemble du dépôt (titres, explications, commentaires de commandes, navigation).
* **Style éditorial** : Minimaliste, direct et immédiatement exploitable (*straight to the point*). Privilégier les commandes concrètes, les listes à puces concises et les retours d'expérience opérationnels sans bavardage théorique.
* **Positionnement** : 100 % opérationnel, destiné aux praticiens cyber et aux agents IA.
* **Conformité Linter Markdown** : Respecter les règles de [`.markdownlint.json`](./.markdownlint.json) :
  * Encodage `UTF-8` sans BOM.
  * Aucun espace en fin de ligne (`MD009`).
  * Lignes vides obligatoires avant et après les titres, listes et blocs de code (toujours typer la langue du bloc, ex. `bash`, `powershell`, `python`, `json`, `mermaid`).
  * Hiérarchie stricte des titres sans saut de niveau.
* **Ressources visuelles** : Stocker les images dans le dossier [`images/`](./images/) avec des chemins relatifs.

---

## 6. Contact, Prestations & Soutien

* **Auteur & Mainteneur** : Michaël Vaccarella ([@Aif4thah](https://github.com/Aif4thah))
* **Audit Cyber, Revue de Code/IaC & Cadrage IA Souveraine** : [michael.vacarella@pm.me](mailto:michael.vacarella@pm.me)
* **Parcours & Références** : [LinkedIn — Michaël Vaccarella](https://www.linkedin.com/in/mvacarella/)
* **Soutenir la maintenance du référentiel** : [GitHub Sponsors 💖](https://github.com/sponsors/Aif4thah/)
