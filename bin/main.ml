open Game
open Game.Grid
open Game.Menu

let () =
  menu_draw;
  let n = listen_menu () in
  let grid = make_grid n n in
  Graphics.close_graph ();

  init_grid grid;
  Unix.sleep 1;
  auto_listen_square false grid
