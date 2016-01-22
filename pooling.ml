(* divise la taille d'une image par 2 grace à une fonction de pooling *)
let poolimg = fun poolFct inputImg ->
  let size = Array.length inputImg in
  if size < 2    (* si l'image est trop petite, on la retourne directement *)
  then
    inputImg
  else
    begin
    let sizePooled = size/2 in
    let outputImg = Array.init sizePooled (fun i-> Array.init sizePooled (fun j-> poolFct [inputImg.(2*i).(2*j) ; inputImg.(2*i+1).(2*j) ; inputImg.(2*i).(2*j+1) ; inputImg.(2*i+1).(2*j+1)]  ) ) in
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
