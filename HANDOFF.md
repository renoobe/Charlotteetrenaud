# Passation : portfolio « La pile » (Charlotte Rouart & Renaud Arnaudet)

À coller au début d'une nouvelle conversation Claude Code **en local** (sur le Mac, avec l'extension Claude in Chrome connectée), depuis le dossier du dépôt `renoobe/charlotteetrenaud`, branche `claude/we-are-social-portfolio-vo2cs9`.

---

## Qui et quoi

Renaud Arnaudet et Charlotte Rouart sont Creative Directors chez We Are Social Paris. Ils travaillent en binôme depuis 15 ans et n'ont plus de portfolio depuis un an.
Objectif : un book en ligne, mobile et desktop, très stylé, fluide, simple à visiter et simple à mettre à jour. Il doit faire **crafté et réaliste, surtout pas IA ni template**.

## Le concept validé : « La pile »

Un bureau ou un mur d'ado avec une pile d'objets culturels. Chaque **tranche** est un projet.
- Au survol (au doigt sur mobile), l'objet dépasse de la pile, avec une étiquette qui donne le nom du projet.
- Au clic, il sort de la pile, pivote pour montrer sa couverture, **s'ouvre selon son format**, et une fiche projet apparaît.
- La pile se tasse quand on retire un objet et se reforme quand on le range.
- Une **vue liste** (catalogue façon vidéoclub) sert aux visiteurs pressés.
- Précédent / suivant, swipe, Échap, et un lien direct vers chaque projet (`#id`).

Correspondance projet → objet :
| Type de projet | Objet |
|---|---|
| Film TV / **film VOL** (vidéo online) | Cassette VHS (ou DVD pour les plus récents) |
| Jeu / gaming | Boîte de jeu « big box » ou cartouche |
| App / digital / site | CD-ROM ou disquette |
| Radio / son | K7 audio ou vinyle 45 T |
| **Print** / affichage / presse | Magazine (ou affiche, carton à dessin) |
| Social / contenus | Pochette de tirages photo |
| Édition / brand content | Livre de poche |
| **Campagne 360** | **Coffret collector** : on l'ouvre et dedans il y a les pièces de la campagne (VHS du film, magazine du print, K7 de la radio, tirages du social). Chaque pièce est cliquable. |

Projets déjà connus : Renault (film TV, ≈ 2016) en **VHS**, Sea Shepherd × Dave the Diver (jeu) en **boîte de jeu**, Super U (app mobile, ≈ 2016) en **CD-ROM**.

## État actuel

- `prototype/pile.html` : proto v0.1, objets dessinés en CSS en fausse perspective. Source publiée en Artifact : https://claude.ai/artifact/6ZcrWwbgeA1atL17RDDgDB
- `prototype/index.html` : la même page en version autonome, générée par `prototype/build.sh`.
- Les mécaniques marchent : survol, sortie, ouverture par format, liste, mobile, écran CRT pour les films.
- **Retour de Renaud sur la v0.1 : « horriblement moche ».** Le rendu CSS à plat, les étiquettes Dymo et la police marqueur font cheap et cartoon. Il faut que ça paraisse **réaliste et crafté**.

## Tâche 1 : audit des projets existants (via Chrome)

Renaud a un onglet ouvert sur sa preview Adobe Portfolio (non publique) :
https://portfolio.adobe.com/a9b1a2b7-04d1-4347-8f6d-07049e796ce8/preview/work

1. Faire `tabs_context_mcp`, puis naviguer dans **chaque projet** de la preview.
2. Extraire pour chaque projet : titre, client, année, type (film TV, film VOL, print, 360, social, app, jeu…), agence, rôle, pitch / texte existant, prix, crédits, liens vidéo (Vimeo / YouTube), et la liste des visuels (URL des images).
3. Écrire le tout dans `content/projects/<slug>.md` : un fichier par projet, frontmatter YAML avec `format:` choisi d'après le tableau ci-dessus. Ne rien inventer : ce qui manque est marqué `TODO`.
4. Rendre un **audit court** :
   - est-ce que chaque projet trouve son objet ;
   - combien d'objets au total, et la pile reste-t-elle lisible (au-delà d'une quinzaine, prévoir deux piles ou une étagère) ;
   - les trous d'info ;
   - les projets à regrouper dans un coffret 360 ;
   - ceux qui sont trop faibles pour être dans le book.
5. Télécharger les visuels utiles dans `content/media/` (en local seulement, ne rien envoyer à un service externe sans accord).

## Tâche 2 : refonte visuelle en vraie 3D réaliste

Plan déjà réfléchi, à valider avec Renaud puis à exécuter :
- **Three.js** (version épinglée, par ex. `three@0.160.0`). Objets aux **vraies dimensions en cm** : VHS 20,5 × 3,2 × 13 ; big box 24 × 6 × 19 ; jewel case CD 14,2 × 1 × 12,5 ; magazine 28 × 0,7 × 21 ; poche 18 × 2,4 × 11 ; K7 11 × 1,7 × 7 ; disquette 9 × 0,33 × 9,3 ; coffret 26 × 7,5 × 20.
- Textures peintes en **canvas** à partir des données du projet, avec les couches de réalisme : grain papier, bords frottés, rayures, sticker de vidéoclub (« N° 0457 », pastille « 48 H »), reflet du plastique, code-barres, prix. On ne refait pas de modèle 3D par projet : un format = un moule.
- Matières : `MeshPhysicalMaterial`, clearcoat pour les boîtiers plastique et le papier glacé, carton mat pour les boîtes. Environnement `RoomEnvironment`.
- Lumière : une lampe de bureau chaude (SpotLight, ombres douces PCFSoft), un fill froid, un léger contre-jour. Tone mapping ACES. Bureau en bois texturé, mur mat.
- Pile un peu en désordre : petites rotations et décalages aléatoires. Des zones de clic invisibles d'au moins 1,6 cm d'épaisseur pour les objets fins.
- Animations : survol = l'objet glisse vers la caméra ; clic = il sort, monte et pivote face caméra (couverture droite) ; un plan sombre atténue la pile derrière.
- Ouvertures : la cassette sort du boîtier VHS ; le couvercle de la big box et du coffret pivote sur l'arête du fond ; le boîtier CD, le magazine et le livre pivotent sur la tranche (charnière avant) ; la pochette de tirages laisse sortir les photos.
- Repère UV utile : sur `BoxGeometry`, la face +y a u selon +x et v=1 vers −z. Une couverture dont la tranche est le bord gauche de l'art doit être dessinée tournée de −90° (haut de l'art vers −x), puis affichée avec une rotation Rz(−90°) en pose finale.
- Interface sobre : noms en Instrument Sans, infos en IBM Plex Mono, petite taille. Plus de Dymo ni de police marqueur dans l'interface. L'écriture manuscrite reste seulement sur les étiquettes des objets, avec une police plus « stylo » (Caveat). La fiche projet est un panneau à droite sur desktop et une feuille en bas sur mobile.
- Mobile : la pile tient sur un écran ; on glisse le doigt pour faire dépasser les objets, on touche pour ouvrir.
- Vérifier avec des captures Playwright (desktop 1440×900 et iPhone) : pas de scroll horizontal, pas d'erreur console.

## Tâche 3 : vraie stack (après validation)

Astro, une fiche Markdown par projet dans `content/projects/`, la pile 3D en îlot client, la vue liste en HTML statique (bon pour le SEO et l'accessibilité). Hébergement Netlify ou Vercel, nom de domaine à eux. Ajouter un projet = ajouter un fichier `.md` et des images.

## Règles

- Ne jamais inventer d'info projet (années, résultats, prix) : marquer `TODO`.
- Aucun logo de marque reproduit : les noms de clients en texte seulement. Pas de recréation d'un jeu existant (pour Dave the Diver, une jaquette originale).
- Répondre à Renaud en français, ton direct, tutoiement.
- Committer et pousser sur `claude/we-are-social-portfolio-vo2cs9`.
