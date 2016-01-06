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
  
