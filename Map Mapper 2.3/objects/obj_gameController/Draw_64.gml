draw_set_color(c_white);
draw_set_font(fnt_simple_text);
display_set_gui_size(800,800);
draw_set_halign(fa_left)


//debug
if (debug_on) {
	
	//debug message
	draw_set_colour(c_yellow);
	draw_text(0,0,"DEBUG MODE");
	draw_set_colour(c_white);
	
	//fps view
	var _fps = round(fps_real);
	if (_fps > 100) draw_set_colour(c_lime);
	else draw_set_colour(c_red);
	draw_set_halign(fa_right)
	draw_text(800,0,_fps);
	draw_set_halign(fa_left)
	draw_set_colour(c_white);
	
	
	//showing debug vars
	draw_text(0,17 * 2,"Tile xscale: " + string(tile_xscale));
	draw_text(0,17 * 3,"Tile yscale: " + string(tile_yscale));
	draw_text(0,17 * 5,"Mouse XX: " + string(global.xx) + ";    X: " + string(mouse_x));
	draw_text(0,17 * 6,"Mouse YY: " + string(global.yy) + ";    Y: " + string(mouse_y));
	draw_text(0,17 * 8,"Camera X: " + string(global.cam_pos_x));
	draw_text(0,17 * 9,"Camera Y: " + string(global.cam_pos_y));
	draw_text(0,17 * 11,"Cursor Mode: " + string(obj_cursor.cursor_mode));
	
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

draw_set_halign(fa_right);
update_text_message(795,778);
draw_set_halign(fa_left);

//button drawing
color_button.draw();