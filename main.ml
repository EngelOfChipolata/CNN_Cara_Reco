let () =
  let info = (3, 4, 100, 12, 10) in
  let img0 = Importscans.importimg "Caracteres/1/10.pgm" 28 28 in
  let img1 = Importscans.importimg "Caracteres/2/58.pgm" 28 28 in
  let img2 = Importscans.importimg "Caracteres/3/5.pgm" 28 28 in
  let img3 = Importscans.importimg "Caracteres/5/3.pgm" 28 28 in
  let img4 = Importscans.importimg "Caracteres/7/24.pgm" 28 28 in
  let img5 = Importscans.importimg "Caracteres/8/31.pgm" 28 28 in
  let img6 = Importscans.importimg "Caracteres/9/18.pgm" 28 28 in
  let tab = [|(img0,1); (img1,2); (img2,3); (img3,5); (img4,7); (img5,8); (img6,9)|] in
  let evalfun = fun net -> Neteval.evalNet Computevision.computeImg tab (Transform.tabToSave net info) in
  let population_init = Transform.createInlinePopulation info 5 in
  Printf.printf "Population initiale :\n";
  Array.iter (fun ind -> Printf.printf "%f\n" (evalfun ind)) population_init;
  let bestweights, pop_finale = De.de population_init 5 1. 0.8 evalfun in
  Printf.printf "\nIndividu final :\n";
  Printf.printf "%f" (evalfun bestweights);
  Save.save_pop "tata" info pop_finale
  

