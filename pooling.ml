let poolimg = fun poolFct inputImg ->
  let height = Array.length inputImg in
  let width = Array.length inputImg.(0) in
  if height < 2 && width < 2    (* si l'image est trop petite, on la retourne directement *)
  then
    inputImg
  else
    begin
    let outputImg = Array.make_matrix (height/2) (width/2) 0 in    
    for i = 0 to height/2 - 1 do
      for j = 0 to width/2 - 1 do
        let pixToPool = [inputImg.(2*i).(2*j) ; inputImg.(2*i+1).(2*j) ; inputImg.(2*i).(2*j+1) ; inputImg.(2*i+1).(2*j+1)] in
        outputImg.(i).(j) <- poolFct pixToPool;
      done
    done;
      outputImg;
    end

let sumPooling = fun pixs ->
  List.fold_left ( + ) 0 pixs

let maxPooling = fun pixs ->
  match pixs with
    x :: xs -> List.fold_left max x xs
  | [] -> failwith "maximum of an empty list !\n"

let basicPool = poolimg maxPooling

let poolConvImg = fun poolImg layerSet ->
  let outputConvImg = Array.init (Array.length layerSet) (fun i -> poolImg layerSet.(i)) in
  outputConvImg

let maxPoolConvImg = poolConvImg (poolimg maxPooling)
