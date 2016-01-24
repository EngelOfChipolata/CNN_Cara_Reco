let funSum = fun intVals (lsToNeuW, biais) -> (* a : neuronne de sortie sur lequel on somme ses connexions*)
                                        (*, intRes neuronnes intermédiares cartoonRes neuronnes de sortie*)
  let nbint = Array.length intVals - 1 in
  let s = ref 0. in    (* variable de somme *)
  
  for i = 0 to nbint do      (* n° neur int *)
        s:= !s +. intVals.(i) *. lsToNeuW.(i)
  done;
  s:= !s +. biais;
  !s;;


(* renvoi un tableau avec les valeurs des poids des neurones  *)
let creaNeu = fun fctSeuil fctSomme lsToLW intVals ->
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length lsToLW in     (* nombre de neurones en sortie *)
  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctSeuil (fctSomme intVals lsToLW.(i))) in
  valNeu;;

(* application partielle de la fonction précédente  *)
let computeLineToLine = creaNeu ActivationFcts.sigmoide funSum

let computeLinetoEnd = fun weights lineVal ->
  ActivationFcts.softmax (creaNeu ActivationFcts.identity funSum weights lineVal)
