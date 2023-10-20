# PKI (Public key infrastructure) / IGC Infrastructure de gestion de clés

## definition

* Autorité de certification (AC): Agit comme racine de confiance dans une infrastructure à clé publique et fournit des services qui authentifient l’identité des personnes, des ordinateurs et d’autres entités dans un réseau. (source: microsoft)

* Autorité d’inscription: Est certifié par une autorité de certification racine pour émettre des certificats pour des utilisations spécifiques autorisées par la racine. Dans une infrastructure à clé publique Microsoft, une autorité d’inscription (RA) est généralement appelée autorité de certification subordonnée. (source: microsoft)

* Base de données de certificats: Enregistre les demandes de certificat et les certificats émis et révoqués et les demandes de certificat sur l’autorité de certification ou l’autorité de certification. (source: microsoft)

* Magasin de certificats: Enregistre les certificats émis et les demandes de certificat en attente ou rejetées sur l’ordinateur local. (source: microsoft)

* Serveur d’archivage de clé : Enregistre les clés privées chiffrées dans la base de données de certificats pour une récupération après perte. (source: microsoft)

* AC Racine :

* AC Intermediaire :

* Chaine de confiance: 

* HSM: Hardware Security Module

## points à prendre en compte pour la sécurité

* La durée de validité des certificats et les algorithmes de chiffrements choisis
* L’impact de la compromission d’une clé privée (cliente ou serveur) sur le reste de l’IGC et de fait le choix de l’autorité de certification ainsi que les méthodes de révocation en fonction du besoin.
* Le stockage et le cloisonnement des secrets
* Le cas échéant, les protocoles d’enrôlement
* Les erreurs d’implémentation ou de configuration

## emplacement des certificats

### Certstore Windows

mmc: certmgr.msc

```powershell
ls Cert:\CurrentUser\
ls Cert:\CurrentUser\My\* |fl
```

## lire un certificat depuis un fichier

```sh 
openssl x509 -in certificate.crt -text -noout
```

```powershell
Get-PfxCertificate .\cert.cer |fl *
```

## Exemple d'architecture PKI
                       
                                   +#####################                  
                                   #+#------------------+###               
                                   #-#                      #              
                                   #-#                      #              
                                   #-#                      #              
                                   #-#    AC RACINE         #              
                                   #-#                      #              
                                   ###                      #              
                                     #                      #              
                                              #                            
                         +---------++++++++++-+-++++++++------------       
                         #                                          #        
              -###################### .                 ######################+.                                           
              .--                      -                #-                      ..                                         
              .-+     .   -###      .  -                #-          ###.     .  ..                                         
              .-+                      -                +-.                     ..                                         
              .-+  AC Intermerdiaire   -                #-. AC Intermerdiaire  ..                                         
              .-+      .      . .   +  -                #-.  .   -      . -  .  ..                                         
              -##          A           -                ##.          B         ..                                         
                .                      -                                         .                                         
                 +...... . ...........+.                  +-....................#                                          
             ....  ..... # ..........                                #       
           #                        #                                #
.######################     #######################       ######################-                                            
-##                     +#  #-#                     #     #+#                     #                                          
.##                   .  +  #-#                  .   #    #+                      #                                        
.##  ..  #    .#      .  +  #-#  ..  #   .#      .   #    ##. ..  #     #.     .  #                                         
.##   . CERTIFICAT  .    +  #-#      CERTIFICAT  .   #    ##.  .  CERTIFICAT  ..  #                                      
.##  .   SERVICE A       +  #-# ...   SERVICE B      #    ##.  .   CLIENT 1   ..  #                                         
-##  .                   +  #+#                      #    ##. .. .  ... ..    .. .#                                     
 ## ....             ..  +   ## ...              .   #    ##- ....            ..  #                                         
                         #    #                      #     -                     #                                         
    ....................        ....................        ....................                                           
                                       
                           