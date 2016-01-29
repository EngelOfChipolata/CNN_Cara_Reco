(*fait la somme des xi.wi et du biais pour le neurone considéré*)
let funSum = fun intVals (lsToNeuW, biais) ->
  let nbint = Array.length intVals - 1 in
  let s = ref 0. in    (* accumulateur pour la somme *)
  
  for i = 0 to nbint do      (* n° neur int *)
        s:= !s +. intVals.(i) *. lsToNeuW.(i)
  done;
  s:= !s +. biais;
  !s;;


(* renvoi un tableau avec les valeurs de sortie des neurones  *)
let creaNeu = fun fctSeuil fctSomme lsToLW intVals ->
  let valNeu = Array.map (fun weightsNeu -> fctSeuil (fctSomme intVals weightsNeu)) lsToLW in
  valNeu;;

(* application partielle de la fonction précédente  *)
let computeLineToLine = creaNeu ActivationFcts.sigmoide funSum

(* encapsulation particulière de la fonction pour la couche de sortie *)
let computeLinetoEnd = fun weights lineVal ->
  ActivationFcts.softmax (creaNeu ActivationFcts.identity funSum weights lineVal)
