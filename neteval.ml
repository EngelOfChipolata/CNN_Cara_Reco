let evalNet = fun funcompute imgCoupleAr net ->
  (* imgCouple est un tuple (img, sol) ou sol est le chiffre solution (0->9) *)
  let evalfitness = fun imgCouple ->
    let img, sol = imgCouple in
    let res = funcompute img net in
    res.(sol) <- res.(sol)-.1.;
    let diff = Array.map (fun i -> i*.i) res in
    let normAtSquare = Array.fold_left ( +. ) 0. diff in
    (*Printf.printf "norm : %f\tsol : %d\n%!" normAtSquare sol;*)
    normAtSquare in
  let ress = Array.map (fun elt -> evalfitness elt) imgCoupleAr in
  (* crée un array contenant tout les résultats *)
  let note = Array.fold_left ( +. ) 0. ress in
  0.5 *. note;;

let success = fun funcompute imgCoupleAr net ->
  let amiright = fun imgCouple ->
    let img, sol = imgCouple in
    let res = funcompute img net in
    if (Computevision.whatisit res == sol)
    then 1
    else 0
  in
  let note = Array.fold_left (fun acc elt -> (amiright elt) + acc) 0 imgCoupleAr in
  float (note) /. float (Array.length imgCoupleAr)  *. (-. 100.)
