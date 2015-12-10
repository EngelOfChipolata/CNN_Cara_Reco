type intermediateweights = float array array array array
type intermediateoutput = float array
val initReseau : int -> int -> int -> int -> intermediateweights
val computeNeurons :
  intermediateweights ->Importscans.image array -> intermediateoutput
