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
	draw_text(global.view_width - string_width(_fps),0,_fps);
	draw_set_colour(c_white);
	
}