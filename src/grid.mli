(** Most front end functionality.

    This module provides methods to create, manipulate, and update the game's
    grid, while also rendering it and listening for inputs (i.e. most of the
    user-facing features). *)

open Graphics
open Shapes
open State

val make_grid : int -> int -> grid
(**[make_grid m n] creates a grid with dimensions [m] rows and [n] columns*)

val draw_square : int -> int -> square -> grid -> unit
(**[draw_square y x square grid] draws a square on the grid white if the square
   is dead, and black if the square is dead.*)

val init_grid : grid -> unit
(**[init_grid grid] starts the game given the initial [grid] and draws to the
   screen*)

(*[update_grid grid] draws the given [grid] to the screen*)
val update_grid : grid -> unit

val change_grid : grid -> int -> int -> unit
(**[change_grid grid m n] updates the square at [m],[n] in the square array
   array of [grid] by toggling that square's alive status. If the square at [m]
   row and [n] column is alive, it will be come dead, and vice versa.*)

(*[listen_square grid] is the game loop that updates the game grid based on
  user's mouse click.*)
val listen_square : grid -> grid

val shape_action : grid -> int -> int -> shape -> grid
(**[shape_action grid x y shape] adds [shape] to [grid], updates [grid] and the
   screen, and returns to the game loop.*)
