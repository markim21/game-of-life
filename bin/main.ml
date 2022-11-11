open Game
open Game.Grid
open Game.Menu

let () =
  menu_draw;
  let n = square_num in
  if n = 1 then rules_draw ();
  let grid = make_grid n n in
  Graphics.close_graph ();
  init_grid grid;
  Unix.sleep 1;
  listen_square grid
