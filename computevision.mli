type neuronalNetwork = {
  filterImgs : Importscans.image array;
  inter_weights : float array array array array;
  final_weights : float array array;
}
type info_network = {
  nbFil : int;
  sizeFil : int;
  nbInterNeu : int;
  sizePooImg : int;
  nbEndNeu : int;
}
val computeImg : Importscans.image -> neuronalNetwork -> float array
val createNetwork : info_network -> neuronalNetwork
val whatisit : float array -> int
