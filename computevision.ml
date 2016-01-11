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

let computeImg = fun img network ->
  let convImgs = Convolutional.convoFactory img network.filterImgs in
  let imgsPooled = Pooling.maxPoolConvImg convImgs in
 (* Debug.image_factory "image_test/teteste" imgsPooled;*)
  let interValues = Createnetwork.computeNeurons network.inter_weights imgsPooled in
  let finalValues = Cartoonnetwork.computeNeurons network.final_weights interValues in
  let sum = Array.fold_left (+.) 0. finalValues in
  let final = Array.map (fun i-> i /. sum ) finalValues in
  final

let createNetwork = fun info ->
  let filterimgs = Convolutional.randomfilterfactory info.sizeFil info.nbFil in
  let interw = Createnetwork.initReseau info.sizePooImg info.nbFil info.nbInterNeu in
  let finalw = Cartoonnetwork.initReseau info.nbInterNeu info.nbEndNeu in
  let network = {filterImgs=filterimgs; inter_weights=interw; final_weights=finalw} in
  network
