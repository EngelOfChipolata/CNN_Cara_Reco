type datas =
    Imgs       of float array array array      (* float nbImgs IMG  |  souvent nbImgs = 1  |  sert pour double convolution*)
  | LineValues of float array;;
  
type tools =
    FilterImgs of  float array array array (*  float nbFil FILTRE : toutes les imgs en input seront convoluées avec tout les filtres *)
  | Poolfct    of (float array array array  -> datas)(* devrait être  Imgs -> Imgs *)
  | ImgsToLine of float array array array array
(*  | ImgsToLineFinal of float array array array array   TODO (OU PAS) : faire truc correspondant dans createnetwork.ml*)
  | LineToLine of float array array
  | LineToLineFinal of float array array;;

type arg_network_comp =
    Fil  of int * int (*   (nbFiltres, sizeFiltres)  *)
  | Line of int	     (*   nbNeurons                 *)
  | LineFinal of int	     (*   nbNeurons ; use softmax *)
  | Pool of int   (* division (pour l'instant toujours 2) *)

type nature =
    ImgArNAT of int * int  (*   (nb imgs, size imgs)  *)
  | LineNAT  of int        (* nb neur.                *)

