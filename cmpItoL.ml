
let funSum = fun imgs (isToNeuW, bias) ->
  let nbImgsNeu = Array.length isToNeuW in
  let nbImgs = Array.length imgs in
  if nbImgs != nbImgsNeu then failwith "dimension incohérente\n";
  let rx = Array.length isToNeuW.(0) - 1 in
  let ry = Array.length isToNeuW.(0).(0) - 1 in
  
  let acc = ref 0. in
  
  for iImgs = 0 to nbImgs-1 do      (* n° layers *)
    for x = 0 to rx do    (* n° lignes layer *)
      for y = 0 to ry do  (* n° colnnes layer *)
        acc:= !acc +. imgs.(iImgs).(x).(y) *. isToNeuW.(iImgs).(x).(y)
      done
    done
  done;
  acc:= !acc +. bias;
  !acc;;

let creaNeu = fun fctseuil fctsomme isToLW imgs->
  (* Longueur du reseau de neuronnes*)
  let rm = Array.length isToLW in     (* nombre de neurones en sortie *)
  (* val de sortie des neuronnes *)
  let valNeu = Array.init rm (fun i -> fctseuil (fctsomme imgs isToLW.(i))  ) in
  valNeu;;

let computeImgsToLine = creaNeu ActivationFcts.sigmoide funSum

