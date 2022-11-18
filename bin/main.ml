open Game
open Game.Grid
open Game.Menu
open Game.Loop

let () =
  menu_draw;
  let n = listen_menu () in
  Graphics.close_graph ();
  let grid = make_grid n n in
  init_grid grid;
  Unix.sleep 1;
  let start_grid = listen_square grid in 
  Graphics.close_graph ();
  print_string "success";
  init_grid start_grid;
  loop_generations start_grid


