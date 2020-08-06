//drawing the grid
draw_set_color(c_gray);
draw_set_alpha(0.40);
draw_grid(1,32);
draw_set_alpha(1);

if (!surface_exists(map_surface)) {
	map_surface = surface_create(800,800);
	
	surface_set_target(map_surface);
	draw_clear_alpha(c_black,0);
	load_grid();
	load_marker_grid(global.MarkerGrid);
	surface_reset_target();
}

draw_surface(map_surface,0,0);
