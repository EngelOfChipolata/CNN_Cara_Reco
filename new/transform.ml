open Types
let toolsToLine = fun neurNet ->
  let down1D = fun tab ->
    let oneDlist = Array.to_list tab in
    let oneD = Array.concat oneDlist in
    oneD
  in
  let inlinedTools = List.map (fun tool ->
                match tool with
                    FilterImgs fils -> down1D (down1D fils)
                  | ImgsToLine wItoL -> down1D (down1D (down1D wItoL))
                  | LineToLine ltoL| LineToLineFinal ltoL -> down1D ltoL
                  | Poolfct fct -> [||] )
               neurNet
  in
  Array.concat inlinedTools



let getImage = fun tab size->
  Array.init size (fun i -> (Array.sub tab (i*size) size))

let getImgTab = fun tab nb size ->
  let lenImg = size*size in
  Array.init nb (fun i -> (getImage (Array.sub tab (i*lenImg) lenImg)  size))

let getTabofFils = fun tab nbtot nbfils size ->
  let lenFil = nbfils*size*size in
  Array.init nbtot (fun i -> ( getImgTab ( Array.sub tab (i*lenFil) lenFil ) nbfils size ) )



let lineToTools = fun tabini infos ->
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
                                            let lenConcerned = nbneus* nbImgs*sizeImgs*sizeImgs in
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
                                            let lineToLine = LineToLine (Array.init nbneus (fun i -> (Array.sub tab (i*lenprev) lenprev))) in
                                            let net = lineToLine::thenetwork in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, net, tabLeft)
      
      | (LineFinal nbneus, LineNAT lenprev ) ->
                                            let lenConcerned = nbneus*lenprev in
                                           (* let tabConcerned = Array.sub tab 0 lenConcerned in *)
                                            let tabLeft = Array.sub tab lenConcerned (Array.length tab - lenConcerned) in
                                            let lineToLine = LineToLineFinal (Array.init nbneus (fun i -> (Array.sub tab (i*lenprev) lenprev))) in
                                            let net = lineToLine::thenetwork in
                                            let newNat = LineNAT (nbneus) in
                                            (newNat, net, tabLeft)

      | (LineFinal nbneus, ImgArNAT (nbImgs, sizeImgs) ) -> failwith "[ERROR] Cas non pris en compte : LineFinal après un array d'images."
      | (Pool _, LineNAT _  ) -> failwith "[ERROR] Pooling impossible sur un vecteur ligne !"
      | (Fil (_,_), LineNAT _ ) -> failwith "[ERROR] Impossible de convoluer sur un vecteur ligne !"
  in
  let network = [] in
  let nat = ImgArNAT (1,28) in
  let (lastnat, truenetwork, tableft) = List.fold_left extractTool (nat, network, tabini) infos in
  List.rev truenetwork
      
      
