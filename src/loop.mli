open Graphics
open State 
open Grid 

val step : grid -> unit 
(**[step grid] updates [grid] so [grid.squares] is the next generation of squares (one-step)*)

val loop_generations : grid -> unit 
(**[loop_generations grid] is the game loop. continuously updates [grid] to next generation until ' ' raises Exit.*)
