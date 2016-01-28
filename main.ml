open Types
let () =
  (*let infos = [Fil (3,5); Pool 2; Line 100; LineFinal 10] in*)
  let infos = [Line 4; LineFinal 2] in
  
  let img = Importscans.importimg "0.pgm" in
  let img2 = Importscans.importimg "3.pgm" in
  
  let imgtest = Importscans.importimg "0.2.pgm" in
  let imgtest2 = Importscans.importimg "3.2.pgm" in


  (*
  let tab = Learn.getSample 100 in*)
  let tab = [| (img,0);(img2,1) |] in
  let bestweights, pop_finale = Learn.learnFromNothing (tab,(ImgArNAT (1,28))) infos 50 1000 1. 0.5 in
  
  let bestnet = Transform.lineToTools bestweights infos (ImgArNAT (1,28)) in
  
  Printf.printf "echantillon 0: \n";
  let res = Computevision.computeVision img bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "echantillon 3: \n";
  let res = Computevision.computeVision img2 bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "\ntest 0: \n";
  let res = Computevision.computeVision imgtest bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Printf.printf "test 3: \n";
  let res = Computevision.computeVision imgtest2 bestnet in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  
  Save.save_pop "best" infos [|bestweights|];
  Save.save_pop "poppp" infos pop_finale;
  Printf.printf "Finish%!" 

  
