open Graphics
open State

type shape = grid -> int -> int -> unit

val square_block : shape
val right_glider : shape
val left_glider : shape
val l_spaceship : shape
val penta : shape
val line : shape
val stack : shape
val pulsar : shape
val gun : shape
