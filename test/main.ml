open OUnit2
open Game
open Game.Grid
open Game.State

(*empty grid*)
let empty_grid = make_grid 3 3

let grid_bread_start =
  {
    x = 5;
    y = 5;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = false };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = true };
          { x = 3; y = 0; alive = false };
          { x = 4; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = true };
          { x = 1; y = 1; alive = false };
          { x = 2; y = 1; alive = true };
          { x = 3; y = 1; alive = false };
          { x = 4; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = true };
          { x = 2; y = 2; alive = true };
          { x = 3; y = 2; alive = false };
          { x = 4; y = 2; alive = false };
        |];
        [|
          { x = 0; y = 3; alive = false };
          { x = 1; y = 3; alive = false };
          { x = 2; y = 3; alive = false };
          { x = 3; y = 3; alive = false };
          { x = 4; y = 3; alive = false };
        |];
        [|
          { x = 0; y = 4; alive = false };
          { x = 1; y = 4; alive = false };
          { x = 2; y = 4; alive = false };
          { x = 3; y = 4; alive = false };
          { x = 4; y = 4; alive = false };
        |];
      |];
  }

let grid_bread_end =
  {
    x = 5;
    y = 5;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = false };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
          { x = 3; y = 0; alive = false };
          { x = 4; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = false };
          { x = 2; y = 1; alive = false };
          { x = 3; y = 1; alive = false };
          { x = 4; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = false };
          { x = 2; y = 2; alive = false };
          { x = 3; y = 2; alive = false };
          { x = 4; y = 2; alive = true };
        |];
        [|
          { x = 0; y = 3; alive = false };
          { x = 1; y = 3; alive = false };
          { x = 2; y = 3; alive = true };
          { x = 3; y = 3; alive = false };
          { x = 4; y = 3; alive = true };
        |];
        [|
          { x = 0; y = 4; alive = false };
          { x = 1; y = 4; alive = false };
          { x = 2; y = 4; alive = false };
          { x = 3; y = 4; alive = true };
          { x = 4; y = 4; alive = true };
        |];
      |];
  }

let grid_bread_corner =
  {
    x = 5;
    y = 5;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = false };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
          { x = 3; y = 0; alive = false };
          { x = 4; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = false };
          { x = 2; y = 1; alive = false };
          { x = 3; y = 1; alive = false };
          { x = 4; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = false };
          { x = 2; y = 2; alive = false };
          { x = 3; y = 2; alive = false };
          { x = 4; y = 2; alive = false };
        |];
        [|
          { x = 0; y = 3; alive = false };
          { x = 1; y = 3; alive = false };
          { x = 2; y = 3; alive = false };
          { x = 3; y = 3; alive = true };
          { x = 4; y = 3; alive = true };
        |];
        [|
          { x = 0; y = 4; alive = false };
          { x = 1; y = 4; alive = false };
          { x = 2; y = 4; alive = false };
          { x = 3; y = 4; alive = true };
          { x = 4; y = 4; alive = true };
        |];
      |];
  }

let grid_diamond =
  {
    x = 5;
    y = 5;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = false };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
          { x = 3; y = 0; alive = false };
          { x = 4; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = false };
          { x = 2; y = 1; alive = true };
          { x = 3; y = 1; alive = false };
          { x = 4; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = true };
          { x = 2; y = 2; alive = false };
          { x = 3; y = 2; alive = true };
          { x = 4; y = 2; alive = false };
        |];
        [|
          { x = 0; y = 3; alive = false };
          { x = 1; y = 3; alive = false };
          { x = 2; y = 3; alive = true };
          { x = 3; y = 3; alive = false };
          { x = 4; y = 3; alive = false };
        |];
        [|
          { x = 0; y = 4; alive = false };
          { x = 1; y = 4; alive = false };
          { x = 2; y = 4; alive = false };
          { x = 3; y = 4; alive = false };
          { x = 4; y = 4; alive = false };
        |];
      |];
  }

let grid_A =
  {
    x = 3;
    y = 3;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = false };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = true };
          { x = 2; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = false };
          { x = 2; y = 2; alive = false };
        |];
      |];
  }

let grid_B =
  {
    x = 3;
    y = 3;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = true };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = true };
          { x = 2; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = false };
          { x = 2; y = 2; alive = true };
        |];
      |];
  }

let grid_C =
  {
    x = 3;
    y = 3;
    squares : square array array =
      [|
        [|
          { x = 0; y = 0; alive = true };
          { x = 1; y = 0; alive = false };
          { x = 2; y = 0; alive = false };
        |];
        [|
          { x = 0; y = 1; alive = false };
          { x = 1; y = 1; alive = true };
          { x = 2; y = 1; alive = false };
        |];
        [|
          { x = 0; y = 2; alive = false };
          { x = 1; y = 2; alive = false };
          { x = 2; y = 2; alive = true };
        |];
      |];
  }



(** TEST STATE.ML **)
(**[next_generation_test name init_grid next_grid] tests 
    new_generation. a given grid [init_grid] after one iteration
    should match next_grid based on the rules of life. *)
let next_generation_test (name : string) (init_grid : grid) (next_grid : grid) :
    test =
  name >:: fun _ -> assert_equal next_grid (new_generation init_grid)

(**[future_generations_test ]*)
let future_generations_test (name : string) (generations : int)
    (init_grid : grid) (final_grid : grid) : test =
  name >:: fun _ ->
  assert_equal final_grid
    (let rec generation_loop remaining_generations grid =
       match remaining_generations with
       | r when r <= 0 -> grid
       | _ ->
           let new_population = new_generation grid in
           generation_loop (remaining_generations - 1) new_population
     in
     generation_loop generations init_grid)

(**helper function to turn square array list into square list*)
let rec square_list_tr (acc : square list) (squares_lst) = 
match squares_lst with 
| [] -> acc 
| h :: t -> let lst = Array.to_list h in square_list_tr (lst@acc) (t)

(**helper function to turn square array array into square array list*)
let square_array_to_lst (grid:grid) : square list = 
  let grid_lst = Array.to_list grid.squares in 
  square_list_tr [] grid_lst
    

(**[grid_live_count_test name init_grid final_grid] 
   tests function get_live_count and count_living_tr. counts the number of alive squares in a given grid *)
let grid_live_count_test (name: string) (live_count : int) (grid: grid) : test = 
  name >:: fun _ -> assert_equal live_count (
    square_array_to_lst grid |> get_live_count )  


(**[generation_live_count_test name start_count init_grid end_count final_grid]
    tests function count_living_tr if the number of alive squares for a
    start generation and end generation are as predicted. *)
let generation_live_count_test (name:string) (start_count : int) (init_grid : grid) (end_count : int ) (final_grid : grid) : test = 
  name >:: fun _ -> failwith "unimplemented"


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

let neighbors_test (name:string) (square:square) (grid:grid) (neighbors:square list) : test = 
  name >:: fun _ -> 
    assert_equal neighbors (get_neighbor_coordinates square grid coordinates [])

let next_generation_tests =
  [
    next_generation_test "a dead grid cannot produce a living grid on its own"
      empty_grid empty_grid;
    next_generation_test "a 3x3 grid with [1,1] alive results in a dead grid"
      grid_A empty_grid;
    next_generation_test
      "a 3x3 grid with [0,0] [1,1] [2,2] alive results in only [1,1] alive"
      grid_B grid_A;
  ]

let future_generations_tests = [
  future_generations_test "after 4 generations, a dead grid remains dead." 4
      empty_grid empty_grid;
  future_generations_test "after 50+ generations, a diamond never changes its shape"
    100 grid_diamond grid_diamond;
  future_generations_test "after 8 generations, a bread transposes" 
    8 grid_bread_start grid_bread_end;
  future_generations_test "after 10+ generations, a bread reaches the corner forever"
    100 grid_bread_start grid_bread_corner;
]

let live_count_tests = [
  grid_live_count_test 
    "an empty array has no alive squares"
    0 
    empty_grid;
  grid_live_count_test
    "grid_A has one alive square"
    1
    grid_A;
  grid_live_count_test
    "grid_diamond has 4 alive squares"
    4
    grid_diamond;
  grid_live_count_test
    "grid_bread_corner has 4 alive squares"
    4
    grid_bread_corner;
  grid_live_count_test
    "grid_bread_start has 5 alive squares"
    5
    grid_bread_start
]

let neighbors_tests = [

]


let state_tests = 
  next_generation_tests @
  future_generations_tests @
  live_count_tests @ 
  neighbors_tests

(** TEST GRID.ML **)

(* [click_square >> (change_grid) >> update_grid] *)

(* clicking on [1,1] of a [3,3] grid with all dead cells turns [1,1] alive, and
   vice versa*)

let click_square_test (name : string) (x : int) (y : int) (init_grid : grid) (final_grid : grid) : test =
 name >:: fun _ -> assert_equal final_grid 
 (new_generation init_grid)


(* same as above, but alive to dead. *)

(* *)

let grid_tests = [  ]
let tests = "test suite" >::: List.flatten [ state_tests; grid_tests ]
let _ = run_test_tt_main tests