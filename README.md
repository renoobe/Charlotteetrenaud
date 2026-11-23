# Charlotte Rouart & Renaud Arnaudet · portfolio

Proto v0.1 du concept **« La pile »** : un bureau d'ado, une pile d'objets culturels (VHS, boîte de jeu, CD-ROM, K7, vinyle…).
Chaque tranche est un projet. Au survol (ou au doigt sur mobile) l'objet dépasse de la pile ; au clic il sort, s'ouvre, et la fiche projet apparaît.

- `prototype/pile.html` : la source du proto (fragment publié tel quel en Artifact).
- `prototype/index.html` : la même page en version autonome (générée par `prototype/build.sh`), à ouvrir dans un navigateur.

Tout le contenu est dans le tableau `ITEMS` en haut du script : un projet = une entrée avec un `fmt` (vhs, bigbox, cd, vinyl, magazine, book, photos, cart, k7, floppy).
L'objet est dessiné à partir du format, sans modèle 3D à refaire pour chaque projet.
