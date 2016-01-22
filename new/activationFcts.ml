(* float -> float *)  
let sigmoide = fun x ->
  1. /. (1.+.exp (-.x));;

(* float -> float *)
let identity = fun x ->
  x;;

(* float -> float *)
let step = fun x ->
  if x < 0. then -1. else 1.;;

(* float array -> float array *)
let softmax = fun preactTab ->
  let exps = Array.map (fun x-> exp(x)) preactTab in
  let exps_sum = Array.fold_left (+.) 0. exps in
  let probabilities = Array.map (fun x-> x /. exps_sum) exps in
  probabilities
