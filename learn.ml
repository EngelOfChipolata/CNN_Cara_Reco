let learnFromNothing = fun (sample, inputNature) infonn popsize iter differentialw crossov -> (*Fonction qui permet d'apprendre depuis une population aléatoire *)
  (*let base_size = Array.length sample.(0) in*)
  let evalfun = fun net -> Neteval.evalNet Computevision.computeVision sample (Transform.lineToTools net infonn inputNature) in
  (*let evalfun = fun net -> Neteval.success Computevision.computeVision sample (Transform.lineToTools net infonn) in*)
  let population_init = Transform.createInlinePopulation infonn popsize inputNature in
  Printf.printf "On part de loin le score est  : %f\n%!" (evalfun population_init.(0));
  let bestbrain, pop_finale = De.de population_init iter differentialw crossov evalfun in
  (bestbrain, pop_finale)

let learnFromFile = fun (sample, inputNature) file iter differentialw crossov -> (*Fonction qui permet d'apprendre depuis une population chargée depuis un fichier *)
  let info, pop = Save.open_pop file inputNature in
  let evalfun = fun net -> Neteval.evalNet Computevision.computeVision sample (Transform.lineToTools net info inputNature) in
  let bestbrain, pop_finale = De.de pop iter differentialw crossov evalfun in
  (bestbrain, pop_finale)



(* fonction qui crée un tuple comprenant une image et sa correspondance*)
let makeTuple = fun img corresp dir ->
  let imgPath = StringLabels.concat "" [dir ; "/" ;(string_of_int img) ; ".pgm"] in
  let imgI = Importscans.importimg imgPath in
  let tup = (imgI, !corresp) in
  tup

(* fonction qui tire au sort un nombre et met a jour le tableau des chiffres déja "tirés"  *)
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

(* fonction qui reset le tableau des chiffres *)
let resetTab = fun tab ->
  for i = 0 to (Array.length tab) - 1 do
    tab.(i) <- 1
  done;
  Array.iter (fun i -> tab.(i) <- 1) tab


(*fonction qui renvoi un tableau avec seulement les chiffres sortis et triés*)
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


(* fonction qui sauvegarde les chiffres "tirés" *)
let resetAndSave = fun filename loto nb ->
  let vector = recupDraw loto nb in
  let channel = open_out filename in
  Array.iter (fun elt -> Printf.fprintf channel "%d\n" elt) vector;
  close_out channel;
  resetTab loto


(* fonction qui permet de creer le tableau d'échantilon  *)
let recup = fun img corresp nb loto ->
  let i = img mod nb in
  let dir = "Caracteres/" ^ (string_of_int !corresp) in
  let nbImgs = Array.length (Sys.readdir dir) in

  let imgSort = random loto nbImgs in

  let tup = makeTuple imgSort corresp dir in

  if i = (nb -1 ) then
    begin
      let filename = "Save/Tirage/" ^ (string_of_int !corresp) in
      resetAndSave filename loto nb;
      corresp := !corresp + 1
    end;
  tup

(* fonction qui renvoi un échantillon de nb images répartis sur les 10 digits avec leurs correspondance sous forme de tuple  *)
let getSample = fun nb ->
  let corresp = ref 0 in
  let nbRepart = nb / 10 in
  let loto = Array.make 1500 1 in
  let tab = Array.init nb ( fun i -> recup i corresp nbRepart loto ) in
  tab



