(* utilisation : ./CNN pour lancer l'apprentissage, ./CNN population_file caractere.pgm pour sortir le résultat. Dans ce dernier cas, le premier individu est pris *)

let darwin = fun () ->

let inf = {Computevision.nbFil=4; Computevision.sizeFil=4; Computevision.nbInterNeu=100; Computevision.sizePooImg=11; Computevision.nbEndNeu=10} in
  let info, population_init =
    if (Array.length Sys.argv > 1)
    then
      Save.open_pop Sys.argv.(1)
    else
     (inf, Transform.createInlinePopulation inf 10 )
  in
  let tab = Learn.getSample 150 in
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



let maxTab = fun tab ->
  let max = ref 0. in
  let number = ref 0 in
  for i = 0 to (Array.length tab)-1 do
    if tab.(i) > !max then
      begin
        max := tab.(i);
        number := i;
      end;
  done;
  !number
    
let test = fun () ->
  let info, population_init =
    if (Array.length Sys.argv > 2)
    then
      Save.open_pop Sys.argv.(1)
    else
      failwith "Use: CNN net_file path_to img"
  in  
  let net = Transform.tabToSave population_init.(0) info in
  for i = 0 to 9 do
    let dir = "Caracteres/" ^ (string_of_int i) in
    let nbImgs = Array.length (Sys.readdir dir) in
    let tab = Array.make 21 0 in
    for j = 0 to 20 do
      let imgPath = dir ^ "/" ^ (string_of_int j) ^ ".pgm" in
      let img = Importscans.importimg imgPath 28 in
      let res = Computevision.computeImg img net in
      let nb = maxTab res in
      (*Printf.printf "reco : %d, corresp : %d\n" i nb;*)
      tab.(j) <- nb;
    done;
    let channel = open_out ("Result/"^(string_of_int i)) in
    Array.iter (fun elt -> Printf.fprintf channel "%d\n" elt) tab;
    close_out channel;
  done;;
 
  
let () =
  if (Array.length Sys.argv > 2)
  then
    test ()
  else
    darwin ();
