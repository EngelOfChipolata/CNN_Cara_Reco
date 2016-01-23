val poolimg : (float list -> float) -> float array array -> float array array
val maxPooling : float list -> float
val basicPool : float array array -> float array array
val poolConvImg : ('a -> float array array) -> 'a array -> Types.datas
val maxPoolConvImg : float array array array -> Types.datas
