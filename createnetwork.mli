type intermediateweights = float array array array array
type intermediateoutput = float array
val initReseau : Importscans.image array -> int -> intermediateweights
val computeNeurons :
  intermediateweights ->Importscans.image array -> intermediateoutput
