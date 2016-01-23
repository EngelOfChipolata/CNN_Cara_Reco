open Types
let seuil = fun v ->
  let send = ref 0 in
  if v > 100 then send := 255
  else send := 0;
  !send

      
let importimg = fun imgpath size -> (*Fonction qui lit une image bitmap de taille size*size et renvoie la matrice associée *)
  let channel = open_in imgpath in
  seek_in channel 73;
  let result_matrix = Array.init size (fun _ -> Array.init size (fun _ -> float (int_of_char (input_char channel)))) in
  close_in channel;
  Imgs [|result_matrix|];;
