1. **Forker le dépôt**
    - Allez sur le dépôt GitHub que vous voulez forker.
    - Cliquez sur le bouton `Fork` en haut à droite de la page.

2. **Cloner le fork sur votre machine locale**
    - Allez sur votre propre compte GitHub.
    - Ouvrez le dépôt forké.
    - Cliquez sur le bouton `Code` et copiez l'URL.
    - Ouvrez un terminal sur votre machine locale, naviguez vers l'emplacement où vous voulez cloner le dépôt et exécutez la commande : `git clone [URL]`.

3. **Créer une nouvelle branche**
    - Dans le terminal, naviguez vers le dépôt cloné.
    - Créez une nouvelle branche en utilisant la commande : `git checkout -b [nom_de_la_branche]`.

4. **Effectuer des modifications et les commit**
    - Effectuez les modifications nécessaires dans les fichiers.
    - Ajoutez les modifications à l'index en utilisant la commande : `git add .`.
    - Committez vos modifications en utilisant la commande : `git commit -m "[message_de_commit]"`.

5. **Pusher les modifications vers GitHub**
    - Poussez vos modifications en utilisant la commande : `git push origin [nom_de_la_branche]`.

6. **Créer une Pull Request**
    - Allez sur votre dépôt GitHub.
    - Cliquez sur l'onglet `Pull requests`.
    - Cliquez sur le bouton `New pull request`.
    - Dans la boîte de dialogue `compare: master`, sélectionnez la branche que vous avez créée.
    - Cliquez sur le bouton `Create pull request`.
