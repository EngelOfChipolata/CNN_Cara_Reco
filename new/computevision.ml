open Types
(* computeImg calcule le vecteur final en prenant en paramètres l'image et le réseau de neurones *)


let computeVision = fun img network ->
  let rec applyTool = fun input tool ->
    match (tool, input) with
      (FilterImgs filters, Imgs img) -> Imgs (Convolutional.convoFactory img filters)
    | (Poolfct poolf, Imgs cvImgs) -> poolf cvImgs
    | (ImgsToLine weights, Imgs cvImgs) -> LineValues (CmpItoL.computeImgsToLine weights cvImgs)
    | (LineToLine weights, LineValues lineVal) -> LineValues (CmpLtoL.computeLinetoEnd weights lineVal)
    | (_,_) -> failwith "Arguments incompatibles\n"
  in
  List.fold_left applyTool img network


(* retourne le nombre associé au vecteur résultat *)
let whatisit = fun finalvalues ->
  let getimax = fun tab ->
    let i = ref 0 in
    let max = ref (-. infinity) in
    let savei = fun index elt ->
      if (elt > !max)
      then begin
        i := index;
        max := elt;
      end
    in
    Array.iteri savei tab;
    !i
  in
  getimax finalvalues
