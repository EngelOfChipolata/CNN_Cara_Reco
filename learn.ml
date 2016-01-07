let learnFromNothing = fun sample infonn popsize iter differentialw crossov ->
  let evalfun = fun net -> Neteval.evalNet Computevision.computeImg sample (Transform.tabToSave net infonn) in
  let population_init = Transform.createInlinePopulation infonn popsize in
  let bestbrain, pop_finale = De.de population_init iter differentialw crossov evalfun in
  (bestbrain, pop_finale)

let learnFromFile = fun sample file iter differentialw crossov ->
  let info, pop = Save.open_pop file in
  let evalfun = fun net -> Neteval.evalNet Computevision.computeImg sample (Transform.tabToSave net info) in
  let bestbrain, pop_finale = De.de pop iter differentialw crossov evalfun in
  (bestbrain, pop_finale)



    


let makeTuple = fun img corresp dir ->
  let imgPath = StringLabels.concat "" [dir ; "/" ;(string_of_int img) ; ".pgm"] in
  let imgI = Importscans.importimg imgPath 28 28 in
  let tup = (imgI, !corresp) in
  tup

let random = fun loto nbImgs ->
  let imgSort = ref (Random.int nbImgs) in
  if loto.(!imgSort) = 1 then loto.(!imgSort) <- 0
  else
    begin
      while (loto.(!imgSort) = 0) do
        imgSort := Random.int nbImgs
      done;
      loto.(!imgSort) <- 0
    end;
  !imgSort

let resetTab = fun tab ->
  for i = 0 to (Array.length tab) - 1 do
    tab.(i) <- 1
  done;
  Array.iter (fun i -> tab.(i) <- 1) tab

let recupDraw = fun tab nb ->
  let t = Array.make nb 0 in
  let avancement = ref 0 in
  for i = 0 to (Array.length tab) - 1 do
    begin
      if tab.(i) = 0 then
        begin
          t.(!avancement) <- i;
          avancement := !avancement + 1
        end
    end
  done;
  avancement := 0;
  t

let resetAndSave = fun filename loto nb ->
  let vector = recupDraw loto nb in
  let channel = open_out filename in
  Array.iter (fun elt -> Printf.fprintf channel "%d\n" elt) vector;
  close_out channel;
  resetTab loto

let recup = fun img corresp nb loto ->
  let i = img mod nb in
  let dir = StringLabels.concat "" ["Caracteres/" ; (string_of_int !corresp)] in
  let nbImgs = Array.length (Sys.readdir dir) in

  let imgSort = random loto nbImgs in

  let tup = makeTuple imgSort corresp dir in

  if i = (nb -1 ) then
    begin
      let filename = StringLabels.concat "" ["Save/Tirage/" ; (string_of_int !corresp)] in
      resetAndSave filename loto nb;
      corresp := !corresp + 1
    end;
  tup

let getSample = fun nb ->
  let corresp = ref 0 in
  let nbRepart = nb / 10 in
  let loto = Array.make 1500 1 in
  let tab = Array.init nb ( fun i -> recup i corresp nbRepart loto ) in
  tab


