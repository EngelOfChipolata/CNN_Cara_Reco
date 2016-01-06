(*let tabImgsSort = fun tab nb ->
  let t = Array.make (nb+1) 0 in
  let avancement = ref 0 in
  for i = 0 to (Array.length tab) - 1 do
    begin
      if tab.(i) = 0 then
        begin
          t.(!avancement) <- i;
          avancement := !avancement + 1;
        end
    end
  done;
  t
in

let makeTuples = fun img corresp dir ->
  let imgPath = StringLabels.concat "" [dir ; "/" ;(string_of_int img) ; "pgm"] in
  let imgI = Importscans.importimg imgPath 28 28 in
  let tup = (imgI, corresp) in
  tup
in

let sampleToLearn = fun nb ->
  let nbRepart = (nb / 10) - 1 in
  let tabTuples =  Array.init nb (fun _ -> makeTuples 0 0 "Caracteres/1/") in
  Random.self_init ();


  
  for i = 0 to 9 do
    let dirtemp = StringLabels.concat "" ["Caracteres/" ; (string_of_int i)] in
    let list =  Sys.readdir dirtemp in
    let nbImgs = Array.length list in
    let loto = Array.make nbImgs 1 in

    
    Printf.printf "nbImgs = %d\n" nbImgs;
    
    for j = 0 to nbRepart do
      let imgSort = ref (Random.int nbImgs) in
      Printf.printf "Carac = %d, sort = %d\n" i !imgSort;
      if loto.(!imgSort) = 1 then
        begin
          loto.(!imgSort) <- 0;
        end
      else
        begin
          while (loto.(!imgSort) = 0) do
            imgSort := Random.int nbImgs;
          done;
          loto.(!imgSort) <- 0;
        end
    done;
    let tabImgs = tabImgsSort loto nbRepart in
    let tableau = Array.init nbRepart ( fun l -> makeTuples tabImgs.(l) i  dirtemp) in
    Printf.printf "hallo \n";
  done;
  tabTuples;
in

sampleToLearn 40
;;*)

let makeTuple = fun img corresp dir ->
  let imgPath = StringLabels.concat "" [dir ; "/" ;(string_of_int img) ; "pgm"] in
  let imgI = Importscans.importimg imgPath 28 28 in
  let tup = (imgI, !corresp) in
  tup
in

let recup = fun img corresp nb ->
  let i = img mod nb in
  let dir = StringLabels.concat "" ["Caracteres/" ; (string_of_int !corresp)] in
  let tup = makeTuple i corresp dir in
  if i = (nb -1 ) then corresp := !corresp + 1;
  tup
in
  

let deb = fun nb ->
  let corresp = ref 0 in
  let nbRepart = nb / 10 in
  let tab = Array.init nb ( fun i -> recup i corresp nbRepart ) in
  tab;
in

deb 20;;
