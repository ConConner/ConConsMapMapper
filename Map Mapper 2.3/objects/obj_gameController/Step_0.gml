#region setting up
//getting mouse coordinates on grid
global.xx = clamp(floor((mouse_x + global.cam_pos_x) / tile_size), 0, global.grid_width - 1);
global.yy = clamp(floor((mouse_y + global.cam_pos_y) / tile_size), 0, global.grid_height - 1);
real_xx = floor((mouse_x + global.cam_pos_x) / tile_size);
real_yy = floor((mouse_y + global.cam_pos_y) / tile_size);

//view and window sizes
#macro view_half_w = (global.view_width / 2)
#macro view_half_h = (global.view_height / 2)

global.window_width = window_get_width();
global.window_height = window_get_height();
#macro window_half_width  (global.window_width / 2)
#macro window_half_height  (global.window_height / 2)


//getting key input
kUp = keyboard_check(vk_up);
kDown = keyboard_check(vk_down);
kLeft = keyboard_check(vk_left);
kRight = keyboard_check(vk_right);
kF12 = keyboard_check_pressed(vk_f12);
kCtrl = keyboard_check(vk_control);
kShift = keyboard_check(vk_shift);
kSpace = keyboard_check(vk_space);
kSpacePressed = keyboard_check_pressed(vk_space);
kAlt = keyboard_check(vk_alt);
kAltReleased = keyboard_check_released(vk_alt);
kAltPressed = keyboard_check_pressed(vk_alt);
	//mouse input
mLeft = mouse_check_button(mb_left);
mRight = mouse_check_button(mb_right);
mRightPressed = mouse_check_button_pressed(mb_right);
mRightReleased = mouse_check_button_released(mb_right);
mLeftReleased = mouse_check_button_released(mb_left);
mLeftPressed = mouse_check_button_pressed(mb_left);
mMiddle = mouse_check_button(mb_middle);
mMiddlePressed = mouse_check_button_pressed(mb_middle);
mWheelUp = mouse_wheel_up();
mWheelDown = mouse_wheel_down();
#endregion


#region camera
if (current_menu == menu_state.nothing) {
	//cam controls
	//keyboard controls
	if (kLeft) global.cam_pos_x -= border_margin / 2 / 5;
	if (kRight) global.cam_pos_x += border_margin / 2 / 5;
	if (kUp) global.cam_pos_y -= border_margin / 2 / 5;
	if (kDown) global.cam_pos_y += border_margin / 2 / 5;

	//scroll controls
	if (!kShift) {
		if (mWheelUp) global.cam_pos_y -= border_margin / 4;
		if (mWheelDown) global.cam_pos_y += border_margin / 4;
	} else {
		if (mWheelUp) global.cam_pos_x -= border_margin / 4;
		if (mWheelDown) global.cam_pos_x += border_margin / 4;
	}

	//mouse controls
	if ((kSpace || mMiddle) && current_menu == menu_state.nothing) {
		canBuild = false;
		moving_with_mouse = true;
	
		if (mLeftPressed || mMiddlePressed) {
			start_mouse_x = mouse_x;
			start_mouse_y = mouse_y;
			start_cam_x = global.cam_pos_x;
			start_cam_y = global.cam_pos_y;
		}
	
		if (mLeft || mMiddle) {
			var _xshift = mouse_x - start_mouse_x;
			var _yshift = mouse_y - start_mouse_y;
		
			global.cam_pos_x = start_cam_x - _xshift;
			global.cam_pos_y = start_cam_y - _yshift;
		}
	}
	if ((!kSpace && !mMiddle) && current_menu == menu_state.nothing) {
		canBuild = true;
		moving_with_mouse = false;
	}
}


global.cam_pos_x = clamp(global.cam_pos_x, 0 - global.view_width / 2, global.grid_width * tile_size - global.view_width / 2);
global.cam_pos_y = clamp(global.cam_pos_y, 0 - global.view_height / 2, global.grid_height * tile_size - global.view_height / 2);

#endregion


#region tools

//Building with mouse
if (obj_cursor.cursor_mode == curs_mode.on_grid) {
	
	var _tile = ds_grid_get(global.tile_grid, global.xx, global.yy);
	switch (current_tool) {
		
		case tool.pen: {
			if (mLeft) add_tiles();
			if (mRight) add_tiles();
			
			if (mLeftReleased) {
			add_tiles();
			global.roomCount = old_roomCount + 1;
			old_roomCount = global.roomCount;
			placed_tile = false;
			}
			
			if (mRightReleased) deleted_tile = false;
			
			break; }
			
		case tool.eyedropper: {
			
			if (mLeftPressed) {
				get_pixel_color(mouse_x, mouse_y);
				current_tool = tool.pen;
				add_text_message("copied color", 1.5, c_lime);
				
			}
			
			break; }
			
		case tool.color_brush: {
			if (mLeftPressed && _tile.main = ID.filled) replace_room_color(_tile.rm_nmb, global.selected_color);
			if (mRightPressed && _tile.main = ID.filled) replace_same_color(_tile.col, global.selected_color);
			
			break; }
			
		case tool.door_tool: {
			if (!adding_connection) {
				connection_xx = global.xx;
				connection_yy = global.yy;
				connection_xx2 = global.xx;
				connection_yy2 = global.yy;
			}
			
			if ((mLeftPressed || mRightPressed) && _tile.main == ID.filled) { //selecting start pos
				connection_xx = global.xx;
				connection_yy = global.yy;
				
				adding_connection = true;
			}
			
			if ((mLeft || mRight) && click_moved && _tile.main == ID.filled) { //selecting the door
				connection_xx2 = clamp(global.xx, connection_xx - 1, connection_xx + 1);
				connection_yy2 = clamp(global.yy, connection_yy - 1, connection_yy + 1);
				var _tile2 = ds_grid_get(global.tile_grid, connection_xx2, connection_yy2);
					
				if (_tile2.main == ID.empty) { //all of these are safety measures, to ensure that no empty tile is selected
					connection_xx2 = connection_xx;
					connection_yy2 = connection_yy;
				}
				if ((connection_xx2 > connection_xx || connection_xx2 < connection_xx) && (connection_yy2 > connection_yy || connection_yy2 < connection_yy)) {
					connection_yy2 = connection_yy 
				}
				if (connection_xx == connection_xx2 && connection_yy == connection_yy2) {
					click_moved = false;
					adjust_cursor = false;
				} else adjust_cursor = true; //adjusting cursor width and position
			
			}
			
			if (mLeftReleased || mRightReleased) { //placing the door
				//adding doors if correctly selected
				var _tile1 = ds_grid_get(global.tile_grid, connection_xx, connection_yy);
				var _tile2 = ds_grid_get(global.tile_grid, connection_xx2, connection_yy2);
				
				//adding or deleting the door
				if (mLeftReleased) {
					if (connection_xx != connection_xx2 || connection_yy != connection_yy2) {
						//checking the side
						if (connection_xx < connection_xx2) { // room1 | room2
							_tile1.door[1,0] = hatch.filled;
							_tile1.door[1,1] = global.selected_color;
						
							_tile2.door[3,0] = hatch.filled;
							_tile2.door[3,1] = global.selected_color;
						}
					
						if (connection_xx > connection_xx2) { // room2 | room1
							_tile1.door[3,0] = hatch.filled;
							_tile1.door[3,1] = global.selected_color;
						
							_tile2.door[1,0] = hatch.filled;
							_tile2.door[1,1] = global.selected_color;
						}
					
						if (connection_yy < connection_yy2) { // room1 above room2
							_tile1.door[2,0] = hatch.filled;
							_tile1.door[2,1] = global.selected_color;
						
							_tile2.door[0,0] = hatch.filled;
							_tile2.door[0,1] = global.selected_color;
						}
					
						if (connection_yy > connection_yy2) { // room2 above room1
						_tile1.door[0,0] = hatch.filled;
						_tile1.door[0,1] = global.selected_color;
						
						_tile2.door[2,0] = hatch.filled;
						_tile2.door[2,1] = global.selected_color;
					}
					}
				}
				
				if (mRightReleased) {
					if (connection_xx != connection_xx2 || connection_yy != connection_yy2) {
					//checking the side
						if (connection_xx < connection_xx2) { // room1 | room2
							_tile1.door[1,0] = hatch.empty;
							_tile2.door[3,0] = hatch.empty;
						}
					
						if (connection_xx > connection_xx2) { // room2 | room1
							_tile1.door[3,0] = hatch.empty;
							_tile2.door[1,0] = hatch.empty;
						}
					
						if (connection_yy < connection_yy2) { // room1 above room2
							_tile1.door[2,0] = hatch.empty;
							_tile2.door[0,0] = hatch.empty;
						}
					
						if (connection_yy > connection_yy2) { // room2 above room1
							_tile1.door[0,0] = hatch.empty;
							_tile2.door[2,0] = hatch.empty;
						}
					}
				}
							
				adjust_cursor = false;
				adding_connection = false;
			}
			
			break; }
		
	}
}


//checking if clicked and then moved
if (mLeftPressed || mRightPressed) {
	click_xx = global.xx;
	click_yy = global.yy;
	click_moved = false;
}
if (mLeft || mRight) {
	if (click_xx != global.xx) click_moved = true;
	if (click_yy != global.yy) click_moved = true;
}

//deactivating buttons
if (placed_tile || deleted_tile) {
	
	color_button.deactivate();
	igmenu_button.deactivate();
	
} else if (current_menu == menu_state.nothing) {
	
	color_button.activate();
	igmenu_button.activate();
	
}
	
//quick tool swap
//swaps between the latest tool and the color picker
if (kAltPressed) old_tool = current_tool;
if (kAlt && !adding_connection) current_tool = tool.eyedropper;
if (kAltReleased) current_tool = old_tool;

#endregion


#region reaching

//reaching goal alpha
menu_pos_x = lerp(menu_pos_x, menu_goal_pos_x, 0.30);
menu_pos_y = lerp(menu_pos_y, menu_goal_pos_y, 0.30);
menu_width = lerp(menu_width, menu_goal_width, 0.40);
menu_height = lerp(menu_height, menu_goal_height, 0.40);

menu_drawing_alpha = lerp(menu_drawing_alpha, menu_drawing_goal_alpha, 0.30);
background_alpha = lerp(background_alpha, background_goal_alpha, 0.15);


	//reaching goal pos faster
	if (!close_menu) {
		if (menu_pos_x > menu_goal_pos_x - 1) menu_pos_x = menu_goal_pos_x;
		if (menu_pos_y > menu_goal_pos_y - 1) menu_pos_y = menu_goal_pos_y;
		if (menu_width > menu_goal_width - 1) menu_width = menu_goal_width;
		if (menu_height > menu_goal_height - 1) menu_height = menu_goal_height;
	}
	if (close_menu) {
		if (menu_pos_x < menu_goal_pos_x + 1) menu_pos_x = menu_goal_pos_x;
		if (menu_pos_y < menu_goal_pos_y + 1) menu_pos_y = menu_goal_pos_y;
		if (menu_width < menu_goal_width + 1) menu_width = menu_goal_width;
		if (menu_height < menu_goal_height + 1) menu_height = menu_goal_height;
	}

#endregion


#region buttons

//color button transparency
if (!color_button.active && current_menu == menu_state.nothing) {
	
	//button middle coords
	var _pointX = color_button.x + (sprite_get_width(color_button.sprite_index) / 2);
	var _pointY = color_button.y + (sprite_get_height(color_button.sprite_index) / 2);
	var m_distance = point_distance(_pointX, _pointY, mouse_x, mouse_y);
	color_button.goal_alpha = clamp((0.0035157 * power(m_distance,2) + 10) / 100, 0, 1);
	
} else if (current_menu == menu_state.nothing) {
	
	color_button.goal_alpha = 1;
	
}

//ig menu button transparency
if (!igmenu_button.active && current_menu == menu_state.nothing) {
	
	//button middle coords
	var _pointX = igmenu_button.x + (sprite_get_width(igmenu_button.sprite_index) / 2);
	var _pointY = igmenu_button.y + (sprite_get_height(igmenu_button.sprite_index) / 2);
	var m_distance = point_distance(_pointX, _pointY, mouse_x, mouse_y);
	igmenu_button.goal_alpha = clamp((0.0135157 * power(m_distance,2) + 10) / 100, 0, 1);
	
} else if (current_menu == menu_state.nothing) {
	
	igmenu_button.goal_alpha = 1;
	
}

#region door color buttons
if ((current_tool == tool.door_tool) || (old_tool == tool.door_tool && kAlt)) {
	blue_door_button.enable();
	blue_door_button.activate();
	blue_door_button.goal_alpha = 1;
	red_door_button.enable();
	red_door_button.activate();
	red_door_button.goal_alpha = 1;
	green_door_button.enable();
	green_door_button.activate();
	green_door_button.goal_alpha = 1;
	yellow_door_button.enable();
	yellow_door_button.activate();
	yellow_door_button.goal_alpha = 1;
	
} else {
	blue_door_button.disable();
	red_door_button.disable();
	green_door_button.disable();
	yellow_door_button.disable();
	
}

blue_door_button.goal_y = global.window_height / 2 - 128;
red_door_button.goal_y = global.window_height / 2 - 64;
green_door_button.goal_y = global.window_height / 2;
yellow_door_button.goal_y = global.window_height / 2 + 64;

blue_door_button.image_index = 0;
red_door_button.image_index = 1;
green_door_button.image_index = 2;
yellow_door_button.image_index = 3;
#endregion


#endregion


#region menus

//reacting to button
var _selected_button = button_check();
if (mLeftPressed) {
	if ((_selected_button != 0) && (_selected_button.button_enabled && _selected_button.active)) {
		canBuild = false;
		in_menu = true;
	
		switch (_selected_button) {
			
			case color_button: {
			
				//this code gets run basically once, like a create event
				current_menu = menu_state.color_menu;
			
				//creating the selection boxes
				hue_selection = make_button(0, 0, spr_cursor_selector, menu_state.color_menu);
				value_selection = make_button(0,0,spr_cursor_selector, menu_state.color_menu);
				rgb_code_selection = make_button(0,0,spr_cursor_selector, menu_state.color_menu);
				
				//confirm, decline
				color_decline_button = make_button(0,0,spr_menu_decline, menu_state.color_menu);
				color_decline_button.goal_alpha = 0;
				color_decline_button.image_alpha = 0;
				color_confirm_button = make_button(0,0,spr_menu_confirm, menu_state.color_menu);
				color_confirm_button.goal_alpha = 0;
				color_confirm_button.image_alpha = 0;
				
				//setting the selected color to the current color
				selected_color_hue = color_get_hue(global.selected_color);
				selected_color_sat = color_get_saturation(global.selected_color);
				selected_color_val = color_get_value(global.selected_color);
				selected_rgb_hex = get_hex_rgb(global.selected_color);
				
				break; }
			case rgb_code_selection: {
			
				var _val = string_delete(selected_rgb_hex, 1, 1);
				clipboard_set_text(_val);
				add_text_message("Copied #" + string(_val) + " to clipboard", 1.5, c_white);
			
				break; }
			case color_decline_button: {
				
				close_menu = true;
				//removing all the menu buttons
				remove_button(hue_selection);
				remove_button(value_selection);
				remove_button(rgb_code_selection);
				remove_button(color_decline_button);
				remove_button(color_confirm_button);
				
				//resetting colour to old color
				selected_color_hue = color_get_hue(global.selected_color);
				selected_color_sat = color_get_saturation(global.selected_color);
				selected_color_val = color_get_value(global.selected_color);
				
				//text message
				add_text_message("color discarded", 1.5, c_white);
				
				break; }
			case color_confirm_button: {
				
				close_menu = true;
				//removing all the menu buttons
				remove_button(hue_selection);
				remove_button(value_selection);
				remove_button(rgb_code_selection);
				remove_button(color_decline_button);
				remove_button(color_confirm_button);
				
				//setting new colour
				global.selected_color = make_color_hsv(selected_color_hue, selected_color_sat, selected_color_val);
				
				//text message
				add_text_message("applied color", 1.5, c_lime);
				
				break; }
				
			case igmenu_button: {
			
				current_menu = menu_state.ig_menu;
				menu_goal_pos_x = -32;
				menu_pos_x = -32;
				menu_goal_pos_y = -10;
				menu_pos_y = -10;
				menu_goal_height = 0;
				menu_height = 0;
			
				break; }
			case pen_tool_button: {
				current_tool = tool.pen;
				break; }
			case eyedropper_tool_button: {
				current_tool = tool.eyedropper;
				break; }
			case color_brush_tool_button: {
				current_tool = tool.color_brush;
				break; }
			case door_tool_button: {
				current_tool = tool.door_tool;
				break; }
			case marker_tool_button: {
				current_tool = tool.marker_tool;
				break; }
			case selection_tool_button: {
				current_tool = tool.selector;
				break; }
			case save_button: {
				
				var fname = get_save_filename("Map File (.mf)|*"+extension,"");
				save_map(fname);
				
				break; }
			case load_button: {
				
				var fname = get_open_filename("Map File (.mf)|*"+extension,"");
				load_map(fname);
				
				break; }
			case tooltip_button: {
				show_tooltips = !show_tooltips;
				break; }
				
			case blue_door_button: {
				in_menu = false;
				canBuild = true;
				global.selected_color = make_color_rgb(0,0,255);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case red_door_button: {
				in_menu = false;
				canBuild = true;
				global.selected_color = make_color_rgb(255,0,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case green_door_button: {
				in_menu = false;
				canBuild = true;
				global.selected_color = make_color_rgb(0,255,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case yellow_door_button: {
				in_menu = false;
				canBuild = true;
				global.selected_color = make_color_rgb(255,255,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			
		}
	}
}

#endregion


#region debug

if (kF12) debug_on = !debug_on;

if (debug_on) {
}

#endregion

