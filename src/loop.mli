(** Provides gameplay "loop."

    This module provides functions for automatically stepping a grid (i.e.
    indefintely making new generations from the previous). *)

open Graphics
open State
open Grid

val step : grid -> unit
(**[step grid] updates [grid] so [grid.squares] is the next generation of
   squares (one-step)*)

val loop_generations : grid -> unit
(**[loop_generations grid] is the game loop. continuously updates [grid] to next
   generation until ' ' raises Exit.*)
