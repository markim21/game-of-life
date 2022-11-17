open Graphics
open State

(** [print_x_y x y] prints 'x AND y'; for debugging math*)
let print_x_y x y =
  print_int x;
  print_string " AND ";
  print_int y;
  print_newline ()

let make_new_matrix m n =
  (* Probably somewhat inefficient*)
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

let click_square y x grid =
  change_grid grid (y * grid.y / 1000) (x * grid.x / 1000)

let step grid =
  let new_grid = new_generation grid in
    for i = 0 to grid.y - 1 do
      let temp = Array.make grid.x { x = 0; y = 0; alive = false } in
      for j = 0 to grid.x - 1 do
        temp.(j) <-
          {
            x = j;
            y = i;
            alive = (Array.get (Array.get new_grid.squares i) j).alive;
          }
      done;
      grid.squares.(i) <- temp
    done;
    update_grid grid

(* 
  if button_down, then click and update grid. 
  else, 
   if status.key = ' ' , then toggle loop. 
   if status.key = '+' then increase step speed. 
   if status.key = '-' then decrease step speed. otherwise, 
    if [loop] is true, then step grid 
    if [loop] is false, listen_square grid *)

let validate_coords x y = 
  if (x < 1000 && y < 1000) then true else false 

let click_action x y grid = 
  click_square y x grid;
  update_grid grid

let toggle_loop loop = 
  if loop then false else true 

let rec auto_listen_square loop grid = 
  loop_at_exit[Button_down; Key_pressed] 
  (fun status -> 
    if button_down () then 
      let x, y = mouse_pos () in 
        if validate_coords x y then click_action x y grid 
        else auto_listen_square loop grid 
    else 
      match status.key with 
      |' ' -> auto_listen_square (toggle_loop loop) grid
      | _ -> 
        if loop then step grid else auto_listen_square loop grid 
    )

(*let rec listen_square grid =
  loop_at_exit [ Button_down; Key_pressed ] (fun status ->
      if button_down () then
        let x, y = mouse_pos () in
        if x < 1000 && y < 1000 then (
          click_square y x grid;
          update_grid grid)
        else listen_square grid
      else
        match status.key with
        | ' ' -> step grid
        | _ -> listen_square grid)*)
