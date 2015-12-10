val poolimg : (int list -> int) -> Importscans.image -> Importscans.image
val sumPooling : int list -> int
val maxPooling : 'a list -> 'a
val basicPool : Importscans.image -> Importscans.image
val poolConvImg : ('a -> 'b) -> 'a array -> 'b array
val maxPoolConvImg : Importscans.image array -> Importscans.image array
