open Types

(* applique successivement les outils sur la sortie du précédent outil *)
let computeTools = fun img network ->
  let applyTool = fun input tool ->
    match (tool, input) with
      (FilterImgs filters, Imgs img) -> Imgs (Convolutional.convoFactory img filters)
    | (Poolfct poolf, Imgs cvImgs) -> poolf cvImgs
    | (ImgsToLine weights, Imgs cvImgs) -> LineValues (CmpItoL.computeImgsToLine weights cvImgs)
    | (LineToLine weights, LineValues lineVal) -> LineValues (CmpLtoL.computeLineToLine weights lineVal)  (* changer fct *)
    | (LineToLineFinal weights, LineValues lineVal) -> LineValues (CmpLtoL.computeLinetoEnd weights lineVal)
    | (_,_) -> failwith "Arguments incompatibles\n"
  in
  List.fold_left applyTool img network


(* appelle la fonction précédente, puis contrôle que la sortie est bien du type voulu *)
let computeVision = fun img network ->
  match (computeTools img network) with
      LineValues line -> line
    | Imgs _ -> failwith "[ERROR] Imgs reçu au lieu de LineValues"


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

