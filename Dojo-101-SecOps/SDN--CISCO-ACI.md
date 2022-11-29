# CISCO ACI
Version actuelle au moment de l'info: 4.1 (2019)
 
APIC : Statless uniquement -> autre solution: repasser par une techno statefull (NLB, Fw )
FABRIC = ensemble ACI
-> cenctric control plan 3 APIC (gestion des contrat
-> data plan (action, "muscle")
-> misc (rzo etc...)
 
Tenant = ensemble d'EPG, contrat, leaf; Mais un leaf peut apartenir à plusieurs tenant
 
Fabric = bulle logique
Spine = Top of rack (physique) (intelligence) le Spine appartient à une seule fabrique dans 99% des cas
Leaf  = relié aux spin et au APIC, contient la fraction de la BDD de l'APIC  qu'il utilise, peut faire office de Gateway à la place du Firewall 
(envoie le paquet au Fw que si besoin d'inspection) - switch cisco physique 24 à 96 ports
Border Leaf: ne tien pas de tenant, permet de sortir d'ACI 
EPG = Endpoint Group 
Micro  EPG: granularité au sein d'un EPG mais perte des fonctionalités car  établissement de regles des type "any all" / "deny all"
Nano EPG: Nouvelle fonctionalité, encore peut utilisé
APIC: detient les contrat, EPG en DBB ( physique (au moins une) ou Virtuelle)
Contrat: entre EPG, cela peut aller tres loin (exemple vérification du status anti-virus
 
 
Au sein d'un EPG:
Nœuds (A ; B ; C)
Par défaut tout communique "idem VLAN"
mais  on peut mettre en place des micro-EPG -> le leaf applique une regle  de type tout communique ou rien communique et il faut repasser pas par  un EPG
attention il a beaucoup de façon de faire et cela reste lié à la version API 
 
 
Bonne pratique:
=============
Leaf multitenant avec SI de differents niveau de sécurité, pas alarmant mais idéalement à éviter
Utiliser les border Leaf pour sortir d’ACI
Ne pas mélanger les leaf frontaux et Back (BDD) (ségreguer les leaf plutot que les EPG)
 
Pour une ségregation physique : 
=========================
- 1 tenant dédié au projet, voir plusieurs tenant par projet: exemple un tenant front + un tenant back
- Leaf mono tenant
- physiquement: mettre un leaf en top of rack et caler le projet dedant ou ségréguer par niveau de sécurité
- mise en cluster des leaf par datacenter
-  integrer les firewall dans l'ACI pour les fonctionalité mais attention  le Firewall ne fait plus de rupture ( le paquet n'est pas toujours  transmis )
attention cela reste un autre paradigme: il faut rester au plus simple et au plus logique 
 
 
Faiblesses: l'APIC tombe: c'est fini (nouveaux assets à défendre)
 
cf: doc ACI Cisco + « ACI  for dummies » pour commencer.


