open Types

(* génère aléatoirement les poids et biais pour passer du type Imgs au type Line. *)
let generateImgArToLine = fun sizeImgs nbImgs nbNeu ->
  Random.self_init ();
  let generateOneAtL = fun i -> Array.init nbImgs ( fun j -> Array.init sizeImgs ( fun k -> Array.init sizeImgs ( fun l -> (Random.float  10.) -.5. ))) in
  let res = Array.init nbNeu ( fun i-> (generateOneAtL i, ((Random.float  10.) -.5.)) ) in
  res ;;

(* génère aléatoirement les poids et biais pour passer du type Line au type Line. *)
let generateLineToLine = fun n nbN ->
  Random.self_init ();
  let generateOneLtL = fun i -> Array.init n ( fun j -> (Random.float 10.)-.5.) in
  let cartoonRes = Array.init nbN (fun i-> (generateOneLtL i,  ((Random.float  10.) -.5.))) in
  cartoonRes ;;

(* crée le réseau de neurones correspondant à la structure décrite par la liste infos. *)
(*  info est du type "arg_network_comp list" ex:   [ Fil 3,5  ;  Pool 2  ;  Line 100  ;  Line 10  ]    *)
let createNetwork = fun infos inputNature ->
  let create_suite = fun (natPrev, thenetwork) info ->
    match info,natPrev with
        (Fil (nb, size), ImgArNAT (nbImgs, sizeImgs) ) ->
            let convs = FilterImgs (Convolutional.randomfilterfactory size nb) in
            let net = convs::thenetwork in
            let newNat = ImgArNAT ( nbImgs*nb, sizeImgs - (size-1)  ) in
            (newNat, net)
                                            
      | (Pool div, ImgArNAT (nbImgs, sizeImgs) ) ->
            let pool = Poolfct Pooling.maxPoolConvImg in
            let net = pool::thenetwork in
            let newNat = ImgArNAT ( nbImgs, sizeImgs/div) in
            (newNat, net)
                                                          
      | (Line nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> 
            let interw =ImgsToLine  (generateImgArToLine sizeImgs nbImgs nbneus) in
            let net = interw::thenetwork in
            let newNat = LineNAT (nbneus) in
            (newNat, net)
      
      | (Line nbneus, LineNAT lenprev ) -> 
            let finalw = LineToLine (generateLineToLine lenprev nbneus) in
            let net = finalw::thenetwork in
            let newNat = LineNAT (nbneus) in
            (newNat, net)
      
      | (LineFinal nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> failwith "[ERROR] Cas non pris en compte : LineFinal après un array d'images."
      
      | (LineFinal nbneus, LineNAT lenprev ) -> 
            let finalw = LineToLineFinal (generateLineToLine lenprev nbneus) in
            let net = finalw::thenetwork in
            let newNat = LineNAT (nbneus) in
            (newNat, net)
      
      | (Pool _, LineNAT _  ) -> failwith "[ERROR] Pooling impossible sur un vecteur ligne !"
      | (Fil (_,_), LineNAT _ ) -> failwith "[ERROR] Impossible de convoluer sur un vecteur ligne !"
  in
  
  let firstNat = inputNature in
  let begnet = [] in 
  let (lastnat, truenetwork) = List.fold_left create_suite (firstNat, begnet) infos in
  List.rev truenetwork
