open Array

(* Define the components of a grid. *)

type square = {
  x : int;
  y : int;
  alive : bool;
}

type grid = {
  x : int;
  y : int;
  squares : square array array;
}

(* Define the possible neighboring coordinates of a block

   a = the current location. if a__ is outside the grid bounds, then do not add
   that block to the list of neighbors. if a__ is inside the grid bounds, then
   add that block to the list of neighbors. *)
let ap1 (a : int) : int = a + 1
let am1 (a : int) : int = a - 1
let amp (a : int) : int = a

let coordinates =
  [
    (am1, ap1);
    (amp, ap1);
    (ap1, am1);
    (am1, amp);
    (ap1, amp);
    (am1, am1);
    (amp, am1);
    (ap1, ap1);
  ]

(**[validate_boundary max min value] tests if coordinate [value] is within 
    grid dimensions [max] and [min]*)
let validate_boundary (max : int) (min : int) (value : int) =
  value < max && value >= min

let rec get_neighbor_coordinates (square : square) (g : grid) (coords : ((int -> int) * (int -> int)) list) (neighbors : square list) : square list =
  (* iterate through every coordinate in coordinates list. *)
  match coords with
  | [] -> neighbors
  | (x, y) :: t ->
      (* define x y = coordinates of the potential neighbor square we're checking *)
      let x = x square.x in
      let y = y square.y in

      if validate_boundary g.x 0 x && validate_boundary g.y 0 y then
        get_neighbor_coordinates square g t (g.squares.(y).(x) :: neighbors)
      else get_neighbor_coordinates square g t neighbors

(* For a list of squares, count the number of neighbors alive tail-recursively *)
let rec count_living_tr (lst : square list) (count : int) : int =
  match lst with
  | [] -> count
  | x :: t ->
      if x.alive then count_living_tr t (count + 1) else count_living_tr t count

let get_live_count (lst : square list) : int = count_living_tr lst 0

(* [get_next_square_state square grid] determine [square]'s next state based on 
   [square]'s neighbors. 
   1. get the square's neighbors 
   2. get how many of its neighbors are alive 
   3. if square is alive --> <game of life rules> 
   4. return new state as boolean *)
let get_next_square_state (square : square) (grid : grid) : bool =
  let live_count =
    get_neighbor_coordinates square grid coordinates [] |> get_live_count
  in

  if square.alive then if live_count < 2 || live_count > 3 then false else true
  else if live_count = 3 then true
  else false

(**[change_square_state square grid] gets a square's next generation state 
    based on its neighbors.*)
let change_square_state (square : square) (grid : grid) : square =
  { x = square.x; y = square.y; alive = get_next_square_state square grid }

(* *[twice_map] maps a function to every element of a 2D array *)
let twice_map f = Array.map (Array.map f)

(* Evaluate the new state for every block in a given grid. 
    1. create new grid with an empty array 
    2. iterate through each square in the grid 
    3. evaluate each square. add to new grid *)
let new_generation (grid : grid) : grid =
  {
    x = grid.x;
    y = grid.y;
    squares = twice_map (fun x -> change_square_state x grid) grid.squares;
  }