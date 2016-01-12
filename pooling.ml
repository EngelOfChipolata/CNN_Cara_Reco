(* divise la taille d'une image par 2 grace à une fonction de pooling *)
let poolimg = fun poolFct inputImg ->
  let height = Array.length inputImg in
  let width = Array.length inputImg.(0) in
  if height < 2 && width < 2    (* si l'image est trop petite, on la retourne directement *)
  then
    inputImg
  else
    begin
    let outputImg = Array.make_matrix (height/2) (width/2) 0. in    
    for i = 0 to height/2 - 1 do
      for j = 0 to width/2 - 1 do
        let pixToPool = [inputImg.(2*i).(2*j) ; inputImg.(2*i+1).(2*j) ; inputImg.(2*i).(2*j+1) ; inputImg.(2*i+1).(2*j+1)] in
        outputImg.(i).(j) <- poolFct pixToPool;
      done
    done;
      outputImg;
    end

(* renvoie le max de la liste en paramètres *)
let maxPooling = fun pixs ->
  match pixs with
    x :: xs -> List.fold_left max x xs
  | [] -> failwith "maximum of an empty list !\n"

let basicPool = poolimg maxPooling

(* pool un ensemble d'images *)
let poolConvImg = fun poolImg layerSet ->
  (*let outputConvImg = Array.init (Array.length layerSet) (fun i -> poolImg layerSet.(i)) in *)
  let outputConvImg = Array.map (fun elt -> poolImg elt) layerSet in
  outputConvImg

(* le pooling que l'on va utiliser *)
let maxPoolConvImg = poolConvImg (poolimg maxPooling)
