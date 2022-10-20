open Graphics

type square =
  | Alive
  | Dead

type grid = {
  x : int;
  y : int;
  squares : square array array;
}

(** [print_x_y x y] prints 'x AND y'; for debugging math*)
let print_x_y x y =
  print_int x;
  print_string " AND ";
  print_int y;
  print_newline ()

let make_grid m n =
  { y = m; x = n; squares = Array.make m (Array.make n Alive) }

let flip_square s =
  match s with
  | Alive -> Dead
  | Dead -> Alive

let change_grid grid m n =
  let array = Array.copy (Array.get grid.squares m) in
  array.(n) <- flip_square (Array.get (Array.get grid.squares m) n);
  grid.squares.(m) <- array

let draw_square y x square grid =
  draw_rect (x + 5) (y + 5) ((1000 / grid.y) - 5) ((1000 / grid.x) - 5);
  if square = Alive then set_color white else set_color black;
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

let click_square y x grid =
  print_x_y (y * grid.y / 1000) (x * grid.y / 1000);
  change_grid grid (y * grid.y / 1000) (x * grid.x / 1000)

let rec listen_square grid =
  let status = wait_next_event [ Button_up; Key_pressed ] in
  if button_down () then (
    let x, y = mouse_pos () in
    print_x_y x y;
    if x < 1000 && y < 1000 then (
      click_square y x grid;
      update_grid grid;
      (* Unix.sleep 1; *)
      listen_square grid)
    else (* Unix.sleep 1; *)
      listen_square grid)
  else if key_pressed () then
    match read_key () with
    | ' ' ->
        print_string "PRESSED EXIT";
        exit 0
    | _ ->
        (* Unix.sleep 1; *)
        listen_square grid
  else Unix.sleep 1;
  print_string "HERE NOTHING HAPPENED";
  listen_square grid
