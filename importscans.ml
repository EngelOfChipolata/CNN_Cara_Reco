open Types
let seuil = fun v ->
  let send = ref 0 in
  if v > 100 then send := 255
  else send := 0;
  !send

      
let importimg = fun imgpath -> (*Fonction qui lit une image bitmap de taille size*size et renvoie la matrice associée *)
  let channel = open_in imgpath in

  let rec getSize = fun () ->
         try
             let line = input_line channel in
             let nb,nb2 = Scanf.sscanf line "%d %d" (fun s1 s2 -> (s1,s2)) in
             nb
         with Scanf.Scan_failure _ -> getSize ()
            | End_of_file -> getSize ()
  in
  
  let size = getSize () in
  
  
  ignore(input_line channel);
  let result_matrix = Array.init size (fun _ -> Array.init size (fun _ -> float (int_of_char (input_char channel)))) in
  close_in channel;
  Imgs [|result_matrix|];;
