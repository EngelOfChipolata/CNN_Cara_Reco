val save_vector : out_channel -> float array -> unit
val save_pop :
  string -> Computevision.info_network -> float array array -> unit
val get_fvalue : in_channel -> float
val get_ind : in_channel -> int -> float array
val open_pop : string -> Computevision.info_network * float array array
