//start
draw_set_alpha(1);
draw_set_color(c_white);

//drawing the grid
if (show_grid) {
	draw_set_color(c_gray);
	draw_set_alpha(0.4);
	draw_grid(global.grid_width * tile_size, global.grid_height * tile_size, 1, tile_size);
	draw_set_alpha(1);
	draw_grid_outline(global.grid_width * tile_size, global.grid_height * tile_size, 1);
}
else {
	draw_set_color(c_gray);
	draw_set_alpha(0.4);
	draw_grid_outline(global.grid_width * tile_size, global.grid_height * tile_size, 1);
}
draw_set_alpha(1);

#region drawing graphics for grid resize
//getting vars
var _x = global.cam_pos_x;
var _y = global.cam_pos_y;
var _w = sprite_get_width(spr_size_edit);
var _h = sprite_get_height(spr_size_edit);
var _grid_width = global.grid_width * tile_size;
var _grid_height = global.grid_height * tile_size;
#macro offset 32

//drawing + and - sprites
draw_sprite(spr_size_edit, 0, global.window_width / 2 - _w / 2, -_y - tile_size - offset); //up
draw_sprite(spr_size_edit, 1, global.window_width / 2 + _w / 2, -_y - tile_size - offset);

draw_sprite(spr_size_edit, 0, -_x - tile_size - offset, global.window_height / 2 - _h / 2); //left
draw_sprite(spr_size_edit, 1, -_x - tile_size - offset, global.window_height / 2 + _h / 2);

draw_sprite(spr_size_edit, 0, global.window_width / 2 - _w / 2, -_y + _grid_height + offset); //down
draw_sprite(spr_size_edit, 1, global.window_width / 2 + _w / 2, -_y + _grid_height + offset);

draw_sprite(spr_size_edit, 0, -_x + _grid_width + offset, global.window_height / 2 - _h / 2); //right
draw_sprite(spr_size_edit, 1, -_x + _grid_width + offset, global.window_height / 2 + _h / 2);

#region button pos
resize_neg_up_button.goal_x = global.window_width / 2 - _w / 2;
resize_neg_up_button.goal_y = -_y - tile_size - offset;
resize_neg_up_button.jmp();
resize_pos_up_button.goal_x = global.window_width / 2 + _w / 2;
resize_pos_up_button.goal_y = -_y - tile_size - offset;
resize_pos_up_button.jmp();

resize_neg_left_button.goal_x = -_x - tile_size - offset;
resize_neg_left_button.goal_y = global.window_height / 2 - _h / 2;
resize_neg_left_button.jmp();
resize_pos_left_button.goal_x = -_x - tile_size - offset;
resize_pos_left_button.goal_y = global.window_height / 2 + _h / 2;
resize_pos_left_button.jmp();

resize_neg_down_button.goal_x = global.window_width / 2 - _w / 2;
resize_neg_down_button.goal_y = -_y + _grid_height + offset;
resize_neg_down_button.jmp();
resize_pos_down_button.goal_x = global.window_width / 2 + _w / 2;
resize_pos_down_button.goal_y = -_y + _grid_height + offset;
resize_pos_down_button.jmp();

resize_neg_right_button.goal_x = -_x + _grid_width + offset;
resize_neg_right_button.goal_y = global.window_height / 2 - _h / 2;
resize_neg_right_button.jmp();
resize_pos_right_button.goal_x = -_x + _grid_width + offset;
resize_pos_right_button.goal_y = global.window_height / 2 + _h / 2;
resize_pos_right_button.jmp();
#endregion

#endregion

function take_screenshot(_file) {
	
	//checking valid file
	if (check_valid_dir(_file, "Image export")) {
	
		//setting up the surface
		var temp_surf = surface_create(global.grid_view_width, global.grid_view_height);
		surface_set_target(temp_surf);
		draw_clear_alpha(c_black, 0);
	
		//drawing the contents
		if (show_grid) {
			draw_rectangle_color(0, 0, global.grid_view_width, global.grid_view_height, c_black, c_black, c_black, c_black, false);
			draw_set_alpha(0.4);
			draw_grid_whole(global.grid_width * tile_size, global.grid_height * tile_size, 1, tile_size);
		}	
	
		draw_set_alpha(1);
		load_grid(0, 0, global.grid_width * tile_size, global.grid_height * tile_size, true); //Draw everything
	
		//saving screenshot
		surface_save(temp_surf, _file);
	
		surface_reset_target();
		surface_free(temp_surf);
		
		//confirmation message
		add_text_message("map exported successfully", 3, c_lime);
	
	}
}


draw_set_color(c_white);
load_grid(global.cam_pos_x, global.cam_pos_y, global.grid_view_width, global.grid_view_height);

//end
draw_set_alpha(1);
draw_set_color(c_white);