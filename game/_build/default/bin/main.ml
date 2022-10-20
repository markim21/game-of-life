open Game
open Game.Grid

let _ =
  let grid = make_grid 20 20 in
  init_grid grid;
  Unix.sleep 1;
  listen_square grid
