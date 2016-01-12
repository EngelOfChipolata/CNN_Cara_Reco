(* utilisation : ./CNN pour lancer l'apprentissage, ./CNN population_file caractere.pgm pour sortir le résultat. Dans ce dernier cas, le premier individu est pris *)

let darwin = fun () ->
  let inf = {Computevision.nbFil=4; Computevision.sizeFil=3; Computevision.nbInterNeu=50; Computevision.sizePooImg=12; Computevision.nbEndNeu=10} in

  let info, population_init =
    if (Array.length Sys.argv > 1)
    then
      Save.open_pop Sys.argv.(1)
    else
     (inf, Transform.createInlinePopulation inf 10 )
  in
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
  
  let img = Importscans.importimg Sys.argv.(2) 28 in
  let res = Computevision.computeImg img net in
  Array.iter (fun elt -> Printf.printf "%f\n" elt) res;;

let () =
  if (Array.length Sys.argv > 2)
  then
    use_net ()
  else
    darwin ();
