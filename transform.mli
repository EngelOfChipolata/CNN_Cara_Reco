type inlineWeights = float array

val saveToTab : Computevision.neuronalNetwork -> inlineWeights
val tabToSave :
  inlineWeights -> Computevision.info_network -> Computevision.neuronalNetwork
val createInlinePopulation :
  Computevision.info_network -> int -> inlineWeights array
