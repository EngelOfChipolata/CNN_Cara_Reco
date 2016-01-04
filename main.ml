let () =
  let info = (3, 4, 100, 13, 10) in
  let net = Computevision.createNetwork info in
  let inline = Transform.saveToTab net in
  Array.iter ( fun i -> Printf.printf "%f\n" i) inline;
  let phoenix = Transform.tabToSave inline info in
  let inline2 = Transform.saveToTab phoenix in
  Printf.printf "\n\n";
  Array.iter ( fun i -> Printf.printf "%f\n" i) inline2; 
  

