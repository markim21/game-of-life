(*open Graphics*)
open State

(**[shape grid x y]*)
type shape = grid -> int -> int -> unit 

(**
    Some shape definitions. 
    These toggle the alive status of a set of coordinates to create a shape, 
    using [m] and [n] as an origin in [grid],
    updating [grid]*)

(**[square_block] is a static square block*)
val square_block : shape

(**[right_glider] is a moving glider going right*)
val right_glider : shape

(**[left_glider] is a moving glider going left*)
val left_glider : shape

(**[l_spaceship] is a moving lightweight spaceship going left*)
val l_spaceship : shape

(**[penta] is a periodic penta decathlon*)
val penta : shape

(**[line] is a 3-line horizontal*)
val line : shape

(**[stack] is a 3-line vertical*)
val stack : shape

(**[pulsar] is a pulsar*)
val pulsar : shape

(**[gun] is a gosper glider gun. 
    requires a grid dimensions minimum of 34 x 4 *)
val gun : shape
