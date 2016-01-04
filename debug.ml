let image_result = fun file image_out ->
  let oc = open_out file in
  Printf.fprintf oc "P2\n#CREATOR: XV Version 3.10a Rev: 12/29/94 (PNG patch 1.0)\n%d %d\n255\n" (Array.length image_out) (Array.length image_out.(0));
  for i = 0 to Array.length image_out - 1 do 
    for j = 0 to Array.length image_out.(0) - 1 do
      Printf.fprintf oc "%d " image_out.(i).(j)
    done
  done; 
  close_out oc;;

let image_factory = fun filepattern image_array ->
  for i = 0 to Array.length image_array do
    image_result (String.concat "" [filepattern; (string_of_int i); ".pgm"]) image_array.(i)
  done
