open Types
let image_result = fun file image_out ->
  let oc = open_out file in
  Printf.fprintf oc "P2\n#CREATOR: nous\n%d %d\n255\n" (Array.length image_out) (Array.length image_out.(0));
  for i = 0 to Array.length image_out - 1 do 
    for j = 0 to Array.length image_out.(0) - 1 do
      Printf.fprintf oc "%d " (int_of_float image_out.(i).(j))
    done
  done; 
  close_out oc;;

let image_factory = fun filepattern image_array ->
  let imgs = match image_array with
               Imgs imgs -> imgs
             | _ -> failwith "nope" in
  for i = 0 to Array.length imgs - 1 do
    image_result (String.concat "" [filepattern; (string_of_int i); ".pgm"]) imgs.(i)
  done
