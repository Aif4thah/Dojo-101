# Configurer les fonctionnalités de sécurité Layer 2 (DHCP snooping, dynamic ARP inspection, et port security)

## Switchport Port-Security (Sécurité sur les ports) Cisco en IOS


###  Mise en oeuvre sur des commutateurs Cisco

Par défaut, cette fonction est désactivée.

Si elle est simplement activée, par défaut :

Une seule adresse MAC est apprise dynamiquement et elle la seule autorisée.
En cas de “violation”, le port tombe en mode shutdown.

### Activation de port-security

La fonction s’active en encodant une première fois la commande switchport port-security en configuration d’interface.

```sh
(config)#interface G0/1
(config-if)#switchport mode access
(config-if)#switchport port-security
```

### Définition des adresses MAC autorisées
On peut fixer le nombre d’adresses MAC autorisées, ici par exemple 10 :

```sh
(config-if)#switchport port-security maximum 10
Les adresses MAC apprises peuvent être inscrites dynamiquement dans la configuration courante (running-config) avec le mot clé “sticky“ :

(config-if)#switchport port-security mac-address sticky
Les adresses MAC autorisées peuvent être fixées :

(config-if)#switchport port-security mac-address 0000.0000.0003
```

### Mode de "violation"

Une “Violation” est une action prise en cas de non-respect d’une règle port-security.

```sh
(config-if)#switchport port-security violation {protect | restrict | shutdown}
Mode protect : dès que la “violation” est constatée, le port arrête de transférer le trafic des adresses non autorisées sans envoyer de message de log.
Mode restrict : dès que la “violation” est constatée, le port arrête de transférer le trafic des adresses non autorisées et transmet un message de log.
Mode shutdown : dès que la “violation” est constatée, le port passe en état err-disabled (shutdown) et un message de log est envoyé.
```

### Diagnostic port-security

Désactivation d’un port err-disabled selon la plateforme (shut/no shutdown) :

```sh
(config)#errdisable recovery cause psecure-violation
```

### Diagnostic:

```sh
#show port-security
#show port-security address
#show port-security interface G0/1
#show running-config
#clear port-security {all | configured | dynamic | sticky}
```