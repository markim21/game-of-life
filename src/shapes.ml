open Graphics
open State

let set_square s = { s with alive = true }
let validate x y grid = x < grid.x && y < grid.y && x >= 0 && y >= 0

let set_square grid m n =
  if validate m n grid then
    grid.squares.(n).(m) <- set_square (Array.get (Array.get grid.squares m) n);
  ()

(* Some shape definitions *)

(* Square block *)
let square_block grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid x (y + 1);
  set_square grid (x + 1) (y + 1)
