open Graphics

let pink = rgb 247 208 209
let light_blue = rgb 86 154 196

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

let rect_outline (c : color) x y w h line =
  set_line_width line;
  set_color c;
  draw_rect x y w h

let write_word (c : color) size x y word =
  moveto x y;
  set_color c;
  (* set_font ("-*-*-medium-r-*--" ^ string_of_int size ^
     "-*-*-*-*-*-iso8859-*"); *)
  draw_string word

let start_menu () = make_screen 1000 1000

let menu_draw () =
  set_background_color white;
  write_word black 50 470 700 "Game of Life";
  write_word black 40 425 630 "Start by Choosing Your Grid";
  write_word black 30 430 580 "Press 'e' to exit the game";

  rect_outline black 180 490 250 60 1;
  write_word black 50 285 510 "3 x 3";

  rect_outline black 180 390 250 60 1;
  write_word black 50 285 410 "5 x 5";

  rect_outline black 180 290 250 60 1;
  write_word black 50 280 310 "10 x 10";

  rect_outline black 580 490 250 60 1;
  write_word black 50 680 510 "20 x 20";

  rect_outline black 580 390 250 60 1;
  write_word black 50 680 410 "50 x 50";

  rect_outline black 580 290 250 60 1;
  write_word black 50 675 310 "100 x 100";

  rect_outline black 410 180 200 60 1;
  write_word black 50 495 200 "Rules";

  rect_outline black 385 100 250 60 1;
  write_word black 50 485 120 "Patterns"

let ocaml =
  [|
    (0, 600);
    (27, 622);
    (56, 653);
    (85, 706);
    (99, 743);
    (114, 765);
    (135, 784);
    (160, 797);
    (184, 800);
    (214, 792);
    (233, 774);
    (248, 748);
    (260, 720);
    (272, 690);
    (283, 656);
    (303, 627);
    (326, 639);
    (338, 677);
    (347, 725);
    (352, 763);
    (375, 797);
    (400, 800);
    (427, 791);
    (448, 769);
    (468, 742);
    (482, 713);
    (500, 676);
    (512, 648);
    (522, 615);
    (540, 581);
    (568, 559);
    (603, 532);
    (640, 517);
    (679, 513);
    (708, 559);
    (716, 619);
    (719, 668);
    (735, 693);
    (756, 714);
    (774, 729);
    (808, 729);
    (839, 736);
    (852, 717);
    (885, 708);
    (918, 708);
    (950, 699);
    (978, 671);
    (987, 638);
    (986, 613);
    (967, 592);
    (937, 602);
    (886, 590);
    (849, 596);
    (825, 582);
    (814, 532);
    (811, 483);
    (808, 438);
    (800, 400);
    (784, 369);
    (754, 350);
    (713, 331);
    (670, 324);
    (629, 319);
    (586, 316);
    (555, 314);
    (552, 272);
    (549, 232);
    (552, 196);
    (561, 146);
    (550, 115);
    (550, 79);
    (556, 29);
    (562, 0);
    (521, 0);
    (521, 15);
    (513, 54);
    (500, 100);
    (507, 139);
    (506, 169);
    (496, 223);
    (470, 276);
    (427, 311);
    (384, 300);
    (358, 269);
    (332, 232);
    (321, 205);
    (302, 177);
    (287, 131);
    (264, 95);
    (250, 39);
    (247, 0);
    (219, 0);
    (221, 35);
    (221, 82);
    (229, 115);
    (238, 140);
    (267, 184);
    (280, 227);
    (296, 260);
    (316, 291);
    (248, 292);
    (194, 315);
    (134, 339);
    (80, 385);
    (54, 370);
    (47, 323);
    (33, 283);
    (0, 240);
  |]

let pretty () =
  let orange = rgb 232 126 6 in
  let orange2 = rgb 239 122 11 in
  let orange3 = rgb 237 113 14 in
  let orange4 = rgb 236 107 18 in
  rect_block orange 0 0 1000 1000;
  rect_block orange2 0 0 1000 500;
  rect_block orange3 0 0 1000 250;
  rect_block orange4 0 0 1000 150;
  set_color white;
  fill_poly ocaml

let rec listen_menu () =
  let status = wait_next_event [ Button_down; Key_pressed ] in
  if button_down () then
    let x = status.mouse_x in
    let y = status.mouse_y in
    if x <= 430 && x >= 180 && y <= 550 && y >= 490 then 3
    else if x <= 430 && x >= 180 && y <= 450 && y >= 390 then 5
    else if x <= 430 && x >= 180 && y <= 350 && y >= 290 then 10
    else if x <= 870 && x >= 580 && y <= 550 && y >= 490 then 20
    else if x <= 870 && x >= 580 && y <= 450 && y >= 390 then 50
    else if x <= 870 && x >= 580 && y <= 350 && y >= 290 then 100
    else if x <= 610 && x >= 410 && y <= 240 && y >= 180 then 1
    else if x <= 635 && x >= 385 && y <= 160 && y >= 100 then 2
    else listen_menu ()
  else
    match status.key with
    | ' ' ->
        pretty ();
        Unix.sleepf 0.5;
        clear_graph ();
        menu_draw ();
        0
    | 'e' -> exit 0
    | _ -> listen_menu ()

let square_num () = listen_menu ()

let rec menu_switch () =
  let status = wait_next_event [ Key_pressed ] in
  match status.key with
  | 'e' -> exit 0
  | ' ' -> menu_draw ()
  | _ -> menu_switch ()

let rules_draw () =
  clear_graph ();
  write_word black 50 490 700 "Rules";
  write_word black 30 300 620
    "1. Any live cell with two or three live neighbours survives.";
  write_word black 30 300 540
    "2. Any dead cell with three live neighbours becomes a live cell.";
  write_word black 30 300 460
    "3. All other live cells die in the next generation.";
  write_word black 30 300 380
    "4. All other dead cells stay dead in the next generation.";
  write_word red 40 430 280 "Press 'e' to exit the game";
  write_word red 40 390 200 "Press 'space' to go back to the main menu";
  menu_switch ()

let glider () =
  rect_block yellow 150 600 30 30;
  rect_outline blue 150 600 30 30 3;
  rect_block yellow 210 600 30 30;
  rect_outline blue 210 600 30 30 3;
  rect_block yellow 210 630 30 30;
  rect_outline blue 210 630 30 30 3;
  rect_block yellow 210 570 30 30;
  rect_outline blue 210 570 30 30 3;
  rect_block yellow 180 570 30 30;
  rect_outline blue 180 570 30 30 3;
  write_word black 30 270 600 "glider"

let blinker () =
  rect_block yellow 180 500 30 30;
  rect_outline blue 180 500 30 30 3;
  rect_block yellow 180 470 30 30;
  rect_outline blue 180 470 30 30 3;
  rect_block yellow 180 440 30 30;
  rect_outline blue 180 440 30 30 3;
  write_word black 30 270 470 "blinker"

let toad () =
  (* top *)
  rect_block yellow 180 370 30 30;
  rect_outline blue 180 370 30 30 3;
  rect_block yellow 210 370 30 30;
  rect_outline blue 210 370 30 30 3;
  rect_block yellow 240 370 30 30;
  rect_outline blue 240 370 30 30 3;

  (* bottom *)
  rect_block yellow 150 340 30 30;
  rect_outline blue 150 340 30 30 3;
  rect_block yellow 180 340 30 30;
  rect_outline blue 180 340 30 30 3;
  rect_block yellow 210 340 30 30;
  rect_outline blue 210 340 30 30 3;
  write_word black 30 290 360 "toad"

let beacon () =
  (* left *)
  rect_block yellow 410 630 30 30;
  rect_outline blue 410 630 30 30 3;
  rect_block yellow 440 630 30 30;
  rect_outline blue 440 630 30 30 3;
  rect_block yellow 410 600 30 30;
  rect_outline blue 410 600 30 30 3;
  rect_block yellow 440 600 30 30;
  rect_outline blue 440 600 30 30 3;

  (* right *)
  rect_block yellow 470 570 30 30;
  rect_outline blue 470 570 30 30 3;
  rect_block yellow 500 570 30 30;
  rect_outline blue 500 570 30 30 3;
  rect_block yellow 470 540 30 30;
  rect_outline blue 470 540 30 30 3;
  rect_block yellow 500 540 30 30;
  rect_outline blue 500 540 30 30 3;
  write_word black 30 580 600 "beacon"

let light_spaceship () =
  (* first row *)
  rect_block yellow 470 440 30 30;
  rect_outline blue 470 440 30 30 3;
  rect_block yellow 500 440 30 30;
  rect_outline blue 500 440 30 30 3;

  (* second row *)
  rect_block yellow 410 410 30 30;
  rect_outline blue 410 410 30 30 3;
  rect_block yellow 440 410 30 30;
  rect_outline blue 440 410 30 30 3;
  rect_block yellow 500 410 30 30;
  rect_outline blue 500 410 30 30 3;
  rect_block yellow 530 410 30 30;
  rect_outline blue 530 410 30 30 3;

  (* third + fourth row *)
  rect_block yellow 410 380 30 30;
  rect_outline blue 410 380 30 30 3;
  rect_block yellow 440 380 30 30;
  rect_outline blue 440 380 30 30 3;
  rect_block yellow 470 380 30 30;
  rect_outline blue 470 380 30 30 3;
  rect_block yellow 500 380 30 30;
  rect_outline blue 500 380 30 30 3;

  rect_block yellow 440 350 30 30;
  rect_outline blue 440 350 30 30 3;
  rect_block yellow 470 350 30 30;
  rect_outline blue 470 350 30 30 3;

  write_word black 30 580 400 "light spaceship"

let block () =
  rect_block yellow 770 570 30 30;
  rect_outline blue 770 570 30 30 3;
  rect_block yellow 740 570 30 30;
  rect_outline blue 740 570 30 30 3;

  rect_block yellow 770 600 30 30;
  rect_outline blue 770 600 30 30 3;
  rect_block yellow 740 600 30 30;
  rect_outline blue 740 600 30 30 3;
  write_word black 30 820 600 "block"

let unnamed_1 () =
  rect_block pink 150 600 30 30;
  rect_outline light_blue 150 600 30 30 3;

  rect_block pink 180 630 30 30;
  rect_outline light_blue 180 630 30 30 3;

  rect_block pink 210 630 30 30;
  rect_outline light_blue 210 630 30 30 3;

  rect_block pink 240 630 30 30;
  rect_outline light_blue 240 630 30 30 3;

  rect_block pink 240 600 30 30;
  rect_outline light_blue 240 600 30 30 3;

  rect_block pink 210 570 30 30;
  rect_outline light_blue 210 570 30 30 3;

  rect_block pink 180 570 30 30;
  rect_outline light_blue 180 570 30 30 3;

  rect_outline light_blue 180 600 30 30 3;
  rect_outline light_blue 210 600 30 30 3;

  write_word black 30 290 610 "unnamed"

let unnamed_2 () =
  rect_block pink 180 500 30 30;
  rect_outline light_blue 180 500 30 30 3;

  rect_block pink 180 470 30 30;
  rect_outline light_blue 180 470 30 30 3;

  rect_block pink 210 500 30 30;
  rect_outline light_blue 210 500 30 30 3;

  rect_block pink 240 470 30 30;
  rect_outline light_blue 240 470 30 30 3;

  rect_block pink 210 440 30 30;
  rect_outline light_blue 210 440 30 30 3;

  write_word black 30 290 480 "unnamed"

let pentadecathlon () =
  (* first half *)
  rect_block pink 150 340 30 30;
  rect_outline light_blue 150 340 30 30 3;
  rect_block pink 180 340 30 30;
  rect_outline light_blue 180 340 30 30 3;
  rect_block pink 210 370 30 30;
  rect_outline light_blue 210 370 30 30 3;
  rect_block pink 210 310 30 30;
  rect_outline light_blue 210 310 30 30 3;
  rect_block pink 240 340 30 30;
  rect_outline light_blue 240 340 30 30 3;
  rect_block pink 270 340 30 30;
  rect_outline light_blue 270 340 30 30 3;

  (* second half *)
  rect_block pink 300 340 30 30;
  rect_outline light_blue 300 340 30 30 3;
  rect_block pink 330 340 30 30;
  rect_outline light_blue 330 340 30 30 3;
  rect_block pink 360 370 30 30;
  rect_outline light_blue 360 370 30 30 3;
  rect_block pink 360 310 30 30;
  rect_outline light_blue 360 310 30 30 3;
  rect_block pink 390 340 30 30;
  rect_outline light_blue 390 340 30 30 3;
  rect_block pink 420 340 30 30;
  rect_outline light_blue 420 340 30 30 3;

  write_word black 30 470 350 "pentadecathlon"

let figure_eight () =
  (* lower *)
  rect_block pink 420 470 30 30;
  rect_outline light_blue 420 470 30 30 3;
  rect_block pink 450 470 30 30;
  rect_outline light_blue 450 470 30 30 3;
  rect_block pink 390 470 30 30;
  rect_outline light_blue 390 470 30 30 3;

  rect_block pink 420 500 30 30;
  rect_outline light_blue 420 500 30 30 3;
  rect_block pink 450 500 30 30;
  rect_outline light_blue 450 500 30 30 3;
  rect_block pink 390 500 30 30;
  rect_outline light_blue 390 500 30 30 3;

  rect_block pink 420 530 30 30;
  rect_outline light_blue 420 530 30 30 3;
  rect_block pink 450 530 30 30;
  rect_outline light_blue 450 530 30 30 3;
  rect_block pink 390 530 30 30;
  rect_outline light_blue 390 530 30 30 3;

  (* upper *)
  rect_block pink 510 560 30 30;
  rect_outline light_blue 510 560 30 30 3;
  rect_block pink 540 560 30 30;
  rect_outline light_blue 540 560 30 30 3;
  rect_block pink 480 560 30 30;
  rect_outline light_blue 480 560 30 30 3;

  rect_block pink 510 590 30 30;
  rect_outline light_blue 510 590 30 30 3;
  rect_block pink 540 590 30 30;
  rect_outline light_blue 540 590 30 30 3;
  rect_block pink 480 590 30 30;
  rect_outline light_blue 480 590 30 30 3;

  rect_block pink 510 620 30 30;
  rect_outline light_blue 510 620 30 30 3;
  rect_block pink 540 620 30 30;
  rect_outline light_blue 540 620 30 30 3;
  rect_block pink 480 620 30 30;
  rect_outline light_blue 480 620 30 30 3;

  write_word black 30 510 510 "figure eight"

let acorn () =
  (* actual pattern *)
  rect_block pink 690 630 30 30;
  rect_outline light_blue 690 630 30 30 3;
  rect_block pink 690 600 30 30;
  rect_outline light_blue 690 600 30 30 3;
  rect_block pink 750 600 30 30;
  rect_outline light_blue 750 600 30 30 3;
  rect_block pink 720 540 30 30;
  rect_outline light_blue 720 540 30 30 3;
  rect_block pink 690 510 30 30;
  rect_outline light_blue 690 510 30 30 3;
  rect_block pink 690 480 30 30;
  rect_outline light_blue 690 480 30 30 3;
  rect_block pink 690 450 30 30;
  rect_outline light_blue 690 450 30 30 3;

  (* grid *)
  rect_outline light_blue 720 600 30 30 3;
  rect_outline light_blue 720 570 30 30 3;
  rect_outline light_blue 690 570 30 30 3;
  rect_outline light_blue 690 540 30 30 3;

  write_word black 30 810 555 "acorn"

let rec patterns_switch () =
  let status = wait_next_event [ Key_pressed ] in
  match status.key with
  | '\t' -> patterns2_draw ()
  | 'e' -> exit 0
  | ' ' -> menu_draw ()
  | _ -> patterns_switch ()

and patterns2_switch () =
  let status = wait_next_event [ Key_pressed ] in
  match status.key with
  | '\t' -> patterns_draw ()
  | 'e' -> exit 0
  | ' ' -> menu_draw ()
  | _ -> patterns2_switch ()

and patterns_draw () =
  clear_graph ();
  write_word black 50 480 700 "Patterns: Page 1";

  glider ();
  blinker ();
  toad ();
  beacon ();
  light_spaceship ();
  block ();

  write_word red 40 432 250 "Press 'tab' to turn page";
  write_word red 40 430 210 "Press 'e' to exit the game";
  write_word red 40 390 170 "Press 'space' to go back to the main menu";
  patterns_switch ()

and patterns2_draw () =
  clear_graph ();
  write_word black 50 480 700 "Patterns: Page 2";

  unnamed_1 ();
  unnamed_2 ();
  pentadecathlon ();
  figure_eight ();
  acorn ();

  write_word red 40 432 250 "Press 'tab' to turn page";
  write_word red 40 430 210 "Press 'e' to exit the game";
  write_word red 40 390 170 "Press 'space' to go back to the main menu";
  patterns2_switch ()
