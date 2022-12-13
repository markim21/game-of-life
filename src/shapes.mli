(** Some shape definitions.

    This module provides helper functions to toggle the alive status of a set of
    coordinates to create a shape, using [m] and [n] as an origin in [grid],
    updating [grid]*)

open State

type shape = grid -> int -> int -> unit
(**[shape grid x y]*)

val square_block : shape
(**[square_block] is a static square block*)

val right_glider : shape
(**[right_glider] is a moving glider going right*)

val left_glider : shape
(**[left_glider] is a moving glider going left*)

val l_spaceship : shape
(**[l_spaceship] is a moving lightweight spaceship going left*)

val penta : shape
(**[penta] is a periodic penta decathlon*)

val line : shape
(**[line] is a 3-line horizontal*)

val stack : shape
(**[stack] is a 3-line vertical*)

val pulsar : shape
(**[pulsar] is a pulsar*)

val gun : shape
(**[gun] is a gosper glider gun. requires a grid dimensions minimum of 34 x 4 *)
