## vim
copier coller: shift+select pour pouvoir coller ailleurs, shift clic droit ou molette pour coller

Sauvegarder un fichier - quitter vi

:w
    sauvegarde le contenu du fichier (l'enregistrer), penser à write
:x
    sauvegarde puis quitte vi (exit)
:wq
    sauvegarde puis quitte (write and quit)
ZZ
    sauvegarde si nécessaire puis quitte
:q
    quitte vi sans sauvegarder les modifications (quit)
:e!
    ignore les modifications et recharge le fichier (le point d'exclamation marque l'impératif)
:q!
    quitte immédiatement, sans rien faire d'autre (donc sans sauvergarder ni demande de confirmation)
:w nom_de_fichier
    sauvegarde le fichier sous le nom nom_de_fichier
:w! nom_de_fichier
    remplace le contenu du fichier nom_de_fichier

Se déplacer dans le document édité

[CTRL]f
    descend d'une page (forward, en avant)
[CTRL]b
    remonte d'une page (back, en arrière)
[CTRL]d
    descend d'1/2 page
[CTRL]u
    remonte d'1/2 page
:X
    va à la ligne numérotée X (X est un entier)

Déplacer le curseur

H
    en haut de l'écran
M
    au milieu de l'écran
L
    en bas de l'écran (lower, au plus bas)
h
    décale d'un caractère à gauche
j
    descend d'une ligne
k
    monte d'une ligne
l
    décale d'un caractère à droite
0
    au début de la ligne
$
    à la fin de la ligne ('$', dans un motif de regexp, désigne la fin d'une ligne)
w
    au début du mot suivant (word, mot)
e
    à la fin du mot suivant (end, fin)
b
    recule d'un mot (back, retour)
{
    recule jusqu'au paragraphe suivant
}
    avance jusqu'au paragraphe précédent
(
    recule jusqu'à la phrase suivante
)
    avance jusqu'à la phrase précédente

Insérer du texte

i
    active le mode insertion
a
    active le mode insertion, un caractère après le curseur (append, ajouter)
I
    insère au début de la ligne
A
    insère à la fin de la ligne
O
    insère une ligne au-dessus du curseur et passe en mode insertion (open, ouvrir)
o
    insère une ligne en dessous du curseur et passe en mode insertion
[ESC]
    Quitte le mode insertion, revient en mode commande

Remplacer du texte

rx
    remplace le caractère à la position du curseur par x (x remplace ici n'importe quel caractère)
R
    remplace, avec ce qui sera saisi ([ESC] pour terminer)
cw
    remplace uniquement le mot à la position du curseur (word, mot) ([ESC] pour terminer)
cnw
    remplace n mots ([ESC] pour terminer)
C
    remplace la ligne ([ESC] pour terminer)

Supprimer du texte

x
    supprime un caractère (« faire une croix dessus »)
dw
    supprime un mot (delete, détruire)
dnw
    supprime n mots
dd
    supprime une ligne
ndd
    supprime n lignes

Copier-coller

Y
    copie une ligne, donc la place dans un tampon, pour pouvoir ensuite la coller (yank, tirer)
nY
    copie n lignes
P
    colle les lignes avant le curseur (paste, coller)
p
    colle les lignes après le curseur

Annuler ou répéter des modifications

u
    annule la dernière modification (undo, défaire)
U
    annule toutes les modifications effectuées sur la ligne courante
.
    (un point) répète les dernières modifications

Copier-coller de texte dans un fichier

ma
    marque la position "a" dans le fichier
mb
    marque la position "b" dans le fichier
:'a,'b nom_de_fichier
    copie dans le fichier nommé nom_de_fichier le texte situé entre la position "a" et la position "b"

Insertion du contenu d'un autre fichier

:r nom_de_fichier
    insère tout le contenu du fichier nommé nom_de_fichier (read, lire)

Rechercher et remplacer

/motif
    recherche motif en allant vers la fin du document
?motif
    recherche motif en allant vers le début du document
n
    répète la dernière recherche (next, suivant)
N
    retourne au résultat de la précédente recherche effectuée
//[RET]
    répète la dernière recherche
:x,y s/motif/motif2/g
    recherche le motif, en allant de la ligne numérotée x à la ligne y, et le remplace par motif2
:g/motif/s//motif2/g
    recherche dans tous les fichiers le motif et la remplace par motif2 (global)
:g/motif/s//motif2/gc
    idem, mais demande une confirmation avant de remplacer

Rafraîchir l'affichage

C'était très utile avec les anciens terminaux et les liaisons réseau erratiques provoquant des problèmes d'affichage. Cela ne l'est guère plus.

[CTRL]l
    (control-L) rafraîchit l'affichage
%[RET]
    rafraîchit l'affichage et place le curseur en haut
%
    rafraîchit l'affichage et place le curseur au milieu
%-
    rafraîchit l'affichage et place le curseur en bas

