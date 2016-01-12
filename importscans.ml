type image = float array array

let importimg = fun imgpath size ->
  let channel = open_in imgpath in
  seek_in channel 73;
  let result_matrix = Array.init size (fun _ -> Array.init size (fun _ -> float (int_of_char (input_char channel))/.255.)) in
  result_matrix;;
