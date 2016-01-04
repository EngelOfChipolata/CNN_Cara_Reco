let rosenbrock = fun x ->
  (1. -. x.(0))**2. +. 100.0 *. (x.(1) -. x.(0)**2.)**2.

let de = fun populationsize dimensionsize initborder nbitermax differentialweight crossoverproba func ->
  Random.self_init ();
  let population = Array.init populationsize (fun _ -> (Array.init dimensionsize (fun _ -> (Random.float 2. *. initborder -. initborder)))) in
  let nbiter = ref 0 in
  while (!nbiter < nbitermax) do
    for n=0 to (populationsize - 1) do
      let x = Random.int (Array.length population) in
      let a = ref (Random.int (Array.length population)) in
      while (!a==x) do
        a := Random.int (Array.length population)
      done;
      let b = ref (Random.int (Array.length population)) in
      while (!b == !a) || (!b == x) do
        b := Random.int (Array.length population)
      done;
      let c = ref (Random.int (Array.length population)) in
      while (!c == !b) || (!c == !a) || (!c == x) do
        c := Random.int (Array.length population)
      done;

      let r = Random.int (dimensionsize) in
      
      let original = population.(x) in
      
      let candidate = Array.copy original in
      
      let indi1 = population.(!a) in
      let indi2 = population.(!b) in
      let indi3 = population.(!c) in

      for dim = 0 to (dimensionsize - 1) do
        if (Random.int dimensionsize == r) || (Random.float 1. < crossoverproba)
        then candidate.(dim) <- indi1.(dim) +. differentialweight *. (indi2.(dim)-. indi3.(dim))
      done;
      if (func candidate < func original)
      then population.(x) <- candidate
    done;
    incr nbiter
  done;

  let bestfit = ref (population.(0)) in
  let bestfitvalue = ref (func !bestfit) in
  for i=1 to (populationsize - 1) do
    let testfit = func population.(i) in
    if (testfit  < !bestfitvalue)
    then begin bestfit := population.(i); bestfitvalue := testfit end;
  done;
  !bestfit
  
