(*Ce module présente une implémentation de l'évolution différentielle *)

(*Fonction de rosenbrock en dimension 2, utilisée pour tester l'evolution différentielle*)
let rosenbrock = fun x ->
  (1. -. x.(0))**2. +. 100.0 *. (x.(1) -. x.(0)**2.)**2.

(* Fonction qui initialize un individu de dimension dimsize compris entre -border et border*)
let initrand = fun dimsize border ->
  Random.self_init ();
  Array.init dimsize (fun _ -> Random.float (2. *. border) -. border)

(*Variable globale utilisée pour savoir si le signal d'arrêt à été pressée (a supprimer)*)
let global = ref false

(*Fonction qui ramène un nombre entre my_min et my_max*)
let clamp = fun a my_min my_max ->
  max my_min (min my_max a)

(*Fonction appelée quand le signal est reçu, passe la variable global a true*)
let settotrue = fun _ ->
  global := true;
  Printf.printf("[DE] Signal reçu : choix du meilleur en cours\n%!");
  Sys.set_signal Sys.sigint Sys.Signal_default


(*Fonction d'évolution différentielle*)      
let de = fun population nbitermax differentialweight crossoverproba func ->
  Random.self_init (); (*Initialisation du générateur aléatoire*)
  let populationsize = Array.length population in (*On récupère la taille de la population et la dimension de chaque individu*)
  let dimensionsize = Array.length population.(0) in
  let scores = Array.init populationsize (fun _ -> None) in (* On range les scores de la population ici pour éviter de les recalculer *)
  Sys.set_signal Sys.sigint (Sys.Signal_handle settotrue); (*Ci, ctrl C est préssé à partir de maintenant on appelle la fonction settotrue*)
  let nbiter = ref 0 in						(*On initialise le nombre d'itérations à 0*)
  while (!nbiter < nbitermax) && not !global do         (*Critère d'arrêt à préciser :Tant qu'on atteint pas le nombre d'itération maximal ou que ctrl C n'a pas été préssé*)
    Printf.printf("[DE] Nouvelle génération !\n%!");
    for n=0 to (populationsize - 1) do                  (*Pour la taille de la population*)
      let x = Random.int (Array.length population) in   (*On prend un individu au hasard*)
      let a = ref (Random.int (Array.length population)) in (*Puis 3 autres individus tous différents 2 à 2*)
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

      let r = Random.int (dimensionsize) in  (*On prend une dimension au hasard*)
      
      let original = population.(x) in		(*On instancie l'indivudu original*)
      
      let candidate = Array.copy original in 	(*Puis un candidat*)
      
      let indi1 = population.(!a) in		(*On instancie les 3 potentiels parents du candidats*)
      let indi2 = population.(!b) in
      let indi3 = population.(!c) in

      for dim = 0 to (dimensionsize - 1) do	(*Pour chaque dimension*)
        if (Random.int dimensionsize == r) || (Random.float 1. < crossoverproba)	(*Si cette dimension est l'élue ou si la crossoverproba est vérifiée*)
        then candidate.(dim) <- clamp ( indi1.(dim) +. differentialweight *. (indi2.(dim)-. indi3.(dim)) ) (-.1.) 1. (* On calcule la nouvelle valeur du candidat pour cette dimension (le clamp est commenté pour rester général)*)
      done;

      let scorecand = func candidate in (* On calcule le score du candidat *)
      let scoreori =
        match scores.(x) with
          None -> begin
            let myscore = func original in
            scores.(x) <- Some myscore;
            myscore
          end
        | Some score -> score in(* Ainsi que celui de l'orginal *)
      if (scorecand < scoreori) (*Si le score du candidat est meilleur*)
      then begin
        population.(x) <- candidate; (*On remplace l'orginal par le candidat dans la population*)
        scores.(x) <- Some scorecand
      end
    done;
    incr nbiter (*On augmente le nombre d'itérations*)
  done;
  
  let bestfit = ref (population.(0)) in (* Enfin on sélectionne l'individu qui a le meilleur score parmis toute la population*)
  let bestfitvalue = ref (func !bestfit) in
  for i=1 to (populationsize - 1) do
    let testfit = func population.(i) in
    if (testfit  < !bestfitvalue)
    then begin bestfit := population.(i); bestfitvalue := testfit end;
  done;
  (!bestfit, population)  (*On renvoie le meilleur individu et la population finale (si on veut continuer le test sur cette population par la suite *)
    
    
