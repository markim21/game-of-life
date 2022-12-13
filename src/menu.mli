val start_menu : unit -> unit
(** [start_menu ()] creats a new game screen with size 1000x1000. *)

val menu_draw : unit -> unit
(** [menu_draw ()] draws the starting menu, including buttons for grids,
    patterns, and rules. *)

val square_num : unit -> int
(** [square_num ()] is an integer created when a button is clicked by the user,
    each button is mapped to a different interger. *)

val rules_draw : unit -> unit
(** [menu_draw ()] draws the rules page and initialize interactive features.

    - pressing 'e' exits the game
    - pressing 'space' goes back to the start menu. *)

val patterns_draw : unit -> unit
(** [patterns_draw ()] draws the patterns page and initialize interactive
    features.

    - pressing 'tab' switches between the two pages.
    - pressing 'e' exits the game.
    - pressing 'space' goes back to the start menu. *)
