//adjusting cursor sizes
if (cursor_mode == curs_mode.on_grid) {
	var tile = ds_grid_get(global.tile_grid, global.xx, global.yy);
	
	switch (obj_gameController.current_tool) {
		
		case tool.pen: {
			goal_x = global.xx * tile_size - global.cam_pos_x;
			goal_y = global.yy * tile_size - global.cam_pos_y;
		
			if (tile.main == ID.filled) {
				selection_box_h = tile_size + 8;
				selection_box_w = tile_size + 8;
			}
	
			if (tile.main == ID.empty || obj_gameController.placed_tile) {
				selection_box_h = tile_size - 4;
				selection_box_w = tile_size - 4;
			}
			
			break; }
	
		case tool.eyedropper: {
			goal_x = global.mouse_pos_x - tile_size / 2 + 5;
			goal_y = global.mouse_pos_y - tile_size / 2 - 5;
			selection_box_h = tile_size * 1.5;
			selection_box_w = tile_size * 1.5;
			
			break; }
			
		case tool.color_brush: {
			goal_x = global.xx * tile_size - global.cam_pos_x;
			goal_y = global.yy * tile_size - global.cam_pos_y;
		
			if (tile.main == ID.filled) {
				selection_box_h = tile_size - 4;
				selection_box_w = tile_size - 4;
			}
	
			if (tile.main == ID.empty) {
				selection_box_h = tile_size - 8;
				selection_box_w = tile_size - 8;
			}
			
			break; }
			
		case tool.door_tool: {
			if (!obj_gameController.adding_connection) { //position if not currently adding a connection
				goal_x = global.xx * tile_size - global.cam_pos_x;
				goal_y = global.yy * tile_size - global.cam_pos_y;
			}
		
			if (tile.main == ID.filled) {
				selection_box_h = tile_size + 8;
				selection_box_w = tile_size + 8;
			}
	
			if (tile.main == ID.empty && !obj_gameController.adding_connection) {
				selection_box_h = tile_size - 8;
				selection_box_w = tile_size - 8;
			}
			
			if (obj_gameController.adjust_cursor) { //adjusting cursor position and size
				if (obj_gameController.connection_xx2 != obj_gameController.connection_xx) {
					selection_box_w = tile_size * 2 + 8;
				}
				if (obj_gameController.connection_yy2 != obj_gameController.connection_yy) {
					selection_box_h = tile_size * 2 + 8;
				}
				
				var _new_x = obj_gameController.connection_xx + (obj_gameController.connection_xx2 - obj_gameController.connection_xx) / 2; //the middle between two tiles
				var _new_y = obj_gameController.connection_yy + (obj_gameController.connection_yy2 - obj_gameController.connection_yy) / 2; 
				
				goal_x = _new_x * tile_size - global.cam_pos_x; //adjusting position
				goal_y = _new_y * tile_size - global.cam_pos_y;
				
			} else if (obj_gameController.adding_connection) {
				goal_x = obj_gameController.connection_xx * tile_size - global.cam_pos_x;
				goal_y = obj_gameController.connection_yy * tile_size - global.cam_pos_y;
			}
			
			break; }
			
		case tool.marker_tool: {
			goal_x = global.xx * tile_size - global.cam_pos_x;
			goal_y = global.yy * tile_size - global.cam_pos_y;
		
			if (tile.main == ID.filled) {
				selection_box_h = tile_size - 4;
				selection_box_w = tile_size - 4;
			}
	
			if (tile.main == ID.empty) {
				selection_box_h = tile_size - 8;
				selection_box_w = tile_size - 8;
			}
			
			break; }
			
		case tool.hammer: {
			
			goal_x = global.xx * tile_size - global.cam_pos_x;
			goal_y = global.yy * tile_size - global.cam_pos_y;
		
			var _subimg = tile.subimg;
			
			if (_subimg == 10 || _subimg == 6 || _subimg == 5 || _subimg == 9 || _subimg == 12 || _subimg == 3 || _subimg >= 16) {
				selection_box_h = tile_size - 4;
				selection_box_w = tile_size - 4;
			} else {
				selection_box_h = tile_size - 8;
				selection_box_w = tile_size - 8;
			}
			
			break; }
	}
	
}

if (cursor_mode == curs_mode.off_anything) {
	
	goal_x = global.mouse_pos_x - tile_size / 2;
	cursor_x = goal_x;
	goal_y = global.mouse_pos_y - tile_size / 2;
	cursor_y = goal_y;
	selection_box_h = 4;
	selection_box_w = 4;
	
	//stopping connection editing
	obj_gameController.adding_connection = false;
}

if (cursor_mode == curs_mode.drag_to_move) {
	
	goal_x = global.mouse_pos_x - tile_size / 2;
	goal_y = global.mouse_pos_y - tile_size / 2;
	selection_box_h = 36;
	selection_box_w = 36;
	
}

if (cursor_mode == curs_mode.on_tileset) {
	
	goal_x = global.mouse_pos_x - tile_size / 2;
	goal_y = global.mouse_pos_y - tile_size / 2;
	selection_box_h = 4;
	selection_box_w = 4;
	
	var _selected = get_selected_marker(obj_gameController.tileset_x + 32, 64);
	var _pos_x = obj_gameController.tileset_x + 32;
	var _pos_y = 64 + 40 * _selected - (40 * obj_gameController.tiles_per_page * obj_gameController.tile_page)
	
	if (_selected != noone && point_in_rectangle(global.mouse_pos_x, global.mouse_pos_y, global.view_width - 96, 64, global.view_width, global.view_height - 64)) {
		
		goal_x = _pos_x;
		goal_y = _pos_y;
		selection_box_h = tile_size + 8;
		selection_box_w = tile_size + 8;
		
		if (obj_gameController.mLeftPressed) obj_gameController.selected_marker = _selected;
	}
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
	
if (obj_gameController.current_tool == tool.marker_tool	&& global.mouse_pos_x >= global.window_width - 96) {
	cursor_mode = curs_mode.on_tileset;
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
cursor_alpha = lerp(cursor_alpha, goal_cursor_alpha, 0.2)


//reaching goal subimg
icon_frame = lerp(icon_frame, goal_icon_frame, 0.2);