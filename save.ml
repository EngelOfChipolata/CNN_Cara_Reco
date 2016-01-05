let save_vector = fun file_channel vector ->
  Array.iter (fun elt -> Printf.fprintf file_channel "%f\n" elt) vector;
  Printf.fprintf file_channel "\n"

let save_pop = fun filename info pop ->
  let channel = open_out filename in
  let a,b,c,d,e = info in
  Printf.fprintf channel "%d\n%d\n%d\n%d\n%d\n\n" a b c d e;
  Printf.fprintf channel "%d\n\n" (Array.length pop);
  Array.iter (fun ind -> save_vector channel ind) pop;
  close_out channel

let get_fvalue = fun channel ->
  let st_wei = input_line channel in
  let wei = float_of_string st_wei in
  wei

let get_ind = fun channel nbw ->
  let ind = Array.init nbw (fun _-> get_fvalue channel) in
  let _ = input_line channel in
  ind

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
  let info = (filter_nb, filter_size, nb_neu_inter, pooled_size, nbNeurFin) in
  let nbw = filter_nb * filter_size * filter_size + nb_neu_inter * filter_nb * pooled_size * pooled_size + nb_neu_inter * nbNeurFin in
  let pop = Array.init nb_ind (fun _-> get_ind channel nbw) in
  close_in channel;
  (info, pop)



  
    
