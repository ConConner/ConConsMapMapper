function draw_hue_shift(_x, _y, w, h, hue_split) {
	
	for (var i = 0; i < hue_split; i++) {
		
		var hue_value = i * max(floor(255 / hue_split), 1);
		var col_1 = make_color_hsv(hue_value, 255, selected_color_val);
		var col_2 = make_color_hsv(hue_value, 0, selected_color_val);
		
		var pixel_width = w / hue_split;
		var _x1 = _x + i * pixel_width;
		var _y1 = _y;
		var _x2 = _x1 + pixel_width;
		var _y2 = _y + h;
		
		draw_rectangle_color(_x1, _y1, _x2, _y2, col_1, col_1, col_2, col_2, false);
	}
	
}

function set_mouse_hsv(_x, _y, w, h) {
	
	var mouse_xx = clamp(device_mouse_x_to_gui(0) - _x, 0, w);
	var mouse_yy = clamp(device_mouse_y_to_gui(0) - _y, 0, h);
	
	var hue_value = mouse_xx / (w / 255);
	var sat_value = ((mouse_yy / (h / 255)) - 255) * -1 + 1;
	
	selected_color_hue = hue_value;
	selected_color_sat = sat_value;
	
}
	
function get_hex_rgb(_col) {
	var _red = color_get_red(_col);
	var _green = color_get_green(_col);
	var _blue = color_get_blue(_col);
	
	var _hex = "#" + string(dec_to_hex(_red)) + string(dec_to_hex(_green)) + string(dec_to_hex(_blue));
	return(_hex)
}