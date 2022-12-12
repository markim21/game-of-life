(** Updating a grid to produce new generations of grids *)

type square = {
  x : int;
  y : int;
  alive : bool;
}
(** Represent one cell on a grid. Holds its location information in [x y] and
    alive status in boolean [alive]*)

type grid = {
  x : int;
  y : int;
  squares : square array array;
}
(** Represent a grid of cells. dimensions of [x y] and a 2D array of square
    types [squares]*)

val new_generation : grid -> grid
(** [new_generation grid] is a grid type with the next generation of cells given
    an initial population [grid] *)

val get_neighbor_coordinates : square -> grid -> ((int -> int) * (int -> int)) list -> square list -> square list  
(*[get_neighbor_coordinates] for a given block, return a list of the neighboring squares Filter invalid
  coordinates - ie if the block is a edge piece. *)

val get_live_count : square list -> int 
(**[get_live_count lst] returns the live count of a list of squares*)