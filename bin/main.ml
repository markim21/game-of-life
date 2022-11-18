open Game
open Game.Grid
open Game.Menu

let n = ref 0

let () =
  start_menu ();
  menu_draw ();
  n := square_num ();
  while !n = 1 || !n = 2 || !n = 0 do
    if !n = 1 then rules_draw ();
    if !n = 2 then patterns_draw ();
    n := square_num ()
  done;
  let grid = make_grid !n !n in
  Graphics.close_graph ();
  init_grid grid;
  Unix.sleep 1;
  listen_square grid
