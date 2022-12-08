open Graphics
open State

type shape = grid -> int -> int -> unit

let validate x y grid = x < grid.x && y < grid.y && x >= 0 && y >= 0

let set_square grid n m =
  if validate m n grid then
    grid.squares.(m).(n) <- { x = n; y = m; alive = true };
  ()

(* Some shape definitions *)

(* Statics *)
(* Square block *)
let square_block grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid x (y + 1);
  set_square grid (x + 1) (y + 1)

(* Moving *)
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

(* Lightweight spaceship (left) *)
let l_spaceship grid x y =
  set_square grid x y;
  set_square grid (x + 3) y;
  set_square grid (x + 4) (y + 1);
  set_square grid (x + 4) (y + 2);
  set_square grid (x + 4) (y + 3);
  set_square grid x (y + 2);
  set_square grid (x + 1) (y + 3);
  set_square grid (x + 2) (y + 3);
  set_square grid (x + 3) (y + 3)

(* Periodic *)
(* Penta decathlon *)
let penta grid x y =
  set_square grid x y;
  set_square grid x (y + 1);
  set_square grid (x + 1) (y + 2);
  set_square grid (x - 1) (y + 2);
  set_square grid x (y + 3);
  set_square grid x (y + 4);
  set_square grid x (y + 5);
  set_square grid x (y + 6);
  set_square grid (x + 1) (y + 7);
  set_square grid (x - 1) (y + 7);
  set_square grid x (y + 8);
  set_square grid x (y + 9)

(* 3-line *)
let line grid x y =
  set_square grid x y;
  set_square grid (x + 1) y;
  set_square grid (x + 2) y

(* 3-stack *)
let stack grid x y =
  set_square grid x y;
  set_square grid x (y + 1);
  set_square grid x (y + 2)

(* Pulsar *)
let pulsar grid x y =
  line grid (x + 2) (y + 1);
  line grid (x - 4) (y + 1);
  line grid (x - 4) (y - 1);
  line grid (x + 2) (y - 1);
  line grid (x + 2) (y + 6);
  line grid (x - 4) (y + 6);
  line grid (x - 4) (y - 6);
  line grid (x + 2) (y - 6);

  stack grid (x + 1) (y + 2);
  stack grid (x - 1) (y + 2);
  stack grid (x + 6) (y + 2);
  stack grid (x - 6) (y + 2);
  stack grid (x + 1) (y - 4);
  stack grid (x - 1) (y - 4);
  stack grid (x + 6) (y - 4);
  stack grid (x - 6) (y - 4)

(* Special *)
(* Gosper Glider Gun *)
let gun grid x y =
  square_block grid x (y - 1);

  stack grid (x + 10) (y - 2);
  set_square grid (x + 11) (y - 3);
  set_square grid (x + 11) (y + 1);
  set_square grid (x + 12) (y - 4);
  set_square grid (x + 13) (y - 4);
  set_square grid (x + 12) (y + 2);
  set_square grid (x + 13) (y + 2);
  set_square grid (x + 14) (y - 1);
  set_square grid (x + 15) (y - 3);
  set_square grid (x + 15) (y + 1);
  stack grid (x + 16) (y - 2);
  set_square grid (x + 17) (y - 1);

  stack grid (x + 20) y;
  stack grid (x + 21) y;
  set_square grid (x + 22) (y - 1);
  set_square grid (x + 22) (y + 3);
  set_square grid (x + 24) (y - 1);
  set_square grid (x + 24) (y + 3);
  set_square grid (x + 24) (y - 2);
  set_square grid (x + 24) (y + 4);

  square_block grid (x + 34) (y + 1)
