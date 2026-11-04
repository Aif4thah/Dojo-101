# paiement en ligne - Pay - credit card 

## API paiement

* vérifier qu'un utilisateur ne peut pas rédiger de la prod vers le dev/test pour contourner l'étape du paiement. (avec un numéro de carte de crédit de test par exemple)
* vérifier que l'utilisateur ne peux pas simuler un faux reçu de paiement (via la boucle locale etc...)


## IBAN et SWIFT

la validité d'un numéro ne veut pas dire que ce numéro existe à la banque

## Stripe

* Vérifier l'absence de `test` en url / tester la carte `42424242...`
* Certains paiements sont fait plusieurs jours après, verifier les process metier.

## Google pay billing

* Utiliser `consumePurchase` et `completePurchase` si non l'utilisateur peut être remboursé sous 3 jours
