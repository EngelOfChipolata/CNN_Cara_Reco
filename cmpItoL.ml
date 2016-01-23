
let funSum = fun a imgs res ->
  let rn = Array.length res.(0) - 1 in
  let ri = Array.length res.(0).(0) - 1 in
  let rj = Array.length res.(0).(0).(0) - 1 in
  
  let s = ref 0. in
  for b = 0 to rn do      (* n° layers *)
    for c = 0 to ri do    (* n° lignes layer *)
      for d = 0 to rj do  (* n° colnnes layer *)
        s:= !s +. imgs.(b).(c).(d) *. res.(a).(b).(c).(d)
      done
    done
  done;
  !s;;

let creaNeu = fun fctseuil fctsomme res imgs->
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length res in     (* nombre de neurones en sortie *)
  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctseuil (fctsomme i imgs res)) in
  valNeu;;

let computeImgsToLine = creaNeu ActivationFcts.sigmoide funSum

