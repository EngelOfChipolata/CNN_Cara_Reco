open Types
let () =
  let infos = [LineFinal 2] in

  let zz = LineValues [|0.;0.|] in
  let zu = LineValues [|0.;1.|] in
  let uz = LineValues [|1.;0.|] in
  let uu = LineValues [|1.;1.|] in
  
  let tab = [|(zz,0);(zu,0);(uz,0);(uu,1)|] in
  let bestweights, pop_finale = Learn.learnFromNothing (tab,(LineNAT 2)) infos 20 100 1. 0.5 in
  
  (*let (infos,bestweights) = Save.open_pop "best" (LineNAT 2) in*)
  
     (*   poids : [|w11;w12;w21;w22;b1;b2|] *)
  (*let weights_ou = [|-2.;-2.;2.;2.;1.;-1.|] in
  let weights_et = [|-1.;-1.;1.;1.;1.5;-1.5|] in
  let bestnet = Transform.lineToTools weights_et infos (LineNAT 2) in*)
  let bestnet = Transform.lineToTools bestweights infos (LineNAT 2) in
  
  Printf.printf "\n0 0\n";
  let result = Computevision.computeVision zz bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) result;
  Printf.printf "\n0 1\n";
  let result = Computevision.computeVision zu bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) result;
  Printf.printf "\n1 0\n";
  let result = Computevision.computeVision uz bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) result;
  Printf.printf "\n1 1\n";
  let result = Computevision.computeVision uu bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) result;
  Printf.printf "Finish%!" 

  
