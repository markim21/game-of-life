open OUnit2
open Game
open Game.Grid
open Game.State

(*empty grid*)
let empty_grid = make_grid 3 3

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
let next_generation_test (name : string) (init_grid : grid) (next_grid : grid) :
    test =
  name >:: fun _ -> assert_equal next_grid (new_generation init_grid)

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

let state_tests =
  [
    future_generations_test "after 4 generations, a dead grid remains dead." 4
      empty_grid empty_grid;
    next_generation_test "a dead grid cannot produce a living grid on its own"
      empty_grid empty_grid;
    next_generation_test "a 3x3 grid with [1,1] alive results in a dead grid"
      grid_A empty_grid;
    next_generation_test
      "a 3x3 grid with [0,0] [1,1] [2,2] alive results in only [1,1] alive"
      grid_B grid_A;
  ]

(** TEST GRID.ML **)
let toggle_loop_test (name : string) (expected : bool) (start : bool) : test =
  name >:: fun _ -> assert_equal expected (toggle_loop start)

(* [click_square >> (change_grid) >> update_grid] *)

(* clicking on [1,1] of a [3,3] grid with all dead cells turns [1,1] alive, and
   vice versa*)

(* same as above, but alive to dead. *)

(* *)

let grid_tests = [ toggle_loop_test "test helper function" false true ]
let tests = "test suite" >::: List.flatten [ state_tests; grid_tests ]
let _ = run_test_tt_main tests