open Types
let () =
  let infos = [Fil (3,5); Pool 2; Line 100; Line 10] in
  let net = Createnetwork.createNetwork infos 28 in
  let imgs = Importscans.importimg "../../CNN_Cara_Reco/Caracteres/5/231.pgm" 28 in
  let result = Computevision.computeVision imgs net in
  let rere = match result with
               LineValues line -> line
             | Imgs _ -> failwith "[ERROR] Imgs reçu au lieu de LineValues"
             in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) rere;
  let sum = Array.fold_left ( +. ) 0. rere in
  Printf.printf "\nsum = %f\n" sum;;
  
