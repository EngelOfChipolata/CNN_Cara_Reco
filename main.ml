open Types
let () =
  (*let infos = [Fil (3,5); Pool 2; Line 100; LineFinal 10] in*)
  let infos = [Fil (2,5); Pool 2; Line 10; LineFinal 2] in
  
  let tab = Array.init 10 (fun i -> ((Importscans.importimg "Caracteres/0/"^i^".pgm"), 0)) in


  (*
  let tab = Learn.getSample 100 in
  let tab = [| (img,0);(img2,1);(img3,1); |] in*)
  let bestweights, pop_finale = Learn.learnFromNothing (tab,(ImgArNAT (1,28))) infos 50 1000 1. 0.8 in
  
  let bestnet = Transform.lineToTools bestweights infos (ImgArNAT (1,28)) in
  
  Printf.printf "echantillon 0: \n";
  let res = Computevision.computeVision img bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "echantillon 1: \n";
  let res = Computevision.computeVision img2 bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "\ntest 0: \n";
  let res = Computevision.computeVision imgtest bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "test 1: \n";
  let res = Computevision.computeVision imgtest2 bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Save.save_pop "best" infos [|bestweights|];
  Save.save_pop "poppp" infos pop_finale;
  Printf.printf "Finish%!" 

  
