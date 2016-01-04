type neuronalNetwork = {
  filterImgs : Importscans.image array;
  inter_weights : float array array array array;
  final_weights : float array array;
}
val computeImg : Importscans.image -> neuronalNetwork -> float array
val createNetwork : unit -> neuronalNetwork
