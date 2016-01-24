open Types

let down1D = fun tab ->
  let oneDlist = Array.to_list tab in
  let oneD = Array.concat oneDlist in
  oneD


let iToL = fun wItoL ->
  let weigths = Array.map (fun (weiAr, _) -> weiAr) wItoL in
  let biais = Array.map (fun (_,biais) -> biais) wItoL in
  let weigthsline = down1D(down1D (down1D weigths)) in
  let weiandBiais = Array.concat [weigthsline;biais] in
  weiandBiais


let lineToL = fun wLToL ->
  let biais = Array.map (fun (_,biais) -> biais) wLToL in
  let weigths = Array.map (fun (wei,_) -> wei) wLToL in
  let weigths = down1D weigths in
  let weiandBiais = Array.concat [weigths;biais] in
  weiandBiais


let toolsToLine = fun neurNet ->

  
  let inlinedTools = List.map (fun tool ->
                match tool with
                    FilterImgs fils -> down1D (down1D fils)
                  | ImgsToLine wItoL -> iToL wItoL
                  | LineToLine ltoL| LineToLineFinal ltoL -> lineToL ltoL
                  | Poolfct fct -> [||] )
               neurNet
  in
  Array.concat inlinedTools



let getImage = fun tab size->
  Array.init size (fun i -> (Array.sub tab (i*size) size))

let getImgTab = fun tab nb size ->
  let lenImg = size*size in
  let res = Array.init nb (fun i -> (getImage (Array.sub tab (i*lenImg) lenImg)  size)) in
  res

let getTabofFils = fun tab nbtot nbfils size ->
  let lenFil = nbfils*size*size in
  let biais = Array.sub tab (nbtot*lenFil) nbtot in
  let res = Array.init nbtot (fun i -> (( getImgTab ( Array.sub tab (i*lenFil) lenFil ) nbfils size ),biais.(i)) ) in
  res


let lineToTools = fun tabini infos base_size->
  let extractTool = fun (prevNat, thenetwork, tab) info ->
    match info, prevNat with
        (Fil (nbFils, sizeFils), ImgArNAT (nbImgs, sizeImgs) ) -> 
                                            let lenConcerned = nbFils*sizeFils*sizeFils in
                                            let tabFils = Array.sub tab 0 lenConcerned in
                                            let tabLeft = Array.sub tab lenConcerned (Array.length tab - lenConcerned) in
                                            let fils = FilterImgs (getImgTab tabFils nbFils sizeFils) in
                                            let net = fils::thenetwork in
                                            let newNat = ImgArNAT ( nbImgs*nbFils, sizeImgs - (sizeFils-1)  ) in
                                            (newNat, net, tabLeft)               
                                            
      | (Pool div, ImgArNAT (nbImgs, sizeImgs) ) ->
                                            let pool = Poolfct Pooling.maxPoolConvImg in
                                            let net = pool::thenetwork in
                                            let newNat = ImgArNAT ( nbImgs, sizeImgs/div) in
                                            (newNat, net, tab)
                                             
                                                   
      | (Line nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> 
                                            let lenConcerned = nbneus*nbImgs*sizeImgs*sizeImgs+nbneus in
                                            let tabNeu = Array.sub tab 0 lenConcerned in
                                            let tabLeft = Array.sub tab lenConcerned (Array.length tab - lenConcerned) in
                                            let iToLine = ImgsToLine (getTabofFils tabNeu nbneus nbImgs sizeImgs) in
                                            let net = iToLine::thenetwork in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, net, tabLeft)

      | (Line nbneus, LineNAT lenprev ) ->
                                            let lenConcerned = nbneus*lenprev in
                                            (* let tabConcerned = Array.sub tab 0 lenConcerned in *)
                                            let tabLeft = Array.sub tab lenConcerned (Array.length tab - lenConcerned) in
                                            let lineToLine = 
                                                    let biais = Array.sub tab (nbneus*lenprev) nbneus in
                                                    LineToLine (Array.init nbneus (fun i -> ((Array.sub tab (i*lenprev) lenprev), biais.(i) ))) in
                                            let net = lineToLine::thenetwork in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, net, tabLeft)
      
      | (LineFinal nbneus, LineNAT lenprev ) ->
                                            let lenConcerned = nbneus*lenprev in
                                           (* let tabConcerned = Array.sub tab 0 lenConcerned in *)
                                            let tabLeft = Array.sub tab lenConcerned (Array.length tab - lenConcerned) in
                                            let lineToLine = 
                                                    let biais = Array.sub tab (nbneus*lenprev) nbneus in
                                                    LineToLineFinal (Array.init nbneus (fun i -> ((Array.sub tab (i*lenprev) lenprev), biais.(i) ))) in
                                            let net = lineToLine::thenetwork in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, net, tabLeft)

      | (LineFinal nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> failwith "[ERROR] Cas non pris en compte : LineFinal après un array d'images."
      | (Pool _, LineNAT _  ) -> failwith "[ERROR] Pooling impossible sur un vecteur ligne !"
      | (Fil (_,_), LineNAT _ ) -> failwith "[ERROR] Impossible de convoluer sur un vecteur ligne !"
  in
  let network = [] in
  let nat = ImgArNAT (1,base_size) in
  let (lastnat, truenetwork, tableft) = List.fold_left extractTool (nat, network, tabini) infos in
  List.rev truenetwork


let createInlinePopulation = fun info nb base_size->
  let population = Array.init nb (fun _ -> toolsToLine (Createnetwork.createNetwork info base_size)) in
  population 
