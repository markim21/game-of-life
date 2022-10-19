open Array
open Graphics 

(* Define the components of a grid. *)
module Grid = struct 
  type square = 
  | Alive
  | Dead 

  type grid = {
    x : int; 
    y : int;
    squares : square array array;
  }
end


(* Define the possible neighboring coordinates of a block *)
module Coordinates = struct 
  let am1 (a : int) : int = a - 1
  let amp (a: int) : int = a
  let ap1 (a : int) : int = a + 1
  let iter = [
  (am1, am1); (amp, am1); (ap1, am1); 
  (am1, amp); (ap1, amp); 
  (am1, ap1); (amp, ap1); (ap1, ap1); 
]
end 


(*For a given block, return a list of the coordinates for neighboring blocks*)
let rec get_neighbors (block : (int * int)) (coords : ((int -> int) * (int -> int)) list ) (grid : Grid.grid) = 
  match coords with 
  | [] -> [] 
  | (a,b) :: t -> 
    match block with
    | (x,y) -> 
      if (a x < grid.x) && (a x >= 0) && (b y < grid.y) && (b y >=0) 
        then (a,b) :: get_neighbors block t grid 
      else get_neighbors block t grid


(*For a list of block coordinates in a grid, return the number of alive*)
let rec get_live_count grid coords = 
  match coords with 
  | [] -> 0
  | (a,b) :: t -> 
    if grid.(a).(b) = Alive then 1 + get_live_count grid t else get_live_count grid t


(* For a given block in a grid, get number of its alive neighbors *)
let get_live_neighbor_count block grid = 
  let neighbors = get_neighbors block Coordinates.iter grid in 
    get_live_count grid neighbors 


(* For each block in a grid, determine the number of alive neighbors *)



(* For the number of alive neighbors for each block, 
  and the block's current state,
  generate the next generation's state of alive/dead *)

let get_new_generation (grid : Grid.grid) = 

