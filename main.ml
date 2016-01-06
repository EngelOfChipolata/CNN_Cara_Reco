let () =

  let inf = {Computevision.nbFil=4; Computevision.sizeFil=3; Computevision.nbInterNeu=50; Computevision.sizePooImg=12; Computevision.nbEndNeu=10} in

  let info, population_init =
    if (Array.length Sys.argv > 1)
    then
      Save.open_pop Sys.argv.(1)
    else
     (inf, Transform.createInlinePopulation inf 10 )
  in
  
  let img0 = Importscans.importimg "Caracteres/1/10.pgm" 28 28 in
  let img1 = Importscans.importimg "Caracteres/2/58.pgm" 28 28 in
  let img2 = Importscans.importimg "Caracteres/3/5.pgm" 28 28 in
  let img3 = Importscans.importimg "Caracteres/5/3.pgm" 28 28 in
  let img4 = Importscans.importimg "Caracteres/7/24.pgm" 28 28 in
  let img5 = Importscans.importimg "Caracteres/8/31.pgm" 28 28 in
  let img6 = Importscans.importimg "Caracteres/9/18.pgm" 28 28 in
  let img7 = Importscans.importimg "Caracteres/4/18.pgm" 28 28 in
  let img8 = Importscans.importimg "Caracteres/6/18.pgm" 28 28 in
  let img9 = Importscans.importimg "Caracteres/1/18.pgm" 28 28 in
  let img10 = Importscans.importimg "Caracteres/2/18.pgm" 28 28 in
  let tab = [|(img0,1); (img1,2); (img2,3); (img3,5); (img4,7); (img5,8); (img6,9); (img7,4); (img8,6); (img9,1); (img10,2)|] in
  
  let evalfun = fun net -> Neteval.evalNet Computevision.computeImg tab (Transform.tabToSave net info) in
  let bestweights, pop_finale = Learn.learnFromNothing tab info 25 100 1. 0.5 in
  Printf.printf "\nIndividu final :\n";
  Printf.printf "%f\n" (evalfun bestweights);

