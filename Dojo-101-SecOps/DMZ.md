# Les Zone démilitarisées (DMZ)

Zone isolée fournissant des services à l'extérieur (Internet / *non-trusté*) mais aussi susceptible de fournir des services aux réseaux locaux (de confiance).

## DMZ Classique :

```mermaid
flowchart TD
    A{Internet}
    B[**Firewall 1**]
    C{**DMZ**}
    D[**Firewall 2**]
    E{Internal Network}

    A --> B
    B --> C
    D --> C
    E --> D 
```

## DMZ à 1 firewall :

```mermaid
flowchart TD
    A{Internet}
    B[**Firewall 1**]
    C{**DMZ**}
    E{Internal Network}

    A --> B
    B --> C
    E --> B 
```

## plusieurs DMZ avec plusieurs niveau de sécurité

```mermaid
flowchart TD
    A{Internet}
    B[**Firewall 1**]
    C{**DMZ ext**}
    D[**Firewall 2**]
    F[**Firewall 3**]
    G{DMZ int}
    E{Internal Network}

    A --> B
    B --> C
    C --> D
    D --> G
    G --> F
    F --> E
```

> [!WARNING]  
> Lorsque le réseau interne peut communiquer avec une machine en DMZ sans passer par le firewall, ou lorsque le réseau interne et la DMZ sont sur le même hyperviseur, ce n'est **PAS une DMZ**.