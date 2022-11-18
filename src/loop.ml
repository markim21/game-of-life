open State
open Graphics
open Grid 

let step grid =
  let new_grid = new_generation grid in
  for i = 0 to grid.y - 1 do
    let temp = Array.make grid.x { x = 0; y = 0; alive = false } in
    for j = 0 to grid.x - 1 do
      temp.(j) <-
        {
          x = j;
          y = i;
          alive = (Array.get (Array.get new_grid.squares i) j).alive;
        }
    done;
    grid.squares.(i) <- temp
  done;
  update_grid grid

let loop_generations grid = 
  loop_at_exit [ Key_pressed ] (fun status -> 
    match status.key with 
    | ' ' -> raise Exit 
    | _ -> Unix.sleep 1; step grid)

