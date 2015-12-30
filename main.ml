let () =
  let net = Computevision.createNetwork () in
  let img0 = Importscans.importimg "Caracteres/1/10.pgm" 28 28 in
  (* let values = Computevision.computeImg img0 net in
  Array.iter (fun i -> Printf.printf "%f  " i ) values;
  Printf.printf "\n"; *)
  let img1 = Importscans.importimg "Caracteres/2/58.pgm" 28 28 in
  let img2 = Importscans.importimg "Caracteres/3/5.pgm" 28 28 in
  let img3 = Importscans.importimg "Caracteres/5/3.pgm" 28 28 in
  let img4 = Importscans.importimg "Caracteres/7/24.pgm" 28 28 in
  let img5 = Importscans.importimg "Caracteres/8/31.pgm" 28 28 in
  let img6 = Importscans.importimg "Caracteres/9/18.pgm" 28 28 in
  let tab = [|(img0,1); (img1,2); (img2,3); (img3,5); (img4,7); (img5,8); (img6,9)|] in
  let ev = Neteval.evalNet ( Computevision.computeImg ) tab net in
  Printf.printf "ev = %f  " ev

