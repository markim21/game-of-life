open Graphics
open State

type shape = grid -> int -> int -> unit

val square_block : shape
val right_glider : shape
val left_glider : shape
