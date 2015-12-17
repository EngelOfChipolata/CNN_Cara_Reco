type neuronalNetwork = {
    filterImgs : int array array array;
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

let createNetwork = fun () ->
  let filter_width = 3 in
  let filter_height = 3 in
  let filter_nb = 4 in
  let pooled_width = 13 in
  let pooled_height = 13 in
  let nb_neu_inter = 100 in
  let filterimgs = Convolutional.randomfilterfactory filter_width filter_height filter_nb in
  let interw = Createnetwork.initReseau pooled_width pooled_height filter_nb nb_neu_inter in
  let finalw = Cartoonnetwork.initReseau nb_neu_inter 10 in
  let network = {filterImgs=filterimgs; inter_weights=interw; final_weights=finalw} in
  network

let () =
  let net = createNetwork () in
  let img = Importscans.importimg "Caracteres/1/10.pgm" 28 28 in
  let values = computeImg img net in
  Array.iter (fun i -> Printf.printf "%f  " i ) values;
  Printf.printf "\n";

  let img = Importscans.importimg "Caracteres/1/58.pgm" 28 28 in
  let values = computeImg img net in
  Array.iter (fun i -> Printf.printf "%f  " i ) values;
  Printf.printf "\n\n";
  
  let img = Importscans.importimg "Caracteres/8/5.pgm" 28 28 in
  let values = computeImg img net in
  Array.iter (fun i -> Printf.printf "%f  " i ) values;
  Printf.printf "\n";

    
  let img = Importscans.importimg "Caracteres/8/55.pgm" 28 28 in
  let values = computeImg img net in
  Array.iter (fun i -> Printf.printf "%f  " i ) values;
  Printf.printf "\n\n"
