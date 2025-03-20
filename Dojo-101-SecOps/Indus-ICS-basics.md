# systèmes industriels ICS basics

## protocoles

* **Open Platform Communications Unified Architecture (OPC UA)** : recommandé ANSSI pour les SIIV et SIE
* Supervisory Control and Data Acquisition (SCADA)
* Industrial Automation and Control Systems (IACS)
* Human Machine Interface (HMI)
* Distributed Control Systems (DCS)
* Control Servers
* Programmable Automation Controllers (PAC)
* Programmable Logic Controllers (PLC)
* Intelligent Electronic Devices (IED)
* Sensors
* Remote Terminal Units (RTU)

## Outils

* [Fuzzer OPCUA](https://github.com/ANSSI-FR/fuzzysully)

## Normes

* IEC-62443 : Réseaux de communication industriels - Sécurité informatique des réseaux et des systèmes

## Profil de protection et certification CSPN

* [PP ANSSI](https://cyber.gouv.fr/publications/profils-de-protection-pour-les-systemes-industriels)

### Certifications critères communs (CC):

https://www.commoncriteriaportal.org/

### certification CC et équivalence RGS

* qualification élémentaire, basée sur une évaluation CSPN
* qualification standard, basée sur une évaluation Critères Communs EAL 3+
* qualification renforcée, basée sur une évaluation Critère Communs EAL 4+

## démarche de sécurisation

0. défense périmetrique (convertisseur vers / depuis TCP/IP)
1. TOE (target of evaluation) non sécurisée
2. Profil de protection
3. Certification

## voir aussi

* fuzzing
