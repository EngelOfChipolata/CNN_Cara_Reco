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


let convoFactory = fun conv_function image_in filterArray ->
  let outImgs = Array.init (Array.length filterArray) (fun fil -> conv_function image_in filterArray.(fil)) in
  outImgs
    
let convo_result = fun file image_out ->
  let oc = open_out file in
  Printf.fprintf oc "P2 \n#CREATOR: XV Version 3.10a Rev: 12/29/94 (PNG patch 1.0) \n%d %d \n255 \n" (Array.length image_out) (Array.length image_out.(0));
  for i = 0 to Array.length image_out - 1 do 
    for j = 0 to Array.length image_out.(0) - 1 do
      Printf.fprintf oc "%d " image_out.(i).(j)
    done;
  done; 
  close_out oc;;

    
