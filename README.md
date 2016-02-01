# CNN_Cara_Reco
Convolutional Neuronal Network and application in Caracters Recognition

## Créer le réseau de neurones
Pour créer un réseau, il faut définir sa forme.

Pour cela, il faut d'abord céer une liste d'éléments de type arg\_network\_comp.  
Il y a plusieurs possibilités :
+ _Fil  of int * int_ : désigne des filtres de convolutions. Le premier argument est le nombres de filtres, et le second la taille des filtres.
+ _Line of int_ : désigne une couche simple de neurones qui sera fully connected. L'argument est le nombre de neurones.
+ _LineFinal of int_ : même chose que _Line of int_ mais certaines fonctions appliquerons des traitements différents à une couche de ce type, comme l'utilisation du softmax pour la fonction d'activation.
+ _Pool of int_ : désigne une fonction de pooling. L'argument est le nombre par lequel sera divisé la taille des images.

Le réseau à construire dépend fortement du format des données d'entrées, et certains traitement n'ont pas de sens avec certain types de données.  
Il est donc important de préciser de quel type sera l'entrée du réseau afin de les fonctions appropriés construisent le bon réseau et détectent les éventuelles incohérences. Il faut pour cela utiliser le type _nature_.

Il y a deux possibilités :
+ _ImgArNAT of int * int_ : cela désigne un tableau d'images, avec en argument le nombre d'images, puis la taille des images (supposées carrées)
+ _LineNAT  of int_ : désigne un simple vecteur, avec comme argument le nombre d'éléments.

La création du réseau se fait alors grâce à la fonction _createNetwork_ du fichier _createnetwork.ml_. Cette fonction prends en argument la liste précédemment crée ainsi que la nature des données d'entrées, et renvoie le réseau, dont les poids ont été initialisés aléatoirement.

Le réseau en lui même est une liste d'éléments de type _tools_. L'utilisateur n'est pas sensé accéder à cette profondeur de détail.

Supposons que l'on veuille créer un réseau composé d'une convolution avec 3 matrices de 5x5, puis un pooling, une couche cachée vecteur de 103 neurones et enfin la couche de sortie de 8 neurones, la liste d'élément à fournir est la suivante : _[Fil (3,5); Pool 2; Line 103; LineFinal 8]_

Si l'entrée est un tableau de 4 images de 34x34 pixels, la nature sera la suivante : _ImgArNAT (4,34)_

## Appliquer le traitement à une données d'entrée
Pour appliquer le traitement d'un réseau à une donnée, et il faut appeler la fonction _computeTools_ ou la fonction _computeVision_ du fichier _computevision.ml_.
La fonction _computeVision_ appelle simplement la fonction _computeTools_ et s'assure que les données en sortie soit du type _LineValues_. Si ce comportement n'est pas souhaité, c'est donc la première fonction qui faut appeler.

Ces fonctions prennent deux arguments : les données d'entrées, et le réseau de neurone.

Les données ne peuvent êtres que de deux types :
+ _Imgs_ : un tableau d'images
+ _LineValues_ : un vecteur

La aussi, si une incohérence est détectée (par exemple : vouloir convoluer ou appliquer le pooling à un vecteur), une exception sera levée.

## Charger une image
Charger une image est très simple : ilf aut appelerla fonction _importimg_ du ficher _importscans.ml_. Cette fonction prend en argument le chemin vers l'image.

## Changer le format du réseau
On peut être amener à avoir le réseau sous la forme d'un simple vecteur. Il faut alors utiliser les fonctions _toolsToLine_ et _lineToTools_ du fichier _transform.ml_.
La première fonction prend en paramètre un réseau et retourne un vecteur.  
La deuxième prend en paramètres un vecteur, une liste représentant l'architecture du réseau (cf __Créer le réseau de neurones__ ) et la nature des données d'entrées (cf idem). Elle renvoie ensuite le réseau sous sa forme classique.
