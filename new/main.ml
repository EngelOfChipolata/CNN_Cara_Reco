open Types
let () =
  let infos = [Fil (3,5); Pool 2; Line 100; Line 10] in
  let net = Createnetwork.createNetwork infos 28 in
  let imgs = Importscans.importimg "../../CNN_Cara_Reco/Caracteres/5/231.pgm" 28 in
  let result = Computevision.computeVision imgs net in
  (* Array.iter (fun elt -> Printf.printf "%f\n" elt) result; *)
  Printf.printf "%f\n" result.(0);
  Printf.printf "coucou !\n"
  
