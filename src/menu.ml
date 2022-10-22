open Graphics

let make_screen (width : int) (height : int) =
  let size = " " ^ string_of_int width ^ "x" ^ string_of_int height in
  open_graph size;
  set_window_title "Game of Life"

let set_background_color (c : color) =
  set_color c;
  fill_rect 0 0 (size_x ()) (size_y ())

let rect_block (c : color) x y w h =
  set_color c;
  fill_rect x y w h

let rect_outline (c : color) x y w h =
  set_color c;
  draw_rect x y w h

let write_word (c : color) size x y word =
  moveto x y;
  set_color c;
  set_font ("-*-*-medium-r-*--" ^ string_of_int size ^ "-*-*-*-*-*-iso8859-*");
  draw_string word

let start_menu = make_screen 1000 1000

let menu_draw =
  set_background_color white;
  write_word black 50 360 700 "Game of Life";
  write_word black 40 250 620 "Start by Choosing Your Grid";

  rect_outline black 180 490 250 60;
  write_word black 50 245 495 "3 x 3";

  rect_outline black 180 390 250 60;
  write_word black 50 245 395 "5 x 5";

  rect_outline black 180 290 250 60;
  write_word black 50 220 295 "10 x 10";

  rect_outline black 580 490 250 60;
  write_word black 50 620 495 "20 x 20";

  rect_outline black 580 390 250 60;
  write_word black 50 620 395 "50 x 50";

  rect_outline black 580 290 250 60;
  write_word black 50 600 295 "100 x 100"

let rec listen_menu () =
  let status = wait_next_event [ Button_down ] in
  let x = status.mouse_x in
  let y = status.mouse_y in
  if x <= 430 && x >= 180 && y <= 550 && y >= 490 then 3
  else if x <= 430 && x >= 180 && y <= 450 && y >= 390 then 5
  else if x <= 430 && x >= 180 && y <= 350 && y >= 290 then 10
  else if x <= 870 && x >= 580 && y <= 550 && y >= 490 then 20
  else if x <= 870 && x >= 580 && y <= 450 && y >= 390 then 50
  else if x <= 870 && x >= 580 && y <= 350 && y >= 290 then 100
  else listen_menu ()

let square_num = listen_menu ()