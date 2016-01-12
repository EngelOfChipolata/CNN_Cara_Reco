(* sauvegarde un tableau de float dans un fichier *)
let save_vector = fun file_channel vector ->
  Array.iter (fun elt -> Printf.fprintf file_channel "%f\n" elt) vector;
  Printf.fprintf file_channel "\n"

(* sauvegarde une population de réseau (format inline) *)
let save_pop = fun filename info pop ->
  let channel = open_out filename in
  Printf.fprintf channel "%d\n%d\n%d\n%d\n%d\n\n" info.Computevision.nbFil info.Computevision.sizeFil info.Computevision.nbInterNeu info.Computevision.sizePooImg info.Computevision.nbEndNeu;
  Printf.fprintf channel "%d\n\n" (Array.length pop);
  Array.iter (fun ind -> save_vector channel ind) pop;
  close_out channel

(* lis un float depuis le fichier *)
let get_fvalue = fun channel ->
  let st_wei = input_line channel in
  let wei = float_of_string st_wei in
  wei

(* lis nbw float dans le fichier *)
let get_ind = fun channel nbw ->
  let ind = Array.init nbw (fun _-> get_fvalue channel) in
  let _ = input_line channel in
  ind

(* ouvre un fichier de population, et renvoie les infos nécessaires et la population de réseau (format inline) *)
let open_pop = fun filename ->
  let channel = open_in filename in
  (* filter_nb, filter_size, nb_neu_inter, pooled_size, nbNeurFin *)
  let filter_nb = int_of_string (input_line channel) in
  let filter_size = int_of_string (input_line channel) in
  let nb_neu_inter = int_of_string (input_line channel) in
  let pooled_size = int_of_string (input_line channel) in
  let nbNeurFin = int_of_string (input_line channel) in
  let _ = input_line channel in
  let nb_ind = int_of_string (input_line channel) in
  let _ = input_line channel in
  let info = {Computevision.nbFil=filter_nb; Computevision.sizeFil=filter_size; Computevision.nbInterNeu=nb_neu_inter; Computevision.sizePooImg=pooled_size; Computevision.nbEndNeu=nbNeurFin} in
  let nbw = filter_nb * filter_size * filter_size + nb_neu_inter * filter_nb * pooled_size * pooled_size + nb_neu_inter * nbNeurFin in
  let pop = Array.init nb_ind (fun _-> get_ind channel nbw) in
  close_in channel;
  (info, pop)



  
    
