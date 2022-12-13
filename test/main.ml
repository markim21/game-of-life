open OUnit2
open Game
open Game.Grid
open Game.State
open Game.Shapes

(**
The following modules were tested manually: Menu, Loop, Grid 
The following modules were tested with OUnit test cases: Grid, State, Shapes

The Menu module was tested manually, due to its entirely visual nature. For [start_menu], [menu_draw], [listen_menu], [square_num], 
[rules_draw], [patterns_draw], we made sure each part of the menu was drawn to the screen as intended.

The Grid module was tested manually and with OUnit test cases. 
Visual functions [draw_square], [update_grid], [init_grid] are tested by clicking various parts of the screen to create grids.
The game loop [listen_square] is tested by clicking the screen to create a grid and pressing a key to generate a new generation for
the created grid. Black box tests were developed for [make_grid] and [change_grid] to ensure they created the right size grid and properly updated the
grid's square array array when a square was clicked.
Because these two functions are used by all of other modules menu, state, and loop, it was necessary to demonstrate these
functions behaved as intended without knowledge of their implementation, so each every module that extended Grid could behave as intended.

The State module was tested only with OUnit test cases. Black box tests were generated for new_generation to test the three rules of the game 
were being followed given typical, simple grids (grid_bread, grid_diamond, grid_A/B/C/D) as well as extreme/outlier grids (an empty grid, a 
fully alive grid, and grids with randomly generated dimensions.

The Loop module was tested manually due to its entirely visual nature. 
Before writing [loop_generations], we used [step] to increment the grid one generation at a time by keystroke.
After [step] produced generations of a grid by keystroke, we implemented and tested [loop_generations] using the
same grids used in the OUnit test cases for State and Grid, removing the ability to increment generations by keystroke.

The Shapes module was tested manually and with OUnit test cases. We clicked the corresponding key binding for each 
defined shape to ensure it showed up on screen wherever the player's mouse was. 
Using definitions of these grids from https://web.mit.edu/sp.268/www/2010/lifeSlides.pdf, black box tests validated that the 
shapes oscillated as predicted. 
These shapes were also used to test the Grid and State module behavior. 

These tests evaluate a variety of grids, both randomly generated and mathematically proven. Thorough black-box testing of all the 
modules that define and pertain to the three game laws was important in demonstrating the correctness of the system, because they make up
the foundation of John Conway's game. Because the game runs itself, no exceptions could possibly be made.
*)

(** BLACK BOX TESTING OF STATE.ML ******************************************)

(*[fresh_grid] given [m] and [n] create a new empty grid of those dimensions.*)
let fresh_grid m n = 
  fun () -> 
    make_grid m n 

(*[random_dimensions] returns a pair of random integers (x, y) between 0 and 100 such that x = number of rows and y = number of columns in a grid. *)
let random_dimensions = 
  Random.self_init ();
  fun () -> 
    let m = Random.int 100 in 
    let n = Random.int 100 in 
    (m, n)

(* [clear_grid] given a grid's dimensions, return a completely blacked out, alive grid. *)
let clear_grid grid state = 
  let m = grid.x in 
  let n = grid.y in 
  let array = Array.make m (Array.make n {x = 0; y = 0; alive = state}) in 
    for i = 0 to m - 1 do
      let temp = Array.make n { x = 0; y = 0; alive = state } in
      for j = 0 to n - 1 do
        temp.(j) <- { x = j; y = i; alive = state }
      done;
      array.(i) <- temp
    done;
  {x = n; y = m; squares = array}

(* create a grid of random dimensions *)
let random_grid = 
  match random_dimensions () with 
  | (m, n) -> fresh_grid m n ()

(** Define simple grids to check [new_generation] validity. *)
let empty_grid = make_grid 3 3
let grid_bread_start =
  {
    x = 5;
    y = 5;
    squares =
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
        [| (* [(0,0); (1,1); (2,2)] *)
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

(** [next_generation_test] tests new_generation after one cycle of life.
    a given grid [init_grid] after one iteration should match next_grid based on the rules of life. *)
let next_generation_test (name : string) (init_grid : grid) (next_grid : grid) :
    test =
  name >:: fun _ -> assert_equal next_grid (new_generation init_grid)

(** [generation_loop] returns a [grid] after [remaining_generations] generations*)
let rec generation_loop remaining_generations grid =
    match remaining_generations with
    | r when r <= 0 -> grid
    | _ ->
        let new_population = new_generation grid in
        generation_loop (remaining_generations - 1) new_population

(**[future_generations_test] tests new_generation after multiple cycles of life. 
    a given grid [init_grid] and a number of [generations] should match final_grid*)
let future_generations_test (name : string) (generations : int) (init_grid : grid) (final_grid : grid) : test =
  name >:: fun _ ->
  assert_equal final_grid
    (generation_loop generations init_grid)

(**[random_black_test] generates a randomly sized grid, blacks out one, and proves that after 2 generations it will always be empty*)
let random_black_test : test = 
  let rand_dim = random_dimensions () in 
  let new_grid = 
  match rand_dim with 
  | (x, y) -> fresh_grid x y () 
  in 
  let rg = clear_grid new_grid false in 
  let bg = clear_grid new_grid true in 
  future_generations_test "after 2 generations, a fully alive grid becomes fully dead" 2 bg rg

let random_empty_test : test = 
  let rg = random_grid in 
  future_generations_test "after 4 generations, a dead grid remains dead" 4 rg rg 

(** Test simple grids after multiple generations. *)
let future_generations_tests = [
  future_generations_test "after 4 generations, a dead grid remains dead." 
    4 empty_grid empty_grid;
  future_generations_test "after 50+ generations, a diamond never changes its shape"
    100 grid_diamond grid_diamond;
  future_generations_test "after 8 generations, a bread transposes" 
    8 grid_bread_start grid_bread_end;
  future_generations_test "after 10+ generations, a bread reaches the corner forever"
    100 grid_bread_start grid_bread_corner;
  random_empty_test;
  random_black_test;
]

(** Test simple grids after one generation. *)
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


(** BLACK BOX TESTING OF SHAPES.ML **************************************)

(*A square block is static, and remains the same no matter what*)
let square_block g = square_block g 25 25; g

(* Gliders repeat themselves every 4 generations, offset diagonally by one cell.*)
let right_glider g x y = right_glider g x y; g
let left_glider g x y = left_glider g x y; g

(* Lightweight spaceships have a speed of c/2 *)
let l_spaceship g = l_spaceship g 10 10; g

(* Lines and stacks oscillate to equal each other at a speed of c/2 *)
let line g = line g 2 4; g
let stack g = stack g 3 3; g

(* Pentadecathlons oscillate with a period of 15 generations*)
let penta g = penta g 25 25; g

(* Pulsars oscillate with a period of 3 generations *)
let pulsar g = pulsar g 25 25; g 

(* Gosper Glider Gun emits a new glider ever 30 generations *)
let gun g = gun g 0 4; g 

let shapes_oscillate_tests = [
  future_generations_test 
    "(left) gliders are p-4 oscillators that are offset diagonally by one cell"
    4
    (left_glider (fresh_grid 50 50 ()) 10 10)
    (left_glider (fresh_grid 50 50 ()) 9 9)
  ;

  future_generations_test 
    "(left) gliders are p-4 oscillators that are offset diagonally by one cell"
    12
    (left_glider (fresh_grid 50 50 ()) 10 10)
    (left_glider (fresh_grid 50 50 ()) 7 7)
  ;

  future_generations_test 
    "(right) gliders are p-4 oscillators that are offset diagonally by one cell"
    4 
    (right_glider (fresh_grid 50 50 ()) 10 10)
    (right_glider (fresh_grid 50 50 ()) 11 9)
  ;

  future_generations_test 
    "(right) gliders are p-4 oscillators that are offset diagonally by one cell"
    12
    (right_glider (fresh_grid 50 50 ()) 10 10)
    (right_glider (fresh_grid 50 50 ()) 13 7)
  ;

  future_generations_test
    "lines and stacks oscillate to each other every other generation"
    1
    (line (fresh_grid 50 50 ()))
    (stack (fresh_grid 50 50 ()));

  future_generations_test
    "lines and stacks oscillate to each other at a speed of c/2"
    11
    (line (fresh_grid 50 50 ()))
    (stack (fresh_grid 50 50 ()));

  future_generations_test 
    "lines are p-2 oscillators"
    50
    (line (fresh_grid 50 50 ()))
    (line (fresh_grid 50 50 ()));
  
  future_generations_test 
    "stacks are p-2 oscillators"
    50
    (stack (fresh_grid 50 50 ()))
    (stack (fresh_grid 50 50 ()));

  future_generations_test 
    "lines are p-2 oscillators"
    2
    (line (fresh_grid 50 50 ()))
    (line (fresh_grid 50 50 ()));
  
  future_generations_test 
    "stacks are p-2 oscillators"
    2
    (stack (fresh_grid 50 50 ()))
    (stack (fresh_grid 50 50 ()));

  future_generations_test 
     "square blocks are static" 
     50
     (square_block (fresh_grid 50 50 ()))
     (square_block (fresh_grid 50 50 ()));

  future_generations_test 
     "pulsars are p-3 oscillators"
     3
     (pulsar (fresh_grid 50 50 ()))
     (pulsar (fresh_grid 50 50 ()));

  future_generations_test 
    "pentas are p-15 oscillators"
    15
    (penta (fresh_grid 50 50 ()))
    (penta (fresh_grid 50 50 ()));

  future_generations_test 
     "pulsars are p-3 oscillators"
     33
     (pulsar (fresh_grid 50 50 ()))
     (pulsar (fresh_grid 50 50 ()));

  future_generations_test 
    "pentas are p-15 oscillators"
    60
    (penta (fresh_grid 50 50 ()))
    (penta (fresh_grid 50 50 ()))  
]


(** GLASS BOX TESTING OF STATE.ML ****************************)

(**[square_list_tr] turns a square array list into square list tail recursively*)
let rec square_list_tr (acc : square list) (squares_lst) = 
match squares_lst with 
| [] -> acc 
| h :: t -> let lst = Array.to_list h in square_list_tr (lst@acc) (t)

(**[square_array_to_lst] turns a square array array into square array list*)
let square_array_to_lst (grid:grid) : square list = 
  let grid_lst = Array.to_list grid.squares in 
  square_list_tr [] grid_lst
    
(**[grid_live_count_test] tests function get_live_count and count_living_tr. 
    counts the number of alive squares in a given grid *)
let grid_live_count_test (name: string) (live_count : int) (grid: grid) : test = 
  name >:: fun _ -> assert_equal live_count (square_array_to_lst grid |> get_live_count)  

(* generate a random number of clicks on a randomly sized grid, and count the number of live squares *)
(*let random_live_count_test : test = failwith "RANDOM LIVE COUNT TEST"
*)
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

(** BLACK BOX TESTING SHAPES.ML OF THE SHAPES LIVE COUNT ******************)
(** The defined shapes must have proper shape. *)
let shapes_live_tests = [
  grid_live_count_test
    "squares have 4 live squares"
    4
    (square_block (fresh_grid 50 50 ()));
  grid_live_count_test
    "right gliders have 5 live squares"
    5 
    (right_glider (fresh_grid 50 50 ()) 10 10);
  grid_live_count_test
    "left gliders have 5 live squares"
    5 
    (left_glider (fresh_grid 50 50 ()) 10 10);
  grid_live_count_test
    "pulsars have 48 live squares"
    48
    (pulsar (fresh_grid 50 50 ()));
  grid_live_count_test
    "pentadecathlons have 12 live squares"
    12
    (penta (fresh_grid 50 50 ()));
  grid_live_count_test
    "LWSS have 9 live squares"
    9
    (l_spaceship (fresh_grid 50 50 ()));
  grid_live_count_test
    "lines have 3 live squares"
    3
    (line (fresh_grid 50 50 ()));
  grid_live_count_test 
    "stacks have 3 live squares"
    3
    (stack (fresh_grid 50 50 ()));
]


(** TEST GRID.ML ***************************************)
(** clicking a dead square will turn it alive, and vice versa. *)
let square_grid = 
  {
    x = 1;
    y = 1;
    squares : square array array = 
    [| [| {x = 0; y = 0; alive = true}|] |]
  }

let dead_square_grid = 
  {
    x = 1;
    y = 1;
    squares : square array array = 
    [| [| {x = 0; y = 0; alive = false}|] |]
  }

(*[generation_loop remaining_generations grid] returns a grid after [grid] has passed through [remaining_generations] generations *)
let rec generation_loop remaining_generations grid =
    match remaining_generations with
    | r when r <= 0 -> grid
    | _ ->
        let new_population = new_generation grid in
        generation_loop (remaining_generations - 1) new_population
  
(*[get_changed_grid] returns an updated grid when one square transitions from/to life*)
let get_changed_grid g x y = 
  change_grid g x y; g 

(*[click_loop click_lst grid] will toggle the squares in [grid] at the coordinates in [click_lst]*)
let rec click_loop click_lst grid = 
  match click_lst with 
  | [] -> grid 
  | (x, y) :: t -> (click_loop t (get_changed_grid grid x y))

(**[click_square_test] maintains that [final_grid] is equal to [final_grid] if you click a series of coordinates [(x, y)...]*)
let click_square_test (name : string) click_lst (init_grid : grid) (final_grid : grid) : test =
 name >:: fun _ -> assert_equal final_grid 
 (click_loop click_lst init_grid)

(**[random_single_click] generates a randomly placed click onto a randomly sized, empty grid. if the click is within bounds,
    then the number of lives will be one. otherwise, it will be false. *)

(**[random_multiple_clicks] generates a random number of random clicks, and clicks on a randomly sized, empty grid. 
    for every click that is within bounds of the grid, there is a live square. *)

(**[grow_random_grid] generates a randomly sized grid, clicks it at random.*)


let click_tests = [
  click_square_test 
  "clicking a dead toggles its alive-ness"
  [(0,0)]
  (fresh_grid 1 1 ())
  square_grid; 

  click_square_test 
  "clicking a live toggles its alive-ness"
  [(0,0)]
  square_grid
  (fresh_grid 1 1 ()); 

  click_square_test 
  "clicking a live toggles its alive-ness"
  [(0,0); (0,0)]
  dead_square_grid
  (fresh_grid 1 1 ()); 

  click_square_test
  "creating grid bread corner"
  [(3,3);(4,3);(3,4);(4,4)]
  (fresh_grid 5 5 ())
  grid_bread_corner; 

  click_square_test
  "creating a diagonal line"
  [(0,0); (1,1); (2,2)]
  (fresh_grid 3 3())
  grid_B
]

let state_tests = 
  next_generation_tests 
  @ future_generations_tests 
  @ live_count_tests 

let shapes_tests = 
  shapes_oscillate_tests
  @ shapes_live_tests

let tests = "test suite" >::: List.flatten [ state_tests; shapes_tests; click_tests]
let _ = run_test_tt_main tests