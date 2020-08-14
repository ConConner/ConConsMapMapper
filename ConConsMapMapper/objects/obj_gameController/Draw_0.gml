//drawing the grid
draw_set_color(c_gray);
draw_set_alpha(0.40);
draw_grid(1,32);
draw_set_alpha(1);

if (!surface_exists(main_surface)) {
	main_surface = surface_create(view_width,view_height);
	
	surface_set_target(main_surface);
	draw_clear_alpha(c_black,0);
	
	load_grid("main");
	
	surface_reset_target();
}

draw_surface(main_surface,viewX,viewY);

if (!surface_exists(door_surface)) {
	door_surface = surface_create(view_width,view_height);
		
	surface_set_target(door_surface);
	draw_clear_alpha(c_black,0);
	
	load_grid("door");
		
	surface_reset_target();
}
	
draw_surface(door_surface,viewX,viewY);