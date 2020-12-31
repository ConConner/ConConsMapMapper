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