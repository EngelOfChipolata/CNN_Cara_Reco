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
  let imgPath = StringLabels.concat "" [dir ; "/" ;(string_of_int img) ; "pgm"] in
  let imgI = Importscans.importimg imgPath 28 in
  let tup = (imgI, !corresp) in
  tup

let recup = fun img corresp nb ->
  let i = img mod nb in
  let dir = StringLabels.concat "" ["Caracteres/" ; (string_of_int !corresp)] in
  let tup = makeTuple i corresp dir in
  if i = (nb -1 ) then corresp := !corresp + 1;
  tup
  

let getSample = fun nb ->
  let corresp = ref 0 in
  let nbRepart = nb / 10 in
  let tab = Array.init nb ( fun i -> recup i corresp nbRepart ) in
  tab
