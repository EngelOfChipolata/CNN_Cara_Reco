val poolimg : (float list -> float) -> Importscans.image -> Importscans.image
val maxPooling : 'a list -> 'a
val basicPool : Importscans.image -> Importscans.image
val poolConvImg : ('a -> 'b) -> 'a array -> 'b array
val maxPoolConvImg : Importscans.image array -> Importscans.image array
