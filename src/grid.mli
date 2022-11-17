open Graphics
open State

val make_grid : int -> int -> grid
val draw_square : int -> int -> square -> grid -> unit
val init_grid : grid -> unit
val update_grid : grid -> unit
val change_grid : grid -> int -> int -> unit
val auto_listen_square : bool -> grid -> unit
val toggle_loop : bool -> bool
