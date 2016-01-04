let save_vector = fun file_channel vector ->
  Array.iter (fun elt -> Printf.fprintf file_channel "%f\n" elt) vector;
  Printf.fprintf file_channel "\n"

let save_pop = fun filename info pop ->
  let channel = open_out filename in
  let a,b,c,d,e = info in
  Printf.fprintf channel "%d\n%d\n%d\n%d\n%d\n\n" a b c d e;
  Array.iter (fun ind -> save_vector channel ind) pop

