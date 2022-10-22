open OUnit2
open Game.Grid
open Game.State

(*empty grid*)
let empty_grid = 
  make_grid 3 3 

let grid_A = {
  x = 3;
  y = 3;
  squares : square array array = [|
    [|{x=0;y=0;alive=false}; {x=1;y=0;alive=false}; {x=2;y=0;alive=false}; |];
    [|{x=0;y=1;alive=false}; {x=1;y=1;alive=true}; {x=2;y=1;alive=false};|];
    [|{x=0;y=2;alive=false}; {x=1;y=2;alive=false}; {x=2;y=2;alive=false};|];
  |]
}  

let grid_B = {
  x = 3;
  y = 3;
  squares : square array array = [|
    [|{x=0;y=0;alive=true}; {x=1;y=0;alive=false}; {x=2;y=0;alive=false}; |];
    [|{x=0;y=1;alive=false}; {x=1;y=1;alive=true}; {x=2;y=1;alive=false};|];
    [|{x=0;y=2;alive=false}; {x=1;y=2;alive=false}; {x=2;y=2;alive=true};|];
  |]
}  

let next_generation_test (name:string) (init_grid: grid) (next_grid:grid) : test = 
  name >:: fun _ -> 
    assert_equal next_grid (new_generation init_grid)

let state_tests = [
    next_generation_test 
      "a 3x3 grid with [1,1] alive results in a dead grid"
      grid_A
      empty_grid;
    
    next_generation_test 
      "a 3x3 grid with [0,0] [1,1] [2,2] alive results in only [1,1] alive"
      grid_B
      grid_A;

]

let tests = "test suite" >::: List.flatten [state_tests]
let _ = run_test_tt_main tests