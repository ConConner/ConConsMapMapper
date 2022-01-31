draw_set_color(c_white);
draw_set_font(fnt_simple_text);
display_set_gui_size(global.view_width,global.view_height);
draw_set_halign(fa_left)


//menus
draw_set_alpha(1);
draw_set_color(c_white);

	//drawing the menu
switch (current_menu) {
	case menu_state.color_menu: {
		
		//darkening the background
		draw_set_alpha(background_alpha);
		draw_set_color(c_black);
		draw_rectangle(0,0,global.view_width,global.view_height,false);
		draw_set_color(c_white);
		
		//drawing nineslice background
		draw_set_alpha(1)
		image_alpha = 1;
		
		if (!close_menu) {
			menu_goal_width = 800 - tile_size;
			menu_goal_height = 350;
		}
		menu_pos_x = (global.view_width / 2) - (menu_width / 2);
		menu_pos_y = (global.view_height / 2) - (menu_height / 2);
		
		background_goal_alpha = 0.6;
		
		draw_nine_slice(spr_menu_nineslice, menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height);
		
		if (menu_width > menu_goal_width - 20 && menu_height > menu_goal_height - 20) { //this happens after the menu background is done
			
			menu_drawing_goal_alpha = 1;
			image_alpha = menu_drawing_alpha;
			draw_set_alpha(menu_drawing_alpha);
			
			var _mouseX = device_mouse_x_to_gui(0);
			var _mouseY = device_mouse_y_to_gui(0);
			
			//contents of the menu
			draw_text(menu_pos_x + 20, menu_pos_y + 17, "COLOR MENU");
			draw_nine_slice(spr_edge_nineslice, menu_pos_x + 20, menu_pos_y + 40, menu_pos_x + 282, menu_pos_y + 302);
			draw_hue_shift(menu_pos_x + 23, menu_pos_y + 43, 255, 255, 255);
			draw_text(menu_pos_x + 20, menu_pos_y + 303, "HUE - SATURATION");
			
			
				//value slider
			draw_text(menu_pos_x + 314, menu_pos_y + 303, "VALUE");
			draw_nine_slice(spr_edge_nineslice, menu_pos_x + 314, menu_pos_y + 40, menu_pos_x + 384, menu_pos_y + 302);
			
			var col1 = make_color_hsv(selected_color_hue, selected_color_sat, 255);
			var col2 = make_color_hsv(selected_color_hue, selected_color_sat, 0);
			draw_rectangle_color(menu_pos_x + 317, menu_pos_y + 43, menu_pos_x + 381, menu_pos_y + 299, col1, col1, col2, col2, false);
			
					//drawing the slider itself
			var _yPos = menu_pos_y + 43 + ((selected_color_val - 255) * -1);
			_yPos = clamp(_yPos, menu_pos_y + 48, menu_pos_y + 294);
			draw_sprite(spr_slider_pedal, 0, menu_pos_x + 349, _yPos);
			
					//updating the slider
			if (point_in_rectangle(_mouseX, _mouseY, menu_pos_x + 317, menu_pos_y + 43, menu_pos_x + 381, menu_pos_y + 299)) {
				if (mLeft) {
					var _value = ((_mouseY - (menu_pos_y + 43)) - 255) * -1;
					selected_color_val = _value;
				}
			}
			
			
				//drawing the pinpoint on the hue shift
			var _yPos = menu_pos_y + 43 + ((selected_color_sat - 255) * -1);
			draw_sprite(spr_pinpoint, 0, menu_pos_x + 23 + selected_color_hue, _yPos);
			
					//updating the color
			if (point_in_rectangle(_mouseX, _mouseY, menu_pos_x + 23, menu_pos_y + 43, menu_pos_x + 278, menu_pos_y + 298)) {
				if (mLeft) {
					set_mouse_hsv(menu_pos_x + 23, menu_pos_y + 43, 255, 255);
				}
			}
			
			
			//drawing a color preview
			var old_col = global.selected_color;
			var new_col = make_color_hsv(selected_color_hue, selected_color_sat, selected_color_val);
			draw_nine_slice(spr_edge_nineslice, menu_pos_x + 416, menu_pos_y + 40, menu_pos_x + 486, menu_pos_y + 110);
			
			draw_rectangle_color(menu_pos_x + 419, menu_pos_y + 75, menu_pos_x + 483, menu_pos_y + 107, old_col, old_col, old_col, old_col, false); // old colour
			draw_rectangle_color(menu_pos_x + 419, menu_pos_y + 43, menu_pos_x + 483, menu_pos_y + 74, new_col, new_col, new_col, new_col, false); //new colour
			
			//menu_pos_x + 419, menu_pos_y + 43, menu_pos_x + 483, menu_pos_y + 74,
			//menu_pos_x + 419, menu_pos_y + 75, menu_pos_x + 483, menu_pos_y + 107
			
			draw_text(menu_pos_x + 416, menu_pos_y + 17, "NEW");
			draw_text(menu_pos_x + 416, menu_pos_y + 113, "OLD");
			
			
				//drawing color code
			selected_rgb_hex = get_hex_rgb(new_col);
			draw_nine_slice(spr_edge_nineslice, menu_pos_x + 416, menu_pos_y + 267, menu_pos_x + 510, menu_pos_y + 299);
			draw_text(menu_pos_x + 421, menu_pos_y + 272, selected_rgb_hex);
			draw_text(menu_pos_x + 416, menu_pos_y + 303, "HEX");
			
			#region updating selection boxes
			hue_selection.goal_x = menu_pos_x + 20;
			hue_selection.goal_y = menu_pos_y + 40;
			hue_selection.button_width = 261;
			hue_selection.button_height = 261;
			
			value_selection.goal_x = menu_pos_x + 314;
			value_selection.goal_y = menu_pos_y + 40;
			value_selection.button_width = 70;
			value_selection.button_height = 261;
			
			rgb_code_selection.goal_x = menu_pos_x + 416;
			rgb_code_selection.goal_y = menu_pos_y + 267;
			rgb_code_selection.button_width = 94;
			rgb_code_selection.button_height = 32;
			
			color_decline_button.goal_x = menu_pos_x + menu_width - 1 - 3.5*tile_size;
			color_decline_button.goal_y = menu_pos_y - tile_size / 2;
			color_decline_button.goal_alpha = menu_drawing_alpha
			color_decline_button.jmp();
			color_confirm_button.goal_x = menu_pos_x + menu_width - 2*tile_size;
			color_confirm_button.goal_y = menu_pos_y - tile_size / 2;
			color_confirm_button.goal_alpha = menu_drawing_alpha
			color_confirm_button.jmp();
			#endregion
			
		}
			
		if (close_menu) { //closing process
			menu_drawing_goal_alpha = 0;
			background_goal_alpha = 0;
			
			if (menu_drawing_alpha <= 0.01) { //this happens after the button fadeout
				menu_goal_width = 32;
				menu_goal_height = 32;
				
				if (menu_width < menu_goal_width + 3 && menu_height < menu_goal_height + 3) { //this happens after the animation finished
					
					//enabling building again
					close_menu = false;
					canBuild = true;
					in_menu = false;
					
					//ending menu
					current_menu = menu_state.nothing;
				}
			}
			
			
		}
		
		break; }
		
	case menu_state.save_menu: {
		
		//darkening the background
		draw_set_alpha(background_alpha);
		draw_set_color(c_black);
		draw_rectangle(0,0,global.view_width,global.view_height,false);
		draw_set_color(c_white);
		
		//drawing nineslice background
		draw_set_alpha(1)
		image_alpha = 1;
		
		if (!close_menu) {
			menu_goal_width = 800 - tile_size;
			menu_goal_height = 350;
		}
		menu_pos_x = (global.view_width / 2) - (menu_width / 2);
		menu_pos_y = (global.view_height / 2) - (menu_height / 2);
		
		background_goal_alpha = 0.6;
		
		draw_nine_slice(spr_menu_nineslice, menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height);
		
		if (menu_width > menu_goal_width - 20 && menu_height > menu_goal_height - 20) { //this happens after the menu background is done
			
			menu_drawing_goal_alpha = 1;
			image_alpha = menu_drawing_alpha;
			draw_set_alpha(menu_drawing_alpha);
			
			var _mouseX = device_mouse_x_to_gui(0);
			var _mouseY = device_mouse_y_to_gui(0);
			
			//contents of the menu
			draw_set_halign(fa_center);
			draw_text(menu_pos_x + menu_width / 2, menu_pos_y + 17, "SAVE MENU");
			draw_set_halign(fa_left);
			
			//drawing info box outline
			var box1_x = menu_pos_x + 35
			var box2_x = menu_pos_x + menu_width / 2 - 115
			var box3_x = menu_pos_x + menu_width - 265
			var box_y = menu_pos_y + 55
			draw_nine_slice(spr_edge_nineslice, box1_x, box_y, box1_x + 230, box_y + 250);
			draw_nine_slice(spr_edge_nineslice, box2_x, box_y, box2_x + 230, box_y + 250);
			draw_nine_slice(spr_edge_nineslice, box3_x, box_y, box3_x + 230, box_y + 250);
			
			//drawing button graphics
			draw_set_font(fnt_simple_text_2x); //different export buttons
			draw_text_button(menu_pos_x + 40, menu_pos_y + 60, 220, 50, "map file");
			draw_text_button(menu_pos_x + menu_width / 2 - 110, menu_pos_y + 60, 220, 50, "png");
			draw_text_button(menu_pos_x + menu_width - 260, menu_pos_y + 60, 220, 50, "SMART");
			draw_set_font(fnt_simple_text);
			
			//drawing info text
			draw_set_color(c_aqua);
			draw_text(box1_x + 6, box_y + 60, "info:");
			draw_text(box2_x + 6, box_y + 60, "info:");
			draw_text(box3_x + 6, box_y + 60, "info:");
			draw_set_color(c_ltgrey);
			draw_text_ext(box1_x + 6, box_y + 85, "exports the map as a file, which can be shared and read back into the program.", 22, 220);
			draw_text_ext(box2_x + 6, box_y + 85, "exports the map as a transparent image.\ncannot be read back into the program!", 22, 220);
			draw_text_ext(box3_x + 6, box_y + 85, "exports the map as a SMART compatible file.\n(can not be read back into the program at the moment!)", 22, 220);
			
			
			#region updating buttons
			save_confirm_button.goal_x = menu_pos_x + menu_width - 2.75*tile_size;
			save_confirm_button.goal_y = menu_pos_y - tile_size / 2;
			save_confirm_button.goal_alpha = menu_drawing_alpha
			save_confirm_button.jmp();
			
			save_mf_button.goal_x = box1_x + 5;
			save_mf_button.goal_y = box_y + 5;
			save_mf_button.button_width = 220;
			save_mf_button.button_height = 50;
			save_png_button.goal_x = box2_x + 5;
			save_png_button.goal_y = box_y + 5;
			save_png_button.button_width = 220;
			save_png_button.button_height = 50;
			save_xml_button.goal_x = box3_x + 5;
			save_xml_button.goal_y = box_y + 5;
			save_xml_button.button_width = 220;
			save_xml_button.button_height = 50;
			#endregion
			
		}
			
		if (close_menu) { //closing process
			menu_drawing_goal_alpha = 0;
			background_goal_alpha = 0;
			
			if (menu_drawing_alpha <= 0.01) { //this happens after the button fadeout
				menu_goal_width = 32;
				menu_goal_height = 32;
				
				if (menu_width < menu_goal_width + 3 && menu_height < menu_goal_height + 3) { //this happens after the animation finished
					
					//going back to main menu
					close_menu = false;
					canBuild = false;
					in_menu = true;
					
					//ending menu
					current_menu = menu_state.ig_menu;
				}
			}
			
			
		}
		
		break; }
		
	case menu_state.ig_menu: {
		
		//darkening the background
		draw_set_alpha(background_alpha);
		draw_set_color(c_black);
		draw_rectangle(0,0,global.view_width,global.view_height,false);
		draw_set_color(c_white);
		
		//drawing nineslice background
		draw_set_alpha(1)
		image_alpha = 1;
		
		menu_width = global.view_width + 64;
		if (!close_menu) menu_goal_height = 112;
		
		background_goal_alpha = 0.6;
		
		//moving the button
		igmenu_button.y = menu_pos_y + menu_height + 32;
		
		draw_nine_slice(spr_menu_nineslice, menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height);
		
		if (menu_height > menu_goal_height - 2) { //this happens after the menu background is done
			
			//tool information and more text
			menu_drawing_goal_alpha = 1;
			draw_set_alpha(menu_drawing_alpha);
			
			if (show_tooltips) {
				
				#macro text_offset 160
				draw_set_color(c_red);
				draw_text(32, text_offset - 30, "Tool information:");
				var _text_array = ["You should not see this!!!"];
				
				switch (current_tool) {
				
					case tool.pen: {
						_text_array = pen_tool_tip;
						break; }
					case tool.eyedropper: {
						_text_array = color_picker_tool_tip;
						break; }
					case tool.color_brush: {
						_text_array = color_brush_tool_tip;
						break; }
					case tool.door_tool: {
						_text_array = door_tool_tip;
						break; }
					case tool.marker_tool: {
						_text_array = marker_tool_tip;
						break; }
					case tool.hammer: {
						_text_array = hammer_tool_tip;
						break; }
					case tool.selector: {
						_text_array = selection_tool_tip;
						break; }
				
				}
				
				//generating the text to draw
				var _len = array_length(_text_array);
				var _string = "";
				for (var i = 0; i < _len; i++) {
					_string = _string + string(_text_array[i]) + "\n";
				}
				
				//drawing generated text
				draw_set_color(c_ltgrey);
				draw_text(32, text_offset, _string);
				
			}
			
			
			
			//drawing tooltip section
			draw_set_color(c_white);
			draw_checkbox(32, global.window_height - 55, show_tooltips);
			draw_text(32 + 27, global.window_height - 55, "tooltips");
			
		}
		
		#region updating button pos
		pen_tool_button.goal_alpha = 1;
		pen_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) pen_tool_button.activate();
		if (current_tool == tool.pen) pen_tool_button.image_index = 1;
		else pen_tool_button.image_index = 0;
		
		eyedropper_tool_button.goal_alpha = 1;
		eyedropper_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) eyedropper_tool_button.activate();
		if (current_tool == tool.eyedropper) eyedropper_tool_button.image_index = 1;
		else eyedropper_tool_button.image_index = 0;
		
		color_brush_tool_button.goal_alpha = 1;
		color_brush_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) color_brush_tool_button.activate();
		if (current_tool == tool.color_brush) color_brush_tool_button.image_index = 1;
		else color_brush_tool_button.image_index = 0;
		
		door_tool_button.goal_alpha = 1;
		door_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) door_tool_button.activate();
		if (current_tool == tool.door_tool) door_tool_button.image_index = 1;
		else door_tool_button.image_index = 0;
		
		marker_tool_button.goal_alpha = 1;
		marker_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) marker_tool_button.activate();
		if (current_tool == tool.marker_tool) marker_tool_button.image_index = 1;
		else marker_tool_button.image_index = 0;
		
		selection_tool_button.goal_alpha = 1;
		selection_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) selection_tool_button.activate();
		if (current_tool == tool.selector) selection_tool_button.image_index = 1;
		else selection_tool_button.image_index = 0;
		
		hammer_tool_button.goal_alpha = 1;
		hammer_tool_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) hammer_tool_button.activate();
		if (current_tool == tool.hammer) hammer_tool_button.image_index = 1;
		else hammer_tool_button.image_index = 0;
		
		save_button.goal_alpha = 1;
		save_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) save_button.activate();
		
		load_button.goal_alpha = 1;
		load_button.goal_y = menu_pos_y + menu_height - 98;
		if (menu_height > menu_goal_height - 2) load_button.activate();
		
		tooltip_button.activate();
		tooltip_button.button_height = 23;
		tooltip_button.button_width = 105;
		
		discord_button.goal_alpha = 1;
		discord_button.activate();
		#endregion
		
		if (close_menu) { //closing process
			menu_goal_height = 0;
			background_goal_alpha = 0;
			menu_drawing_goal_alpha = 0;
			
			if (menu_height < menu_goal_height + 5) {
				current_menu = menu_state.nothing;
				close_menu = false;
				
				canBuild = true;
				in_menu = false;
			}
		}
		
		//closing if clicking anywhere else
		if (mLeftPressed && global.mouse_pos_y > menu_pos_y + menu_goal_height && button_check() == 0) close_menu = true;
		
		break; }
		
	case menu_state.nothing: {
		break; }
		
}

#region drawing the marker-tileset
//calculating amount of tiles per page
space_per_page = global.view_height - 124;
tiles_per_page = floor(space_per_page / 40);
max_pages = ceil(tile_amount / tiles_per_page - 1)

//switching tile pages
if (obj_cursor.cursor_mode == curs_mode.on_tileset) {
	if (mWheelDown) tile_page++;
	if (mWheelUp) tile_page--;
}
tile_page = clamp(tile_page, 0, max_pages);

//setting alpha for nineslice
image_alpha = 1;

//setting tileset coordinates
if (current_menu == menu_state.nothing && current_tool == tool.marker_tool) {
	tileset_goal_x = global.view_width - 96;
} else {
	tileset_goal_x = global.view_width + 10;
}

//drawing the background nineslice and tileset
draw_nine_slice(spr_menu_nineslice, tileset_x, -32, global.view_width + 32, global.view_height + 32)
if (sprite_exists(marker_sprite)) draw_marker_set(tileset_x + 32, 64);

//drawing squares to hide the overshooting tiles
draw_set_color(c_black);
draw_rectangle(tileset_x + 10, 0, global.view_width, 62, false);
draw_rectangle(tileset_x + 10, global.view_height - 62, global.view_width, global.view_height, false);
draw_set_color(c_white);

//text
draw_set_halign(fa_center);
draw_text(tileset_x + 54, 8, "MARKERS");
draw_set_halign(fa_left);
draw_text(tileset_x + 14, global.view_height - 32, "PAGE " + string(tile_page + 1) + "/" + string(max_pages + 1));
draw_set_halign(fa_center);

#endregion

//button drawing
button_update();
update_text_message(global.view_width,global.view_height - 22);

//debug
if (debug_on) {
	draw_set_alpha(1);
	
	//debug message
	draw_set_colour(c_yellow);
	draw_text(0,0,"DEBUG MODE");
	draw_set_colour(c_white);
	
	//debug button view
	visualize_buttons();
	
	//fps view
	var _fps = round(fps_real);
	if (_fps > 100) draw_set_colour(c_lime);
	else draw_set_colour(c_red);
	draw_set_halign(fa_right)
	draw_text(global.view_width,0,_fps);
	draw_set_halign(fa_left)
	draw_set_colour(c_ltgrey);
	
	
	//showing debug vars
	draw_text(5,17 * 3,"Mouse XX: " + string(global.xx) + ";    X: " + string(global.mouse_pos_x));
	draw_text(5,17 * 4,"Mouse YY: " + string(global.yy) + ";    Y: " + string(global.mouse_pos_y));
	draw_text(5,17 * 6,"Camera X: " + string(global.cam_pos_x));
	draw_text(5,17 * 7,"Camera Y: " + string(global.cam_pos_y));
	draw_text(5,17 * 9,"Cursor Mode: " + string(obj_cursor.cursor_mode));
	draw_text(5,17 * 10,"Menu Status: " + string(current_menu));
	draw_text(5,17 * 12,"Menu X" + string(menu_pos_x));
	draw_text(5,17 * 13,"Menu Y" + string(menu_pos_y));
	draw_text(5,17 * 14,"Menu width: " + string(menu_width));
	draw_text(5,17 * 15,"Menu height: " + string(menu_height));
	draw_text(5,17 * 17,"Selected Col Hue: " + string(selected_color_hue));
	draw_text(5,17 * 18,"Selected Col Sat: " + string(selected_color_sat));
	draw_text(5,17 * 19,"Selected Col Val: " + string(selected_color_val));
	draw_text(5,17 * 21,"Cursor X: " + string(obj_cursor.goal_x));
	draw_text(5,17 * 22,"Cursor Y: " + string(obj_cursor.goal_y));
	draw_text(5,17 * 24,"Selected Marker: " + string(selected_marker));
	
}