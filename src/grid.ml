open Graphics
open State
open Shapes

(** [print_x_y x y] prints 'x AND y'; for debugging math*)
let print_x_y x y =
  print_int x;
  print_string " AND ";
  print_int y;
  print_newline ()

(**[make_new_matrix m n] returns a square array array
    with [m] x [n] dimensions. each square is initialized to be dead. *)
let make_new_matrix m n =
  let array = Array.make m (Array.make n { x = 0; y = 0; alive = false }) in
  for i = 0 to m - 1 do
    let temp = Array.make n { x = 0; y = 0; alive = false } in
    for j = 0 to n - 1 do
      temp.(j) <- { x = j; y = i; alive = false }
    done;
    array.(i) <- temp
  done;
  array

let make_grid m n = { y = m; x = n; squares = make_new_matrix m n }

(**[flip_square s] toggles the alive status of square [s]. 
    if s.alive = true, change to false, and vice versa. *)
let flip_square s = { s with alive = s.alive <> true }

let change_grid grid m n =
  let array = Array.copy (Array.get grid.squares m) in
  array.(n) <- flip_square (Array.get (Array.get grid.squares m) n);
  grid.squares.(m) <- array

let draw_square y x square grid =
  draw_rect (x + 5) (y + 5) ((1000 / grid.y) - 5) ((1000 / grid.x) - 5);
  if square.alive then set_color black else set_color white;
  fill_rect (x + 5) (y + 5) ((1000 / grid.y) - 5) ((1000 / grid.x) - 5)

let update_grid grid =
  for i = 0 to grid.y - 1 do
    for j = 0 to grid.x - 1 do
      draw_square
        (1000 / grid.y * i)
        (1000 / grid.x * j)
        (Array.get (Array.get grid.squares i) j)
        grid
    done
  done

let init_grid grid =
  open_graph " 1000x1000";
  set_window_title "Game of Life";
  set_color (rgb 189 189 191);
  fill_rect 0 0 1000 1000;
  update_grid grid

(**[click_square y x grid] ensures the mouse coordinates [x] and [y] are 
    within dimensions of the grid before it attempts to change_grid *)
let click_square y x grid =
  change_grid grid (y * grid.y / 1000) (x * grid.x / 1000)

(**[shape_action grid x y shape] adds [shape] to [grid], updates [grid] and
    the screen, and returns to the game loop.*)
let rec shape_action grid x y shape =
  shape grid (x * grid.x / 1000) (y * grid.y / 1000);
  update_grid grid;
  listen_square grid

and listen_square grid =
  let status = wait_next_event [ Button_down; Key_pressed ] in
  let x = status.mouse_x in
  let y = status.mouse_y in

  if button_down () then
    if x < 1000 && y < 1000 then (
      click_square y x grid;
      update_grid grid;
      listen_square grid)
    else listen_square grid
  else
    match status.key with
    | 'a' -> grid
    | '1' -> shape_action grid x y square_block
    | '2' -> shape_action grid x y right_glider
    | '3' -> shape_action grid x y left_glider
    | '4' -> shape_action grid x y l_spaceship
    | '5' -> shape_action grid x y penta
    | '6' -> shape_action grid x y pulsar
    | '7' -> shape_action grid x y stack
    | '8' -> shape_action grid x y line
    | '9' -> shape_action grid x y gun
    | _ -> listen_square grid
