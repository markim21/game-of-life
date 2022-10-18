open Graphics

let make_screen (width : int) (height : int) =
  let size = " " ^ string_of_int width ^ "x" ^ string_of_int height in
  open_graph size;
  set_window_title "Game of Life"

let set_background_color (c : color) =
  let current_color = foreground in
  set_color c;
  fill_rect 0 0 (size_x ()) (size_y ());
  set_color current_color

let rect_block (c : color) w h x y =
  let current_color = foreground in
  set_color c;
  fill_rect w h x y;
  set_color current_color

let rect_outline (c : color) w h x y =
  let current_color = foreground in
  set_color c;
  draw_rect w h x y;
  set_color current_color

let write_word (c : color) size x y word =
  let current_color = foreground in
  moveto x y;
  set_color c;
  set_font
    ("-*-fixed-medium-r-semicondensed--" ^ string_of_int size
   ^ "-*-*-*-*-*-iso8859-1");
  draw_string word;
  set_color current_color

let start_menu =
  make_screen 1000 1000;
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
  write_word black 50 600 295 "100 x 100";

  Unix.sleep 100
