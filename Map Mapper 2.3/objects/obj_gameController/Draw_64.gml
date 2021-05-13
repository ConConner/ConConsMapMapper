draw_set_color(c_white);
draw_set_font(fnt_simple_text);
display_set_gui_size(800,800);
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
			menu_goal_width = global.view_width - tile_size;
			menu_goal_height = 350;
		}
		menu_pos_x = (global.view_width / 2) - (menu_width / 2);
		menu_pos_y = (global.view_height / 2) - (menu_height / 2);
		
		draw_nine_slice(spr_menu_nineslice, menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height);
		
		if (menu_width > menu_goal_width - 20 && menu_height > menu_goal_height - 20) { //this happens after the menu background is done
			
			menu_drawing_goal_alpha = 1;
			background_goal_alpha = 0.6;
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
			
			draw_rectangle_color(menu_pos_x + 419, menu_pos_y + 43, menu_pos_x + 483, menu_pos_y + 74, old_col, old_col, old_col, old_col, false); // old colour
			draw_rectangle_color(menu_pos_x + 419, menu_pos_y + 75, menu_pos_x + 483, menu_pos_y + 107, new_col, new_col, new_col, new_col, false); //new colour
			
			draw_text(menu_pos_x + 416, menu_pos_y + 17, "OLD")
			draw_text(menu_pos_x + 416, menu_pos_y + 113, "NEW")
			
			
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
		menu_goal_height = 112;
		
		//moving the button
		igmenu_button.y = menu_pos_y + menu_height + 32;
		
		draw_nine_slice(spr_menu_nineslice, menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height);
		
		if (menu_height > menu_goal_height - 2) { //this happens after the menu background is done
			
			background_goal_alpha = 0.6;
			
		}
		
		break; }
		
	case menu_state.nothing: {
		break; }
		
}

update_text_message(global.view_width,global.view_height - 22);


//button drawing
button_update();


//debug
if (debug_on) {
	draw_set_alpha(1);
	
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
	draw_set_colour(c_ltgrey);
	
	
	//showing debug vars
	draw_text(5,17 * 2,"Tile xscale: " + string(tile_xscale));
	draw_text(5,17 * 3,"Tile yscale: " + string(tile_yscale));
	draw_text(5,17 * 5,"Mouse XX: " + string(global.xx) + ";    X: " + string(mouse_x));
	draw_text(5,17 * 6,"Mouse YY: " + string(global.yy) + ";    Y: " + string(mouse_y));
	draw_text(5,17 * 8,"Camera X: " + string(global.cam_pos_x));
	draw_text(5,17 * 9,"Camera Y: " + string(global.cam_pos_y));
	draw_text(5,17 * 11,"Cursor Mode: " + string(obj_cursor.cursor_mode));
	draw_text(5,17 * 13,"Menu X" + string(menu_pos_x));
	draw_text(5,17 * 14,"Menu X" + string(menu_pos_x));
	draw_text(5,17 * 15,"Menu width: " + string(menu_width));
	draw_text(5,17 * 16,"Menu height: " + string(menu_height));
	draw_text(5,17 * 18,"Selected Col Hue: " + string(selected_color_hue));
	draw_text(5,17 * 19,"Selected Col Sat: " + string(selected_color_sat));
	draw_text(5,17 * 20,"Selected Col Val: " + string(selected_color_val));
	draw_text(5,17 * 22,"Color Button goal alpha: " + string(color_button.goal_alpha));
	draw_text(5,17 * 23,"Color Button goal alpha: " + string(color_button.image_alpha));
	
}