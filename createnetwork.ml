open Types
  
let generateImgArToLine = fun sizeImgs nbImgs nbNeu ->
  Random.self_init ();
  let generateOneAtL = fun i -> Array.init nbImgs ( fun j -> Array.init sizeImgs ( fun k -> Array.init sizeImgs ( fun l -> (Random.float  2.) -.1. ))) in
  let res = Array.init nbNeu ( fun i-> (generateOneAtL i, 0.) ) in
  res ;;


let generateLineToLine = fun n nbN ->
  Random.self_init ();
  let generateOneLtL = fun i -> Array.init n ( fun j -> (Random.float 1.)-.0.5) in
  let cartoonRes = Array.init nbN (fun i-> (generateOneLtL i, 0.)) in
  cartoonRes ;;


(*  info est du type "arg_network_comp list" ex:   [ Fil 3,5  ;  Pool 2  ;  Line 100  ;  Line 10  ]    *)
let createNetwork = fun infos base_size ->
  let create_suite = fun (natPrev, thenetwork) info ->		(* rec pour un fold_left ? *)
    match info,natPrev with
        (Fil (nb, size), ImgArNAT (nbImgs, sizeImgs) ) -> let convs = FilterImgs (Convolutional.randomfilterfactory size nb) in
                                            let net = convs::thenetwork in
                                            let newNat = ImgArNAT ( nbImgs*nb, sizeImgs - (size-1)  ) in
                                            (newNat, net)
                                            
     (* | (Pool div, ImgArNAT (nbImgs, sizeImgs) ) -> let pool = Unknow "pool" in *)
      | (Pool div, ImgArNAT (nbImgs, sizeImgs) ) -> let pool = Poolfct Pooling.maxPoolConvImg in
                                                          let net = pool::thenetwork in
                                                          let newNat = ImgArNAT ( nbImgs, sizeImgs/div) in
                                                          (newNat, net)
                                                          
      | (Line nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> let interw =ImgsToLine  (generateImgArToLine sizeImgs nbImgs nbneus) in
                                                             let net = interw::thenetwork in
                                                             let newNat = LineNAT (nbneus) in
                                                             (newNat, net)
      
      | (Line nbneus, LineNAT lenprev ) -> let finalw = LineToLine (generateLineToLine lenprev nbneus) in
                                                             let net = finalw::thenetwork in
                                                             let newNat = LineNAT (nbneus) in
                                                             (newNat, net)
      
      | (LineFinal nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> failwith "[ERROR] Cas non pris en compte : LineFinal après un array d'images."
      
      | (LineFinal nbneus, LineNAT lenprev ) -> let finalw = LineToLineFinal (generateLineToLine lenprev nbneus) in
                                                             let net = finalw::thenetwork in
                                                             let newNat = LineNAT (nbneus) in
                                                             (newNat, net)
      
      | (Pool _, LineNAT _  ) -> failwith "[ERROR] Pooling impossible sur un vecteur ligne !"
      | (Fil (_,_), LineNAT _ ) -> failwith "[ERROR] Impossible de convoluer sur un vecteur ligne !"
  in
  
  let firstNat = ImgArNAT  (1, base_size) in
  let begnet = [] in 
  let (lastnat, truenetwork) = List.fold_left create_suite (firstNat, begnet) infos in
  List.rev truenetwork
