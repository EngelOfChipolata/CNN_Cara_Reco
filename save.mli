val save_vector : out_channel -> float array -> unit
val save_pop :
  string -> int * int * int * int * int -> float array array -> unit
val get_fvalue : in_channel -> float
val get_ind : in_channel -> int -> float array
val open_pop : string -> (int * int * int * int * int) * float array array
