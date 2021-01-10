//start
draw_set_alpha(1);
draw_set_color(c_white);

//drawing the grid
draw_set_color(c_gray);
draw_set_alpha(0.40);
draw_grid(1,tile_size);
draw_set_alpha(1);

load_grid("main");

if (!surface_exists(door_surface)) {
	door_surface = surface_create(room_width,room_height);
		
	surface_set_target(door_surface);
	draw_clear_alpha(c_black,0);
	
	load_grid("door");
		
	surface_reset_target();
}
	
draw_surface(door_surface,0,0);

//drawing selected area
if (selecting_tile) {
	
	//resetting alpha
	if (selected_edge != old_selected_edge) {
		old_selected_edge = selected_edge;
		selected_edge_cur_alpha = 0;
		selected_edge_goal_alpha = 0.6;
	}
	
	draw_set_colour(c_white);
	
	var _top = tile_yy * tile_size - tile_size / 4;
	var _left = tile_xx * tile_size - tile_size / 4;
	var _w = tile_size * 1.5;
	var _h = tile_size * 1.5;
	
	if (selected_edge != dir.none) {
		
		
		draw_set_alpha(selected_edge_cur_alpha);
		
		if (selected_edge == dir.left) {
			draw_rectangle(_left,_top,_left + edge_size,_top + _h,false);
		}
		
		if (selected_edge == dir.right) {
			draw_rectangle(_left + _w - edge_size,_top,_left + _w,_top + _h,false);
		}
		
		if (selected_edge == dir.up) {
			draw_rectangle(_left,_top,_left + _w,_top + edge_size,false);
		}
		
		if (selected_edge == dir.down) {
			draw_rectangle(_left,_top + _h - edge_size,_left + _w,_top + _h,false);
		}
		
		remove_marker_goal_alpha = 0.15;
		if (choosing_tile_addition) remove_marker_goal_alpha = 0;
		draw_set_alpha(remove_marker_cur_alpha);
		draw_sprite(spr_exit_selection,0,_left + edge_size, _top + edge_size);
	}
	else {
		remove_marker_goal_alpha = 0.7;
		draw_set_alpha(remove_marker_cur_alpha);
		draw_sprite(spr_exit_selection,0,_left + edge_size, _top + edge_size);
	}
}

//end
draw_set_alpha(1);
draw_set_color(c_white);