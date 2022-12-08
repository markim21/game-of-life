open Graphics
open State

type shape = grid -> int -> int -> unit

let validate x y grid = x < grid.x && y < grid.y && x >= 0 && y >= 0

let set_square grid n m =
  if validate m n grid then
    grid.squares.(m).(n) <- { x = n; y = m; alive = true };
  ()

(* Some shape definitions *)

(* Square block *)
let square_block grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid x (y + 1);
  set_square grid (x + 1) (y + 1)

(* Glider going right *)
let right_glider grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid (x + 2) y;
  set_square grid (x + 2) (y + 1);
  set_square grid (x + 1) (y + 2)

(* Glider going left *)
let left_glider grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid (x + 2) y;
  set_square grid x (y + 1);
  set_square grid (x + 1) (y + 2)
