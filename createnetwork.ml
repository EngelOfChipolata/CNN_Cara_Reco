let initReseau = fun imgs nbN ->
  Random.self_init ();
  let n = Array.length imgs in
  let x = Array.length imgs.(0) in
  let y = Array.length imgs.(0).(0) in

  let res = Array.init nbN ( fun i -> Array.init n ( fun j -> Array.init x ( fun k -> Array.init y ( fun l -> (Random.float 0.0001)-.0.00005)))) in
  res ;;
    
let sigmoide = fun x ->
  1./.(1.+.exp(-.(x)));;

let funSum = fun a imgs res ->

  let rn = Array.length res.(0) - 1 in
  let ri = Array.length res.(0).(0) - 1 in
  let rj = Array.length res.(0).(0).(0) -1 in
  
  let s = ref 0. in
  for b = 0 to rn do      (* n° layers *)
    for c = 0 to ri do    (* n° lignes layer *)
      for d = 0 to rj do  (* n° colnnes layer *)
        s:= !s +. float (imgs.(b).(c).(d)) *. res.(a).(b).(c).(d)
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
 
let computeNeurons = creaNeu sigmoide funSum

(* Test 

let nbN = 200 in
let imgs = Array.init 20 ( fun i -> Array.init 15 ( fun j -> Array.init 15 ( fun l -> Random.int 255))) in
let res = initReseau imgs nbN in

let s = ref (Array.init 200 ( fun _ -> 0. )) in
for i = 0 to 100 do
 s := creaNeu imgs res sigmoide funSum;
done;
Printf.printf "Fini\n";;
Array.iter (fun i -> Printf.printf "%g\n" i) valNeu;;*)

