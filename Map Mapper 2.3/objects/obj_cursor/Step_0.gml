//adjusting cursor sizes
if (obj_gameController.canBuild) {
	goal_x = global.xx * tile_size;
	goal_y = global.yy * tile_size;
		
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

if (!obj_gameController.canBuild) {
	
	goal_x = mouse_x - tile_size / 2;
	goal_y = mouse_y - tile_size / 2;
	selection_box_h = 4;
	selection_box_w = 4;
	
}

//buttons
if (mouse_hovering_over_object(obj_button)) {
	var _button = instance_place(mouse_x,mouse_y,obj_button)
		
	selection_box_w = _button.sprite_width + 8;
	selection_box_h = _button.sprite_height + 8;
		
	goal_x = _button.x + _button.sprite_width / 2 - tile_size / 2;
	goal_y = _button.y + _button.sprite_height / 2 - tile_size / 2;
	
	over_button = true;
} else over_button = false;

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