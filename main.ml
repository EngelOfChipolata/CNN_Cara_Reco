let darwin = fun () ->
  let inf = {Computevision.nbFil=4; Computevision.sizeFil=3; Computevision.nbInterNeu=50; Computevision.sizePooImg=12; Computevision.nbEndNeu=10} in

  let info, population_init =
    if (Array.length Sys.argv > 1)
    then
      Save.open_pop Sys.argv.(1)
    else
     (inf, Transform.createInlinePopulation inf 10 )
  in
  
(*  let img0 = Importscans.importimg "Caracteres/4/10.pgm" 28 28 in
  let img1 = Importscans.importimg "Caracteres/4/58.pgm" 28 28 in
  let img2 = Importscans.importimg "Caracteres/4/5.pgm" 28 28 in
  let img3 = Importscans.importimg "Caracteres/4/3.pgm" 28 28 in
  let img4 = Importscans.importimg "Caracteres/4/24.pgm" 28 28 in
  let img5 = Importscans.importimg "Caracteres/4/31.pgm" 28 28 in
  let img6 = Importscans.importimg "Caracteres/9/18.pgm" 28 28 in
  let img7 = Importscans.importimg "Caracteres/4/18.pgm" 28 28 in
  let img8 = Importscans.importimg "Caracteres/5/18.pgm" 28 28 in
  let img9 = Importscans.importimg "Caracteres/1/18.pgm" 28 28 in
    let img10 = Importscans.importimg "Caracteres/2/18.pgm" 28 28 in
    let tab = [|(img0,4); (img1,4); (img2,4); (img3,4); (img4,4); (img5,4); (img6,9); (img7,4); (img8,6); (img9,1); (img10,2)|] in*)
  let tab = Learn.getSample 100 in
  let evalfun = fun net -> Neteval.evalNet Computevision.computeImg tab (Transform.tabToSave net info) in
  let bestweights, pop_finale = Learn.learnFromNothing tab info 25 100 1. 0.5 in
  let best = [|bestweights|] in
  Save.save_pop "best" info best;
  Printf.printf "\nIndividu final :\n";
  Printf.printf "%f\n" (evalfun bestweights);;

let use_net= fun () ->
  let info, population_init =
    if (Array.length Sys.argv > 2)
    then
      Save.open_pop Sys.argv.(1)
    else
     failwith "Use: CNN net_file path_to img"
  in
  
  let net = Transform.tabToSave population_init.(0) info in
  
  let img = Importscans.importimg Sys.argv.(2) 28 28 in
  let res = Computevision.computeImg img net in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;;

let () =
  if (Array.length Sys.argv > 2)
  then
    use_net ()
  else
    darwin ();
  ignore 3

  

