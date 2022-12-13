(** Updating a given grid to produce a new generations of that grid based on the three rules of life.
    1. if there are <2 or >3 live squares surrounding a live square, that square will die. 
    2. if there are =3 live squares surrounding a live square, the square will persist. 
    3. if there are =3 live squares surrounding a dead square, the square will come to life. *)

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
(**[get_live_count lst] returns the number of alive squares in a list of squares [lst]*)