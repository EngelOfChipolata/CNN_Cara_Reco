val learnFromNothing :
  (Importscans.image * int) array ->
  Computevision.info_network ->
  int -> int -> float -> float -> Transform.inlineWeights * Transform.inlineWeights array

val learnFromFile :
  (Importscans.image * int) array ->
  string -> int -> float -> float -> Transform.inlineWeights * Transform.inlineWeights array

val makeTuple : int -> 'a ref -> string -> Importscans.image * 'a

val recup : int -> int ref -> int -> Importscans.image * int

val getSample : int -> (Importscans.image * int) array


