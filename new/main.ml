open Types
let () =
  let infos = [Fil (3,5); Pool 2; Line 100; Line 10] in
  let net = Createnetwork.createNetwork infos in
  (* let result = Computevision.computeImg img net in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res; *)
  Printf.printf "coucou !\n"
  
