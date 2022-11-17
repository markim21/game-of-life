open Game
open Game.Grid
open Game.Menu

let () =
  let n = 10 in
  let grid = make_grid n n in
  init_grid grid;
  Unix.sleep 1;
  auto_listen_square false grid
