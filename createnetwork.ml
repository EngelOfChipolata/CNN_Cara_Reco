let init_reseau = fun imgs nbN ->
  Random.self_init ();
  let n = Array.length imgs.(0) in
  let x = Array.length imgs.(0).(0) in
  let y = Array.length imgs.(0).(0).(0) in

  let res = Array.init nbN ( fun i -> Array.init n ( fun j -> Array.init x ( fun k -> Array.init y ( fun l -> (Random.float 10.) -. 5.)))) in
  res ;;
    
let sigmoide = fun x ->
  1./.(1.+.exp(-.(x)));;

let funsum = fun a imgs res biais ->
  
  let rn = Array.length res.(0) in
  let ri = Array.length res.(0).(0) in
  let rj = Array.length res.(0).(0).(0) in
  
  let s = ref 0. in
    for b = 0 to rn do      (* n° layers *)
      for c = 0 to ri do    (* n° lignes layer *)
        for d = 0 to rj do  (* n° colnnes layer *)
          s:= !s +. imgs.(b).(c).(d) *. res.(a).(b).(c).(d) -. biais
        done
      done
    done;
  !s;;

let creaNeu = fun imgs res fctseuil fctsomme biais->
  
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length res in     (* nombre de neurones en sortie *)

  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctseuil fctsomme imgs res biais) in
  valNeu;;
  

          
        
  
