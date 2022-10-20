open Array
open Graphics 

(* Define the components of a grid. *)
module Grid = struct 
  (* every cell stores its location and alive status. *)
  type square = {
    x : int;
    y : int;
    alive : bool;
  }

  (* every grid has x by y dimensions and a 2D array of squares *)
  type grid = {
    x : int; 
    y : int;
    squares : square array array;
  }
end


(* Define the possible neighboring coordinates of a block *)

(* a = the current location. 
  if a__ is outside the grid bounds,
    then do not add that block to the list of neighbors.
  if a__ is inside the grid bounds, 
    then add that block to the list of neighbors. *)
let ap1 (a : int) : int = a + 1
let am1 (a : int) : int = a - 1 
let amp (a : int) : int = a

let coordinates = 
  [ (am1, ap1); (amp, ap1); (ap1, am1);
    (am1, amp); (ap1, amp);
    (am1, ap1); (amp, ap1); (ap1, ap1)]

(* helper function to test if coordinate is within grid dimensions *)
let validate_boundary (max : int) (min : int) (value : int) = 
  (value < max) && (value > min)


(*For a given block, return a list of the neighboring squares
   Filter invalid coordinates - ie if the block is a edge piece. *)
let rec get_neighbor_coordinates (square : Grid.square) (g : Grid.grid) (coords : ((int -> int) * (int -> int)) list ) (neighbors: Grid.square list) : Grid.square list = 
  (* iterate through every coordinate in coordinates list. *)
  match coords with 
  | [] -> neighbors 
  | (x,y) :: t -> 
    (* define x y = coordinates of the potential neighbor square we're checking *)
    let x = x square.x in let y = y square.y in 

      if validate_boundary 0 g.x x && validate_boundary 0 g.y y
        then get_neighbor_coordinates square g t (( g.squares.(x).(y) ) :: neighbors)
        else get_neighbor_coordinates square g t (neighbors)



(* For a list of squares, count the number of neighbors alive tail recursively *)
let rec count_living_tr (lst : Grid.square list) (count : int) : int = 
  match lst with 
  | [] -> count
  | x :: t -> if x.alive then count_living_tr t (count+1) else count_living_tr t count

let get_live_count (lst : Grid.square list) : int = 
  count_living_tr lst 0



(* For a given square, determine the square's next state
   based on the square's neighbors. 
      1. get the square's neighbors
      2. get how many of its neighbors are alive
      3. if square is alive --> <game of life rules>
      4. return new state as boolean  *)


(* Evaluate the new state for every block in a given grid. *)

