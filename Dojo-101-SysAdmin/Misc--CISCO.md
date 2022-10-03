# Configurer les fonctionnalités de sécurité Layer 2 (DHCP snooping, dynamic ARP inspection, et port security)

## Switchport Port-Security (Sécurité sur les ports) Cisco en IOS

1. Fonction Switchport Security
Cette fonction permet de contrôler les adresses MAC autorisées sur un port. En cas de “violation”, c’est-à-dire en cas d’adresses MAC non autorisées sur le port, une action est prise.

Dans les infrastructures LAN modernes, on trouvera un port de commutateur dédié par station de travail. Dans ce cadre, les ports ne devraient recevoir de trafic que d’une seule adresse MAC autorisée. On y trouvera alors une utilité pour empêcher la connexion de commutateurs pirates par exemple. Par contre, la mesure uniquement configurée sur un nombre minimal d’adresses à 1 (qui est la configuration par défaut), n’empêche personne de déconnecter un hôte et d’y connecter son ordinateur pirate. Il serait nécessaire d’indiquer au commutateur quelle est l’adresse MAC à autoriser.

Mais comment “autoriser” une adresse MAC spécifique autrement qu’en tenant un registre central ? Bonne chance à celui qui maintiendra manuellement des autorisations en fonction d’adresses construites avec ce critère. Par contre, il est possible que le commutateur Cisco apprenne les adresses MAC à un moment déterminé (où seules les stations autorisées seraient connectées par hypothèse) et de les inclure en dur dans la configuration du commutateur. Combinée à un maximum de une seule adresse, la fonction switchport port-security mac-address sticky autorise en dur dans la configuration courante uniquement la première adresse connectée au port.

2. Contre-mesures face aux attaques sur le réseau local
Switchport-Port Security permet donc de contrôler au plus bas niveau les accès au réseau. Elle fait partie de l’arsenal disponible pour contrer des attaques de bas niveau sur les infrastructures commutées. Parmi d’autres :

BPDU Guard
Deep ARP Inspection
IPv6 First Hop Security
DHCP Snooping
IEEE 802.1X / EAP + Radius
Bonne pratique VLAN

3. Mise en oeuvre sur des commutateurs Cisco
Par défaut, cette fonction est désactivée.

Si elle est simplement activée, par défaut :

Une seule adresse MAC est apprise dynamiquement et elle la seule autorisée.
En cas de “violation”, le port tombe en mode shutdown.
4. Activation de port-security
La fonction s’active en encodant une première fois la commande switchport port-security en configuration d’interface.

(config)#interface G0/1
(config-if)#switchport mode access
(config-if)#switchport port-security

5. Définition des adresses MAC autorisées
On peut fixer le nombre d’adresses MAC autorisées, ici par exemple 10 :

(config-if)#switchport port-security maximum 10
Les adresses MAC apprises peuvent être inscrites dynamiquement dans la configuration courante (running-config) avec le mot clé “sticky“ :

(config-if)#switchport port-security mac-address sticky
Les adresses MAC autorisées peuvent être fixées :

(config-if)#switchport port-security mac-address 0000.0000.0003

6. Mode de “violation”
Une “Violation” est une action prise en cas de non-respect d’une règle port-security.

(config-if)#switchport port-security violation {protect | restrict | shutdown}
Mode protect : dès que la “violation” est constatée, le port arrête de transférer le trafic des adresses non autorisées sans envoyer de message de log.
Mode restrict : dès que la “violation” est constatée, le port arrête de transférer le trafic des adresses non autorisées et transmet un message de log.
Mode shutdown : dès que la “violation” est constatée, le port passe en état err-disabled (shutdown) et un message de log est envoyé.

7. Diagnostic port-security
Désactivation d’un port err-disabled selon la plateforme (shut/no shutdown) :

(config)#errdisable recovery cause psecure-violation
Diagnostic :

#show port-security
#show port-security address
#show port-security interface G0/1
#show running-config
#clear port-security {all | configured | dynamic | sticky}