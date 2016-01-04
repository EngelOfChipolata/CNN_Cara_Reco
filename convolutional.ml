let sum_matrix_non_zero = fun matrix ->
  let sum line = Array.fold_left ( +. ) 0. line in
  let sumall m = Array.fold_left (fun acc elem -> acc +. sum elem) 0. m in
  let s = sumall matrix in
  if s != 0. then s else 1.


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


let convoFactory = fun image_in filterArray ->
  let outImgs = Array.init (Array.length filterArray) (fun fil -> convolution image_in filterArray.(fil)) in
  outImgs


let createrandomfilter = fun height width ->
  Random.self_init ();
  Array.init height (fun _ -> Array.init width (fun _ -> Random.float 10. -. 5.))

let randomfilterfactory = fun height width layer ->
  Array.init layer (fun _ -> createrandomfilter height width)
    
