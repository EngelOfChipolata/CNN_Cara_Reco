(*Module qui importe les images*)

type image = float array array (* Une image est en fait une matrice de nombres (entre 0 et 255) *)

let importimg = fun imgpath size -> (*Fonction qui lit une image bitmap de taille size*size et renvoie la matrice associée *)
  let channel = open_in imgpath in
  seek_in channel 73;
  let result_matrix = Array.init size (fun _ -> Array.init size (fun _ -> float (int_of_char (input_char channel))/.255.)) in
  result_matrix;;
