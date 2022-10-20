open Graphics
open State

(** [print_x_y x y] prints 'x AND y'; for debugging math*)
let print_x_y x y =
  print_int x;
  print_string " AND ";
  print_int y;
  print_newline ()

let make_new_matrix m n =
  let array = Array.make m (Array.make n { x = 0; y = 0; alive = true }) in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      (Array.get array i).(j) <- { x = j; y = i; alive = true }
    done
  done;
  array

let make_grid m n = { y = m; x = n; squares = make_new_matrix m n }
let flip_square s = { s with alive = s.alive <> true }

let change_grid grid m n =
  let array = Array.copy (Array.get grid.squares m) in
  array.(n) <- flip_square (Array.get (Array.get grid.squares m) n);
  grid.squares.(m) <- array

let draw_square y x square grid =
  draw_rect (x + 5) (y + 5) ((1000 / grid.y) - 5) ((1000 / grid.x) - 5);
  if square.alive then set_color white else set_color black;
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
  change_grid grid (y * grid.y / 1000) (x * grid.x / 1000)

let rec listen_square grid =
  loop_at_exit [ Button_down; Key_pressed ] (fun status ->
      if button_down () then
        let x, y = mouse_pos () in
        if x < 1000 && y < 1000 then (
          click_square y x grid;
          update_grid grid;
          listen_square grid)
        else listen_square grid
      else
        match status.key with
        | 'e' -> raise Exit
        | _ -> listen_square grid)
