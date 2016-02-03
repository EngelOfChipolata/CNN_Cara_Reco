(*Ce main permet d'apprendre des 0 et des 1 *)
open Types
let () =
  (*let infos = [Fil (3,5); Pool 2; Line 100; LineFinal 10] in*)
  let infos = [Fil (2,5); Pool 2; Line 10; LineFinal 2] in
  
  let tab1 = Array.init 100 (fun i -> ((Importscans.importimg ("Caracteres/0/"^(string_of_int i)^".pgm")), 0)) in
  let tab2 = Array.init 100 (fun i -> ((Importscans.importimg ("Caracteres/1/"^(string_of_int i)^".pgm")), 1)) in
  let tab = Array.append tab1 tab2 in

  let test1 = Array.init 10 (fun i -> Importscans.importimg ("Caracteres/0/"^(string_of_int (i+200))^".pgm")) in
  let test2 = Array.init 10 (fun i -> Importscans.importimg ("Caracteres/1/"^(string_of_int (i+200))^".pgm")) in
  let test = Array.append test1 test2 in

  (*
  let tab = Learn.getSample 100 in
  let tab = [| (img,0);(img2,1);(img3,1); |] in*)
  let bestweights, pop_finale = Learn.learnFromNothing (tab,(ImgArNAT (1,28))) infos 50 1000 1. 0.8 in
  
  let bestnet = Transform.lineToTools bestweights infos (ImgArNAT (1,28)) in

  for i=0 to (Array.length test -1) do

  Printf.printf "echantillon: \n";
    let res = Computevision.computeVision test.(i) bestnet in
    Array.iter (fun elt -> Printf.printf "%f\n" elt) res;
  done;

  Printf.printf "%f\n" (Neteval.evalNet Computevision.computeVision tab bestnet);

  
  Save.save_pop "best" infos [|bestweights|];
  Save.save_pop "poppp" infos pop_finale;
  Printf.printf "Finish%!" 

  
