let initReseau = fun n nbN ->
  Random.self_init ();
  let cartoonRes = Array.init nbN (fun i -> Array.init n ( fun j -> (Random.float 0.0001)-.0.00005)) in
  cartoonRes ;;
    
let sigmoide = fun x ->
  1./.(1.+.exp(-.(x)));;

let funSum = fun a intRes cartoonRes ->

  let rn = Array.length intRes - 1 in
  let s = ref 0. in
  
  for i = 0 to rn do      (* n° neur *)
        s:= !s +. intRes.(i) *. cartoonRes.(a).(i)
  done;
  !s;;

let creaNeu = fun intRes cartoonRes fctSeuil fctSomme ->
  
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length cartoonRes in     (* nombre de neurones en sortie *)

  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctSeuil (fctSomme i intRes cartoonRes)) in
  valNeu;;



(* Test 

let nbN = 10 in
let intRes = Array.init 200 ( fun i -> Random.float 1.) in
let res = initReseau intRes nbN in

let s = ref (Array.init 10 ( fun _ -> 0. )) in

for i = 0 to 100 do
 s := creaNeu intRes res sigmoide funSum;
done;
Printf.printf "Fini\n";;*)

