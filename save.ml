open Types
(* sauvegarde un tableau de float dans un fichier *)
let save_vector = fun file_channel vector ->
  Array.iter (fun elt -> Printf.fprintf file_channel "%f\n" elt) vector;
  Printf.fprintf file_channel "\n"

(* sauvegarde une population de réseau (format inline) *)
let save_pop = fun filename infos pop ->
  let channel = open_out filename in
  List.iter (fun elt -> match elt with
                            Fil (nbFils, sizeFils) -> Printf.fprintf channel "Fil %d;%d\n" nbFils sizeFils
                          | Line nb                -> Printf.fprintf channel "Line %d\n" nb
                          | LineFinal nb           -> Printf.fprintf channel "LineFinal %d\n" nb
                          | Pool div               -> Printf.fprintf channel "Pool %d\n" div
            ) infos;
            
  Printf.fprintf channel "SizePop %d\n\n" (Array.length pop);
  Array.iter (fun ind -> save_vector channel ind) pop;
  close_out channel


(* lis un float depuis le fichier *)
let get_fvalue = fun channel ->
  let st_wei = input_line channel in
  let wei = float_of_string st_wei in
  wei

(* lis nbw float dans le fichier *)
let get_ind = fun channel nbw ->
  let ind = Array.init nbw (fun _-> get_fvalue channel) in
  let _ = input_line channel in
  ind

(* ouvre un fichier de population, et renvoie les infos nécessaires et la population de réseau (format inline) *)
let open_pop = fun filename inputNature->
  let channel = open_in filename in
  let rec get_info = fun (infs,pop) ->
    let str = input_line channel in
    let tool,reste = Scanf.sscanf str "%s %s" (fun s1 s2 -> (s1,s2)) in
    let infos,nbpop = match tool with
        "Fil"       -> let nbFils, sizeFil = Scanf.sscanf reste "%i;%i" (fun nbFils sizeFil -> (nbFils, sizeFil)) in
                       let filtres = Fil (nbFils, sizeFil) in
                       let infos = filtres::infs in
                       (infos,0)
      | "Line"      -> let nb = Scanf.sscanf reste "%i" (fun nb -> nb) in
                       let line = Line nb in
                       let infos = line::infs in
                       (infos,0)
      | "LineFinal" -> let nb = Scanf.sscanf reste "%i" (fun nb -> nb) in
                       let line = LineFinal nb in
                       let infos = line::infs in
                       (infos,0)
      | "Pool"      -> let div = Scanf.sscanf reste "%i" (fun div -> div) in
                       let pool = Pool div in
                       let infos = pool::infs in
                       (infos,0)
      | "SizePop"   -> let npop = Scanf.sscanf reste "%i" (fun npop -> npop) in
                       (infs, npop)
                       
      | _           -> failwith "[ERROR] Open_pop : mot inconnu\n"
    in
    match infos,nbpop with
        (_,0) -> get_info (infos,nbpop)
      | (_,_) -> (infos,nbpop)
  in
  
  let inforev, nbinds = get_info ([],0) in
  ignore(input_line channel); (* ligne vide laissée pour les humains *)
  let infos = List.rev inforev in
  
  
  let calcNbItems =fun (natPrev, prevnb) info ->
      match info,natPrev with
        (Fil (nb, size), ImgArNAT (nbImgs, sizeImgs) ) ->
                                            let nbitems = prevnb + nb*size*size in
                                            let newNat = ImgArNAT ( nbImgs*nb, sizeImgs - (size-1)  ) in
                                            (newNat, nbitems)
                                            
      | (Pool div, ImgArNAT (nbImgs, sizeImgs) ) ->
                                            let newNat = ImgArNAT ( nbImgs, sizeImgs/div) in
                                            (newNat, prevnb)
                                                          
      | (Line nbneus, ImgArNAT (nbImgs, sizeImgs) ) ->
                                            let nbitems = prevnb + sizeImgs*sizeImgs*nbImgs*nbneus in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, nbitems)
      
      | (Line nbneus, LineNAT lenprev ) ->
                                            let nbitems = prevnb + nbneus*lenprev in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, nbitems)
      
      | (LineFinal nbneus, LineNAT lenprev ) ->
                                            let nbitems = prevnb + nbneus*lenprev in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, nbitems)
                                                             
      | (LineFinal nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> failwith "[ERROR] Cas non pris en compte : LineFinal après un array d'images."
      | (Pool _, LineNAT _  ) -> failwith "[ERROR] Pooling impossible sur un vecteur ligne !"
      | (Fil (_,_), LineNAT _ ) -> failwith "[ERROR] Impossible de convoluer sur un vecteur ligne !"
  in
  
  let _,nbitems = List.fold_left calcNbItems (inputNature, 0) infos in
  
  let pop = Array.init nbinds (fun _-> get_ind channel nbitems) in
  close_in channel;
  (infos, pop)

     
