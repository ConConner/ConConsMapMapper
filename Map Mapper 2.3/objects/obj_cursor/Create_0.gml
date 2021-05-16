image_speed = 0;
image_alpha = 0;

goal_x = 0; //goal X position
goal_y = 0;	//goal Y position
cursor_x = 0;	//current X position
cursor_y = 0;	//current Y position

selection_box_w = 0;	//size of the selection box
selection_box_h = 0;	//

goal_selection_h = selection_box_h / 2;	//real size of selection box, goal
goal_selection_w = selection_box_w / 2; //
current_selection_w = selection_box_w / 2;	//real size of selection box, current
current_selection_h = selection_box_h / 2;	//

goal_icon_alpha = 0;	//goal alpha of the icon in the middle
icon_alpha = 0;	//current alpha opf the icon in the middle

goal_cursor_alpha = 1;
cursor_alpha = 0;

over_button = false;

goal_icon_frame = 0; //goal of the icon subimage
icon_frame = 0;
icon_sprite = spr_cursor_middle;

cursor_mode = curs_mode.on_grid;

enum curs_mode {
	on_grid,
	on_menu,
	on_tileset,
	on_button,
	off_anything,
	drag_to_move,
}