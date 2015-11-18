let importimg = fun imgpath high width ->
  let channel = open_in imgpath in
  seek_in channel 73;
  let result_matrix = Array.init high (fun _ -> Array.init width (fun _ -> int_of_char (input_char channel))) in
  result_matrix;;
