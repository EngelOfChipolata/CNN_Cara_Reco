type intermediateweights = float array array array array

type intermediateoutput = float array

   (* initReseau: n = nb de neuronnes intermédiaires  nbN nombre de neuronnes en sortie *)   
let initReseau = fun size n nbN ->
  Random.self_init ();

  let res = Array.init nbN ( fun i -> Array.init n ( fun j -> Array.init size ( fun k -> Array.init size ( fun l -> (Random.float  2.) -.1. )))) in
  res ;;

(*fonction sigmoide qui "lisse" le résultat *)
let sigmoide = fun x ->
  1./.(1.+.exp(-.(x)));;

(* a : neuronne de sortie sur lequel on somme ses connexions*)
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


(* renvoi un tableau avec les valeurs des poids des neurones  *)
let creaNeu = fun fctseuil fctsomme res imgs->
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length res in     (* nombre de neurones en sortie *)
  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctseuil (fctsomme i imgs res)) in
  valNeu;;

(* application partielle de la fonction précédente  *)
let computeNeurons = creaNeu sigmoide funSum

