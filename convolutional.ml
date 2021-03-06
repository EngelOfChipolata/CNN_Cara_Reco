(*Ce fichier est utilisé pour calculer la partie convolutionnaire du réseau de neurones*)


(*Fonction privée utilisée pour calculer la somme de tous les termes d'un matrice et de renvoyer 1 si celle ci est nulle.
Cela est utilisé pour normer les filtres de convolutions*)
let sum_matrix_non_zero = fun matrix ->
  let sum line = Array.fold_left ( +. ) 0. line in
  let sumall m = Array.fold_left (fun acc elem -> acc +. sum elem) 0. m in
  let s = sumall matrix in
  if s != 0. then s else 1.

(*Fonction qui prend une image et le noyau d'un filtre et renvoie l'image convoluée*)
let convolution = fun image_in filter ->
  let filterh = Array.length filter in
  let filterw = Array.length filter.(0) in
  let sizen = Array.length image_in - filterh + 1 in
  let sizem = Array.length image_in.(0) - filterw + 1 in
  let one_sum = fun i j ->
    let acc = ref 0. in
    for k = 0 to filterh - 1 do
      for l = 0 to filterw -1 do
        acc := !acc +. filter.(k).(l) *. image_in.(i + k).(j + l)
      done
    done;
    let sum = sum_matrix_non_zero filter in
    min 255. (max 0. (!acc/.sum))
  in
  let out_matrix = Array.init sizen (fun i -> Array.init sizem (fun j -> one_sum i j)) in
  out_matrix

(*Fonction qui prend une image et un tableau de noyaux de filtre et qui renvoie un tableau d'images convoluées par ses filtres*)
let convoTotale = fun image_in filterArray ->
  let outImgs = Array.init (Array.length filterArray) (fun fil -> convolution image_in filterArray.(fil)) in
  outImgs
(*prend tableau d'images et un tableau de noyaux de filtre et qui renvoie tableau de toutes les images convoluées par tous les filtres*)
let convoFactory = fun imagesTab filterArray ->
  let imageList = Array.to_list imagesTab in
  let convoList = List.map (fun elt -> convoTotale elt filterArray) imageList in
  let convoOut = Array.concat convoList in
  convoOut
  
(*Fonction qui créé un noyau de filtre aléatoire entre -1 et 1*)
let createrandomfilter = fun size ->
  Random.self_init ();
  Array.init size (fun _ -> Array.init size (fun _ -> Random.float 2. -. 1.))

(*Fonction qui renvoie un  tableau de noyaux de filtres aléatoires (entre -1 et 1)*)
let randomfilterfactory = fun size layer ->
  Array.init layer (fun _ -> createrandomfilter size)
    
