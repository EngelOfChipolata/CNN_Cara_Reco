type neuronalNetwork = {
    filterImgs : Importscans.image array;
    inter_weights : float array array array array;
    final_weights : float array array;
  }
    
let computeImg = fun img network ->
  let convImgs = Convolutional.convoFactory img network.filterImgs in
  let imgsPooled = Pooling.maxPoolConvImg convImgs in
 (* Debug.image_factory "image_test/teteste" imgsPooled;*)
  let interValues = Createnetwork.computeNeurons network.inter_weights imgsPooled in
  let finalValues = Cartoonnetwork.computeNeurons network.final_weights interValues in
  finalValues

let createNetwork = fun info ->
  let filter_nb, filter_size, nb_neu_inter, pooled_size, nbNeurFin = info in
  
  let filterimgs = Convolutional.randomfilterfactory filter_size filter_nb in
  let interw = Createnetwork.initReseau pooled_size filter_nb nb_neu_inter in
  let finalw = Cartoonnetwork.initReseau nb_neu_inter nbNeurFin in
  let network = {filterImgs=filterimgs; inter_weights=interw; final_weights=finalw} in
  network
