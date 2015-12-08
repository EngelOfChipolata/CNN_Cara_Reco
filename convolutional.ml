let sum_matrix_non_zero = fun matrix ->
  let sum line = Array.fold_left ( + ) 0 line in
  let sumall m = Array.fold_left (fun acc elem -> acc + sum elem) 0 m in
  let s = sumall matrix in
  if s != 0 then s else 1


let convolution = fun image_in filter ->
  let filterh = Array.length filter in
  let filterw = Array.length filter.(0) in
  let sizen = Array.length image_in - filterh + 1 in
  let sizem = Array.length image_in.(0) - filterw + 1 in
  let one_sum = fun i j ->
    let acc = ref 0 in
    for k = 0 to filterh - 1 do
      for l = 0 to filterw -1 do
        acc := !acc + filter.(k).(l) * image_in.(i + k).(j + l)
      done
    done;
    let sum = sum_matrix_non_zero filter in
    min 255 (max 0 (!acc/sum))
  in
  let out_matrix = Array.init sizen (fun i -> Array.init sizem (fun j -> one_sum i j)) in
  out_matrix
    
