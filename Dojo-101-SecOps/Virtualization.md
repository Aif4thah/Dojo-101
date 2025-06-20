# Virtualization

## Ressources

* [Source ANSSI](https://cyber.gouv.fr/publications/securite-des-systemes-de-virtualisation)

## Types de virtualisation

| Type de virtualisation | Technique utilisée | Description | Exemples de solutions| Niveau de sécurité relatif    |
|-------|--------------------|----------------------|------------------|---------|
| Virtualisation applicative  | Émulation  | Imite une entité pour rendre les applis portables, indépendamment du matériel    | Citrix App Stream, App-V, Softgrid, JVM, .NET Framework| Faible à modéré  |
| Virtualisation applicative  | Cloisonnement   | Isole des environnements pour sécurité et gestion des ressources   | Linux Vserver, BSD jails, OpenVZ, Solaris Zones    | Modéré à élevé |
| Virtualisation système | Paravirtualisation | OS modifiés pour une interaction optimisée avec la couche d’abstraction | Xen, VMware ESX/ESXi, vSphere, Hyper-V, PolyXene   | Élevé |
| Virtualisation système | Virtualisation complète (totale)  | Exécute les OS sans modifications via traduction d’instructions ou exceptions| VMware Workstation, Virtual PC, VirtualBox, QEMU   | Modéré à élevé |
| Virtualisation système | Virtualisation assistée par le matériel  | Utilise du matériel dédié pour performances proches du natif sans modifier les OS | Intel VT-x/VT-d, AMD-V/IOMMU | Élevé    |

## Virtualisation système – Type 1 (bare-metal)

```mermaid
graph TD
    A[Matériel physique] --> B[Hyperviseur de type 1]
    B --> C1[Système invité 1 - OS complet]
    B --> C2[Système invité 2 - OS complet]
    C1 --> D1[Applications invitées 1]
    C2 --> D2[Applications invitées 2]
```

## Virtualisation système – Type 2 (hébergé)

```mermaid
graph TD
    A[Matériel physique] --> B[Système d'exploitation hôte]
    B --> C[Hyperviseur de type 2]
    C --> D1[Système invité 1 - OS complet]
    C --> D2[Système invité 2 - OS complet]
    D1 --> E1[Applications invitées 1]
    D2 --> E2[Applications invitées 2]

```

### Les risques liés à la virtualisation

* Risque accru de compromission des systèmes

* Accroissement du risque d’indisponibilité

* Complexification de l’administration et de la mise en œuvre

* Complexification de la supervision
