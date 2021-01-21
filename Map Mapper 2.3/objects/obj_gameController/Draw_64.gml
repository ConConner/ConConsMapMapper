draw_set_color(c_white);
draw_set_font(fnt_simple_text);
display_set_gui_size(800,800);
draw_text(0,780,"Current Map: " + selected_map);


//debug
if (debug_on) {
	
	//debug message
	draw_set_colour(c_yellow);
	draw_text(0,0,"DEBUG MODE");
	draw_set_colour(c_white);
	
	//fps view
	var _fps = fps_real;
	if (_fps > 100) draw_set_colour(c_lime);
	else draw_set_colour(c_red);
	draw_text(800 - string_width(_fps),0,_fps);
	draw_set_colour(c_white);
	
	
	//showing debug vars
	draw_text(0,17 * 2,"Tile xscale: " + string(tile_xscale));
	draw_text(0,17 * 3,"Tile yscale: " + string(tile_yscale));
	draw_text(0,17 * 5,"Cam Zoom: " + string(obj_camera.cam_zoom_goal));
	draw_text(0,17 * 7,"Mouse XX: " + string(global.xx) + ";    X: " + string(mouse_x));
	draw_text(0,17 * 8,"Mouse YY: " + string(global.yy) + ";    Y: " + string(mouse_y));
	draw_text(0,17 * 10,"Selected XX: " + string(tile_xx));
	draw_text(0,17 * 11,"Selected YY: " + string(tile_yy));
	
	
	draw_set_alpha(0.4);
	draw_sprite(spr_cam,0,400 - 10,400 - 16);
	draw_set_alpha(1);
	
}

//test drawing
draw_set_alpha(1);
draw_set_color(c_white);

if (mMiddle) {
	draw_hue_shift(273, 273, 255, 255, 63);
	
	global.selected_color = get_mouse_hsv(273, 273, 255, 255);
}

draw_set_alpha(1);
draw_set_color(c_white);