(*fait la somme des xi.wi et du biais pour le neurone considéré*)
let funSum = fun imgs (isToNeuW, bias) ->
  let nbImgsNeu = Array.length isToNeuW in
  let nbImgs = Array.length imgs in
  if nbImgs != nbImgsNeu then failwith "dimension incohérente\n";
  let rx = Array.length isToNeuW.(0) - 1 in
  let ry = Array.length isToNeuW.(0).(0) - 1 in
  
  let acc = ref 0. in

  for iImgs = 0 to nbImgs-1 do      (* n° layer *)
    for x = 0 to rx do    (* n° ligne layer *)
      for y = 0 to ry do  (* n° colonne layer *)
        acc:= !acc +. imgs.(iImgs).(x).(y) *. isToNeuW.(iImgs).(x).(y)
      done
    done
  done;
  acc:= !acc +. bias;
  !acc;;

(*calcule la valeurs de sortie des neuronnes*)
let creaNeu = fun fctseuil fctsomme isToLW imgs->
  let valNeu = Array.map (fun weightsNeu -> fctseuil (fctsomme imgs weightsNeu) ) isToLW in
  valNeu;;

(*application partielle utilisée couramment*)
let computeImgsToLine = creaNeu ActivationFcts.sigmoide funSum

