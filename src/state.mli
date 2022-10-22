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
