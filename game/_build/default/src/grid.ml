open Graphics

type square =
  | Alive
  | Dead

type grid = {
  x : int;
  y : int;
  squares : square array array;
}

let make_grid m n =
  { y = m; x = n; squares = Array.make m (Array.make n Alive) }

let flip_square s =
  match s with
  | Alive -> Dead
  | Dead -> Alive

let change_grid grid m n =
  let array = Array.copy (Array.get grid.squares m) in
  array.(n) <- flip_square (Array.get (Array.get grid.squares m) n);
  grid.squares.(m) <- array

let draw_square y x square grid =
  draw_rect (x + 5) (y + 5) ((1000 / grid.y) - 5) ((1000 / grid.x) - 5);
  if square = Alive then set_color white else set_color black;
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

let click_square = None