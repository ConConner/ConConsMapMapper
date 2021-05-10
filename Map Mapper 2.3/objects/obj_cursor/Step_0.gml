//adjusting cursor sizes
if (cursor_mode == curs_mode.on_grid) {
	goal_x = global.xx * tile_size - global.cam_pos_x;
	goal_y = global.yy * tile_size - global.cam_pos_y;
		
	var tile = ds_grid_get(global.tile_grid, global.xx, global.yy);
	if (tile.main == ID.filled) {
		selection_box_h = tile_size + 8;
		selection_box_w = tile_size + 8;
	}
	
	if (tile.main == ID.empty || obj_gameController.placed_tile) {
		selection_box_h = tile_size - 4;
		selection_box_w = tile_size - 4;
	}
}

if (cursor_mode == curs_mode.off_anything) {
	
	goal_x = mouse_x - tile_size / 2;
	goal_y = mouse_y - tile_size / 2;
	selection_box_h = 4;
	selection_box_w = 4;
	
}

if (cursor_mode == curs_mode.drag_to_move) {
	
	goal_x = mouse_x - tile_size / 2;
	goal_y = mouse_y - tile_size / 2;
	selection_box_h = 36;
	selection_box_w = 36;
	
}


//setting cursor mode
if ((obj_gameController.real_xx != global.xx && abs(obj_gameController.real_xx - global.xx) > 1) || (obj_gameController.real_yy != global.yy && abs(obj_gameController.real_yy - global.yy) > 1)) {
	cursor_mode = curs_mode.off_anything;
} else {
	cursor_mode = curs_mode.on_grid;
}

if (obj_gameController.in_menu) {
	cursor_mode = curs_mode.off_anything;
}

if (obj_gameController.moving_with_mouse) {
	cursor_mode = curs_mode.drag_to_move;
}


//buttons
var button_id = button_check();
if (button_id != 0) {
	
	if (button_id.active && button_id.button_enabled) {
		cursor_mode = curs_mode.on_button;
		
		selection_box_w = button_id.button_width + 8;
		selection_box_h = button_id.button_height + 8;
		goal_x = button_id.x + button_id.button_width / 2 - tile_size / 2;
		goal_y = button_id.y + button_id.button_height / 2 - tile_size / 2;
	}
}


//setting selection positions
goal_selection_h = selection_box_h / 2;
goal_selection_w = selection_box_w / 2;

//reaching goal pos
cursor_x = lerp(cursor_x, goal_x, 0.4);
cursor_y = lerp(cursor_y, goal_y, 0.4);

x = cursor_x + tile_size / 2;
y = cursor_y + tile_size / 2;


//reaching goal selection
current_selection_w = lerp(current_selection_w , goal_selection_w, 0.2);
current_selection_h = lerp(current_selection_h , goal_selection_h, 0.2);


//reaching goal alpha
icon_alpha = lerp(icon_alpha, goal_icon_alpha, 0.2);


//reaching goal subimg
icon_frame = lerp(icon_frame, goal_icon_frame, 0.2);