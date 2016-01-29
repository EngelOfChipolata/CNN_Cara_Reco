(* représente les valeurs d'une couche : soit un tableau d'images, soit un vecteur en ligne *)
type datas =
    Imgs       of float array array array      (* float nbImgs IMG  |  souvent nbImgs = 1  |  sert pour double convolution*)
  | LineValues of float array;;

(* Les différents outils pouvant êtres appliqués entre deux couches. *)
type tools =
    FilterImgs of  float array array array                     (*  float nbFil FILTRE : toutes les imgs en input seront convoluées avec tout les filtres *)
  | Poolfct    of (float array array array  -> datas)          (* la fonction de pooling qui va être utilisée.   (devrait être de type Imgs -> Imgs) *)
  | ImgsToLine of (float array array array * float) array      (* les poids et biais pour passer d'une couche d'images à une couche 'en ligne' *)
  | LineToLine of (float array * float) array                  (* les poids et biais pour passer d'une couche 'en ligne' à une autre couche 'en ligne' *)
  | LineToLineFinal of (float array * float) array;;           (* la même chose, mais indique que c'est la couche de sortie (-> utilisation du softmax) *)

(* Ces types simples servent à indiquer la structure voulue du réseau à la fonction qui va créer le réseau *)
type arg_network_comp =
    Fil  of int * int        (* filtres de convolution : (nbFiltres, sizeFiltres)  *)
  | Line of int	             (* ligne de neurones avec le nombre de neurones *)
  | LineFinal of int	     (* pareil, indique que c'est la dernière ligne pour un traitement particulier *)
  | Pool of int              (* pooling : facteur de division (pour l'instant toujours 2) Il serait mieux de donner en paramètre la fonction à utiliséer elle même *)

(* nature de la structure de donnée à un point du réseau *)
type nature =
    ImgArNAT of int * int  (* tableau d'image (nb imgs, size imgs)  *)
  | LineNAT  of int        (* ligne nb_neurones *)

