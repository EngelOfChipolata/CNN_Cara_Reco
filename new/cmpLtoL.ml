let funSum = fun a intRes cartoonRes -> (* a : neuronne de sortie sur lequel on somme ses connexions*)
                                        (*, intRes neuronnes intermédiares cartoonRes neuronnes de sortie*)
  let rn = Array.length intRes - 1 in
  let s = ref 0. in    (* variable de somme *)
  
  for i = 0 to rn do      (* n° neur *)
        s:= !s +. intRes.(i) *. cartoonRes.(a).(i)
  done;
  !s;;


(* renvoi un tableau avec les valeurs des poids des neurones  *)
let creaNeu = fun fctSeuil fctSomme cartoonRes intRes ->
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length cartoonRes in     (* nombre de neurones en sortie *)
  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctSeuil (fctSomme i intRes cartoonRes)) in
  valNeu;;

(* application partielle de la fonction précédente  *)
let computeLineToLine = creaNeu ActivationFcts.sigmoide funSum
