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
		load_grid_whole();
	
		//saving screenshot
		surface_save(temp_surf, _file);
	
		surface_reset_target();
		surface_free(temp_surf);
		
		//confirmation message
		add_text_message("map exported successfully", 3, c_lime);
	
	}
}


draw_set_color(c_white);
load_grid();

//end
draw_set_alpha(1);
draw_set_color(c_white);