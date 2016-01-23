open Types
(* évalue un reseau sur un ensemble d'images : renvoie la norme quadratique de la différence entre le résultat d'un test et le vecteur attendu *)
let evalNet = fun funcompute imgCoupleAr net ->
  (* imgCouple est un tuple (img, sol) ou sol est le chiffre solution (0->9) *)
  let evalfitness = fun imgCouple ->
    let img, sol = imgCouple in
    let res = match (funcompute img net) with
                  LineValues res -> res
                | Imgs _ -> failwith "[ERROR] evalNet ne peut évaluer une image."
     in
    res.(sol) <- res.(sol)-.1.;
    let diff = Array.map (fun i -> i*.i) res in
    let normAtSquare = Array.fold_left ( +. ) 0. diff in
    normAtSquare in
  let ress = Array.map (fun elt -> evalfitness elt) imgCoupleAr in
  (* crée un array contenant tout les résultats *)
  let note = Array.fold_left ( +. ) 0. ress in
  note;;

(* renvoie le taux de succes d'un réseau sur un emsemble d'images *)
let success = fun funcompute imgCoupleAr net ->
  let amiright = fun imgCouple ->
    let img, sol = imgCouple in
    let res = match (funcompute img net) with
                  LineValues res -> res
                | Imgs _ -> failwith "[ERROR] evalNet ne peut évaluer une image."
     in
    if (Computevision.whatisit res == sol)
    then 1
    else 0
  in
  let note = Array.fold_left (fun acc elt -> (amiright elt) + acc) 0 imgCoupleAr in
  float (note) /. float (Array.length imgCoupleAr)  *. (-. 100.)
