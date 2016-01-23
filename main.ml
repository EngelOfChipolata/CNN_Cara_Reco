open Types
let () =
  let infos = [Fil (3,5); Pool 2; Line 100; LineFinal 10] in

  let tab = Learn.getSample 100 in
  let bestweights, pop_finale = Learn.learnFromNothing tab infos 50 1000 1. 0.5 in
  
  Save.save_pop "best" infos [|bestweights|];
  Save.save_pop "poppp" infos pop_finale;
  Printf.printf "Finish%!" 

  
