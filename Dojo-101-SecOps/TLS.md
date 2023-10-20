# TLS - Transport Layer Security

## Définitions

TLS est un protocole de sécurité de la couche transport, il agit en remplaçant de SSL.

La dernière version est le TLS v1.3 publié en 2018. IL abandonne les algorithmes de considérés comme trop faibles.

## Mode de fonctionnement 

Le protocole TLS (Transport Layer Security) est un protocole de sécurité qui assure la confidentialité et l'intégrité des données échangées entre un client et un serveur sur un réseau. Voici comment il fonctionne :

### Étape 1 : Handshake

1. **ClientHello**: Le client envoie un message `ClientHello` au serveur pour initier la connexion TLS. Ce message contient des informations telles que les versions de TLS prises en charge, les méthodes de chiffrement, etc.

2. **ServerHello**: Le serveur répond avec un message `ServerHello` en sélectionnant une version de TLS et une méthode de chiffrement. Il envoie également son certificat numérique.

3. **Key Exchange**: Si nécessaire, le serveur et le client effectuent un échange de clés pour établir une clé de session secrète.

4. **Finished**: Les deux parties confirment la fin de la négociation de sécurité en envoyant des messages `Finished`.

### Étape 2 : Chiffrement

5. Une fois la clé de session établie, les données échangées entre le client et le serveur sont chiffrées et déchiffrées à l'aide de cette clé.

### Étape 3 : Authentification

6. Le client vérifie l'authenticité du certificat du serveur en utilisant des autorités de certification (CA) de confiance.

7. Le serveur peut également demander au client de s'authentifier.

### Étape 4 : Communication sécurisée

8. Les données sont désormais échangées de manière sécurisée entre le client et le serveur à l'aide de chiffrement symétrique.

### Étape 5 : Terminaison

9. Une fois la communication terminée, la connexion TLS peut être fermée proprement en utilisant un message `CloseNotify`.

Cela résume le fonctionnement de base du protocole TLS pour établir une connexion sécurisée entre un client et un serveur. Il garantit que les données sont chiffrées, l'authenticité est vérifiée, et la communication est protégée contre les attaques.

## Déchiffrer le traffic

La méthode que nous utiliserons la méthode suivante, testée sur Windows 11

### Étape 1 : Paramétrer votre système

Rendez-vous dans les paramètres avancés de votre OS et ajoutez dans les variables d'environnement pour votre utilisateur la variable "SSLKEYLOGFILE".

Ajoutez en valeur un chemin vers lequel vous allez déposer votre fichier de log. Par exemple : C:\Users\toto\Documents\ssl-keys.log

Redémarrez votre navigateur après avoir enregistré la clé de registre.

### Étape 2 : Capturer la recherche

Lancez wireshark et commencez a capturer votre traffic.

Lancez ensuite votre navigateur et effectuez une recherche, par exemple : https://wireshark.org. 

Stoppez la capture une fois la page affichée et fermez la page web. Le fichier .log devrait s'être généré à l'emplacement souhaité.

### Étape 3 : Déchiffrer le traffic

Sur Wireshark rendez-vous dans Edit -> Préférences -> Protocols -> TLS

Dans (Pre)-Master-Secret log filename, rentrez le fichier .log capturé et validez.

Retournez analyser le traffic qui devrait maintenant être déchiffré.

