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

(* computeImg calcule le vecteur final en prenant en paramètres l'image et le réseau de neurones *)
let computeImg = fun img network ->
  let convImgs = Convolutional.convoFactory img network.filterImgs in
  let imgsPooled = Pooling.maxPoolConvImg convImgs in
  let interValues = Createnetwork.computeNeurons network.inter_weights imgsPooled in
  let finalValues = Cartoonnetwork.computeNeurons network.final_weights interValues in
  let sum = Array.fold_left (+.) 0. finalValues in
  let final = Array.map (fun i-> i /. sum ) finalValues in
  final

(* createNetwork crée un réseau de neurones aléatoire *)
let createNetwork = fun info ->
  let filterimgs = Convolutional.randomfilterfactory info.sizeFil info.nbFil in
  let interw = Createnetwork.initReseau info.sizePooImg info.nbFil info.nbInterNeu in
  let finalw = Cartoonnetwork.initReseau info.nbInterNeu info.nbEndNeu in
  let network = {filterImgs=filterimgs; inter_weights=interw; final_weights=finalw} in
  network

(* retourne le nombre associé au vecteur résultat *)
let whatisit = fun finalvalues ->
  let getimax = fun tab ->
    let i = ref 0 in
    let max = ref (-. infinity) in
    let savei = fun index elt ->
      if (elt > !max)
      then begin
        i := index;
        max := elt;
      end
    in
    Array.iteri savei tab;
    !i
  in
  getimax finalvalues
