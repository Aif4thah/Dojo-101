Configure Git pour la première fois
git config --global user.name "Michael VACARELLA"
git config --global user.email "michael.vacarella.groupeadsn@notaires.fr"


En train de travailler avec ton dépôt

Je veux juste cloner ce dépôt
Si vous voulez simplement cloner ce dépôt vite exécuter cette commande dans votre terminal.

git clone https://scm.intranet-adsn.fr/scm/ascsigman/sigman-bamboo-specs.git


Mon code est prêt pour être envoyé
Si tu as déjà du code prêt pour être envoyé à ce dépôt alors exécute ceci sur ton terminal.

cd existing-project
git init
git add --all
git commit -m "Initial Commit"
git remote add origin https://scm.intranet-adsn.fr/scm/ascsigman/sigman-bamboo-specs.git
git push -u origin HEAD:master



Mon code est déjà suivi par Git
Si ton code est déjà suivi par Git alors établis ce dépôt comme ton «origine» vers où envoyer.

cd existing-project
git remote set-url origin https://scm.intranet-adsn.fr/scm/ascsigman/sigman-bamboo-specs.git
git push -u origin --all
git push origin --tags