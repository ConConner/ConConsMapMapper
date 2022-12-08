#region setting up
//getting mouse coordinates on grid

	//GLOBAL MOUSE COORDINATES
	global.mouse_pos_x = device_mouse_x_to_gui(0);
	global.mouse_pos_y = device_mouse_y_to_gui(0);

global.xx = clamp(floor((global.mouse_pos_x + global.cam_pos_x) / tile_size), 0, global.grid_width - 1);
global.yy = clamp(floor((global.mouse_pos_y + global.cam_pos_y) / tile_size), 0, global.grid_height - 1);
real_xx = floor((global.mouse_pos_x + global.cam_pos_x) / tile_size);
real_yy = floor((global.mouse_pos_y + global.cam_pos_y) / tile_size);

//view and window sizes
global.view_width = obj_camera.view_width;
global.view_height = obj_camera.view_height;
global.grid_view_width = global.grid_width * tile_size;
global.grid_view_height = global.grid_height * tile_size;

global.window_width = window_get_width();
global.window_height = window_get_height();


#region getting key input for special keys
kUp = keyboard_check(vk_up);
kDown = keyboard_check(vk_down);
kLeft = keyboard_check(vk_left);
kDownPressed = keyboard_check_pressed(vk_down);
kUpPressed = keyboard_check_pressed(vk_up);
kRight = keyboard_check(vk_right);
kF12 = keyboard_check_pressed(vk_f12);
kCtrl = keyboard_check(vk_control);
kShift = keyboard_check(vk_shift);
kSpace = keyboard_check(vk_space);
kAlt = keyboard_check(vk_alt);
kAltPressed = keyboard_check_pressed(vk_alt);
kEscPressed = keyboard_check_pressed(vk_escape);
kEnterPressed = keyboard_check_pressed(vk_enter);
//key input for letter keys
kLetterP = keyboard_check(ord("P"));
kLetterB = keyboard_check(ord("B"));
kLetterC = keyboard_check(ord("C"));
kLetterM = keyboard_check(ord("M"))
kLetterH = keyboard_check(ord("H"));
kLetterS = keyboard_check(ord("S"));
kLetterSPressed = keyboard_check_pressed(ord("S"));
kLetterL = keyboard_check(ord("L"));
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

#endregion


#region camera
if (current_menu == menu_state.nothing) {
	//cam controls
	//keyboard controls
	if (current_tool != tool.marker_tool) {
		if (kLeft) global.cam_pos_x -= border_margin / 2 / 5;
		if (kRight) global.cam_pos_x += border_margin / 2 / 5;
		if (kUp) global.cam_pos_y -= border_margin / 2 / 5;
		if (kDown) global.cam_pos_y += border_margin / 2 / 5;
	}

	//scroll controls
	if (obj_cursor.cursor_mode == curs_mode.on_grid) {
		if (!kShift) {
			if (mWheelUp) global.cam_pos_y -= border_margin / 4;
			if (mWheelDown) global.cam_pos_y += border_margin / 4;
		} else {
			if (mWheelUp) global.cam_pos_x -= border_margin / 4;
			if (mWheelDown) global.cam_pos_x += border_margin / 4;
		}
	}

	//mouse controls
	if ((kSpace || mMiddle) && current_menu == menu_state.nothing) {
		canBuild = false;
		placed_tile = false;
		moving_with_mouse = true;
	
		if (mLeftPressed || mMiddlePressed) {
			start_mouse_x = global.mouse_pos_x;
			start_mouse_y = global.mouse_pos_y;
			start_cam_x = global.cam_pos_x;
			start_cam_y = global.cam_pos_y;
		}
	
		if (mLeft || mMiddle) {
			var _xshift = global.mouse_pos_x - start_mouse_x;
			var _yshift = global.mouse_pos_y - start_mouse_y;
		
			global.cam_pos_x = start_cam_x - _xshift;
			global.cam_pos_y = start_cam_y - _yshift;
		}
	}
	if ((!kSpace && !mMiddle) && current_menu == menu_state.nothing) {
		canBuild = true;
		moving_with_mouse = false;
	}
}


global.cam_pos_x = clamp(global.cam_pos_x, 0 - global.view_width / 2, global.grid_width * tile_size - global.view_width / 2 - tile_size);
global.cam_pos_y = clamp(global.cam_pos_y, 0 - global.view_height / 2, global.grid_height * tile_size - global.view_height / 2 - tile_size);

#endregion


#region tools

//acting on tools
if (obj_cursor.cursor_mode == curs_mode.on_grid) {
	
	var _tile = ds_grid_get(global.tile_grid, global.xx, global.yy);
	switch (current_tool) {
		
		case tool.pen: {
			if (mLeft || mRight) add_tiles();
			
			if (mLeftReleased) {
				add_tiles();
				global.roomCount = old_roomCount + 1;
				old_roomCount = global.roomCount;
				placed_tile = false;
			}
			
			if (!mLeft && !mRight) placed_tile = false;
			
			if (mRightReleased) deleted_tile = false;
			
			break; }
			
		case tool.eyedropper: {
			
			if (mLeftPressed) {
				get_pixel_color(global.mouse_pos_x, global.mouse_pos_y);
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
					connection_yy2 = connection_yy;
					connection_xx2 = connection_xx;
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
							_tile1.door[1,1] = global.connection_color;
						
							_tile2.door[3,0] = hatch.filled;
							_tile2.door[3,1] = global.connection_color;
						}
					
						if (connection_xx > connection_xx2) { // room2 | room1
							_tile1.door[3,0] = hatch.filled;
							_tile1.door[3,1] = global.connection_color;
						
							_tile2.door[1,0] = hatch.filled;
							_tile2.door[1,1] = global.connection_color;
						}
					
						if (connection_yy < connection_yy2) { // room1 above room2
							_tile1.door[2,0] = hatch.filled;
							_tile1.door[2,1] = global.connection_color;
						
							_tile2.door[0,0] = hatch.filled;
							_tile2.door[0,1] = global.connection_color;
						}
					
						if (connection_yy > connection_yy2) { // room2 above room1
						_tile1.door[0,0] = hatch.filled;
						_tile1.door[0,1] = global.connection_color;
						
						_tile2.door[2,0] = hatch.filled;
						_tile2.door[2,1] = global.connection_color;
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
		
		case tool.marker_tool: {
			//if (_tile.main == ID.filled) {
				if (mLeft) {
					_tile.mrk = selected_marker;
					_tile.mrk_c	= global.marker_color;
				}
				if (mRight) _tile.mrk = marker.empty;
			//}
			break; }
			
		case tool.hammer: {
			
			var _subimg = _tile.subimg;
			if (mLeftPressed) {
				
				//hammering something
				if (_subimg == 10) _tile.subimg = 16;
				if (_subimg == 6) _tile.subimg = 17;
				if (_subimg == 5) _tile.subimg = 18;
				if (_subimg == 9) _tile.subimg = 19;
				if (_subimg == 12) _tile.subimg = 20;
				if (_subimg == 3) _tile.subimg = 21;
				
				//unhammering something
				if (_subimg == 16) _tile.subimg = 10;
				if (_subimg == 17) _tile.subimg = 6;
				if (_subimg == 18) _tile.subimg = 5;
				if (_subimg == 19) _tile.subimg = 9;
				if (_subimg == 20) _tile.subimg = 12;
				if (_subimg == 21) _tile.subimg = 3;
				
			}
			
			break; }
			
		case tool.selector: {
			if (mRightPressed) {
				sel_x1 = -1;
				sel_x2 = -1;
				sel_y1 = -1;
				sel_y2 = -1;
				selected = false;
			}
			
			if (!mLeft) break;
			
			if (!selected || !(global.xx >= sel_x1 && global.yy >= sel_y1 && global.xx < sel_x2 && global.yy < sel_y2)) { //selection
				if (mLeftPressed) {
					selected = false;
					sel_x1 = global.xx;
					sel_y1 = global.yy;
					sel_x2 = global.xx+1;
					sel_y2 = global.yy+1;
					sel_start_x = global.xx;
					sel_start_y = global.yy;
				}
				if (click_moved) {
					if (global.xx >= sel_start_x) {
						sel_x2 = global.xx + 1;
						sel_x1 = sel_start_x;
					}
					if (global.yy >= sel_start_y) {
						sel_y2 = global.yy + 1;
						sel_y1 = sel_start_y;
					}
					if (global.xx < sel_start_x) {
						sel_x1 = global.xx;
						sel_x2 = sel_start_x + 1;
					}
					if (global.yy < sel_start_y) {
						sel_y1 = global.yy;
						sel_y2 = sel_start_y + 1;
					}
				
				}
			} else { //moving of selection
				if (mLeftPressed) {
					moving_sel = true;
					remove_tiles(sel_x1, sel_y1, sel_x2 - sel_x1, sel_y2 - sel_y1);
					move_x = global.xx;
					move_y = global.yy;
					sel_start_x = sel_x1;
					sel_start_y = sel_y1;
					sel_start_x2 = sel_x2;
					sel_start_y2 = sel_y2;
				}
				
				if (click_moved) {
					sel_x1 = sel_start_x + (global.xx - move_x);
					sel_y1 = sel_start_y + (global.yy - move_y);
					sel_x2 = sel_start_x2 + (global.xx - move_x);
					sel_y2 = sel_start_y2 + (global.yy - move_y);
				}
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
if (mLeftReleased || mRightReleased) {
	click_moved = false;
	
	if (current_tool == tool.selector && sel_x1 != -1 && !moving_sel) {
		selected = true;
		select_tiles(sel_x1, sel_y1, sel_x2 - sel_x1, sel_y2 - sel_y1);
	}
	if (moving_sel) {
		moving_sel = false;
		place_tiles(sel_x1, sel_y1);
	}
}

if (current_tool != tool.selector) {
	selected = false;
}

//deactivating buttons
if (placed_tile || deleted_tile) {
	
	color_button.deactivate();
	igmenu_button.deactivate();
	
} else if (current_menu == menu_state.nothing) {
	
	color_button.activate();
	igmenu_button.activate();
	
	resize_neg_up_button.activate();
	resize_pos_up_button.activate();
	resize_neg_left_button.activate();
	resize_pos_left_button.activate();
	resize_neg_down_button.activate();
	resize_pos_down_button.activate();
	resize_neg_right_button.activate();
	resize_pos_right_button.activate();
	
}
	
//quick tool swap
//swaps between the latest tool and the color picker
if (kAltPressed) {
	old_tool = current_tool;
	on_old_tool = false;
}
if (kAlt && !adding_connection) current_tool = tool.eyedropper;
if (!kAlt && !on_old_tool) {
	current_tool = old_tool;
	on_old_tool = true;
}
if (!kAlt && on_old_tool) {
	old_tool = current_tool;
}
	
#endregion


#region keybinds
//keybinds to quickly switch between tools
if (kLetterP) current_tool = tool.pen;
if (kLetterB) current_tool = tool.color_brush;
if (kLetterC && !kCtrl) current_tool = tool.door_tool;
if (kLetterM) current_tool = tool.marker_tool;
if (kLetterH) current_tool = tool.hammer;
//if (kLetterS && !kCtrl) current_tool = tool.selector;

//keybind to quickly toggle menu or discard color
if (kEscPressed) {
	if (current_menu == menu_state.nothing) {
		canBuild = false;
		in_menu = true;
		open_menu();
	}
	else if (current_menu == menu_state.ig_menu) close_menu = true;
	else if (current_menu == menu_state.color_menu) color_declined();
	else if (current_menu == menu_state.save_menu) save_confirmed();
	else if (current_menu == menu_state.settings_menu) settings_declined();
}

//keybind to accept color
if (kEnterPressed && current_menu == menu_state.color_menu) color_confirmed();

//keybind to quickly save/load or get to color menu
if (kCtrl && current_menu != menu_state.color_menu) {
	
	if (kLetterSPressed && current_menu != menu_state.save_menu) {
		
		if (global.map_dir == "") {
			save_menu();
			in_menu = true;
			canBuild = false;
		} else {
			save_map(global.map_dir);
		}
	}
	else if (kLetterL) load_room();
	
	//only open color menu, if we are tile creation
	else if (kLetterC && current_menu == menu_state.nothing) {
		canBuild = false;
		in_menu = true;
		open_color_menu();
	}
}
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
	
//reaching goal pos
tileset_x = lerp(tileset_x, tileset_goal_x, 0.30);

#endregion


#region buttons

//color button transparency
if (!color_button.active && current_menu == menu_state.nothing) {
	
	//button middle coords
	var _pointX = color_button.x + (sprite_get_width(color_button.sprite_index) / 2);
	var _pointY = color_button.y + (sprite_get_height(color_button.sprite_index) / 2);
	var m_distance = point_distance(_pointX, _pointY, global.mouse_pos_x, global.mouse_pos_y);
	color_button.goal_alpha = clamp((0.0035157 * power(m_distance,2) + 10) / 100, 0, 1);
	
} else if (current_menu == menu_state.nothing) {
	
	color_button.goal_alpha = 1;
	
}

//ig menu button transparency
if (!igmenu_button.active && current_menu == menu_state.nothing) {
	
	//button middle coords
	var _pointX = igmenu_button.x + (sprite_get_width(igmenu_button.sprite_index) / 2);
	var _pointY = igmenu_button.y + (sprite_get_height(igmenu_button.sprite_index) / 2);
	var m_distance = point_distance(_pointX, _pointY, global.mouse_pos_x, global.mouse_pos_y);
	igmenu_button.goal_alpha = clamp((0.0135157 * power(m_distance,2) + 10) / 100, 0, 1);
	
} else if (current_menu == menu_state.nothing) {
	
	igmenu_button.goal_alpha = 1;
	
}

#region door color buttons
if ((current_tool == tool.door_tool) || (old_tool == tool.door_tool && kAlt)) && (current_menu != menu_state.color_menu) {
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
	blue_door_button.deactivate();
	red_door_button.disable();
	red_door_button.deactivate();
	green_door_button.disable();
	green_door_button.deactivate();
	yellow_door_button.disable();
	yellow_door_button.deactivate();
	
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

//updating button positions to accommodate
color_button.setpos(tile_size / 2, global.view_height - tile_size / 2 - sprite_get_height(spr_color_button));
discord_button.setpos(global.view_width - 80, global.view_height - 80);
github_button.setpos(global.view_width - 80 - 72, global.view_height - 80);
settings_button.goal_x = global.view_width - 80 - 72 * 2;
save_button.goal_x = global.view_width - 80 - 72;
load_button.goal_x = global.view_width - 80


#endregion


#region menus

//reacting to button
var _selected_button = button_check();
if (mLeftPressed) {
	if ((_selected_button != 0) && (_selected_button.button_enabled && _selected_button.active)) {
		canBuild = false;
		in_menu = true;
	
		switch (_selected_button) {
			
			//color menu
			case color_button: {
			
				open_color_menu();
				break; }
			case rgb_code_selection: {
			
				var _val = get_string("", string_delete(selected_rgb_hex, 1, 1));
				if (string_length(_val) > 6) {
					add_text_message("Invalid HEX value!", 2, c_yellow);
					break;
				}
				
				var _dec = hex_to_dec(_val);
				set_color_values(make_color_rgb(_dec >> 16, (_dec >> 8) & $FF, _dec & $FF));
				_val = string_delete(selected_rgb_hex, 1, 1);
				add_text_message("Set #" + string(_val) + " as color", 1.5, c_white);
			
				break; }
			case color_decline_button: {
				
				color_declined();
				
				break; }
			case color_confirm_button: {
				
				color_confirmed();
				
				break; }
			
			//menu
			case igmenu_button: {
			
				open_menu();
			
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
			//case selection_tool_button: {
				//current_tool = tool.selector;
				//break; }
			case hammer_tool_button: {
				current_tool = tool.hammer;
				break; }
			case save_button: {
				
				save_menu();
				
				break; }
			case load_button: {
				
				load_room();
				
				break; }
			case discord_button: {
				url_open("https://discord.gg/n6ZCB3JkNb");
				break; }
			case github_button: {
				url_open("https://github.com/ConConner/ConConsMapMapper")
				break; }
			
			//settings
			case settings_button: {
				open_settings_menu();
				break; }
			case settings_confirm_button: {
				settings_confirmed();
				break; }
			case settings_decline_button: {
				settings_declined();
				break; }
			case settings_toggle_tooltips: {
				setting_show_tooltips = !setting_show_tooltips;
				break; }
			case settings_toggle_grid: {
				setting_show_grid = !setting_show_grid;
				break; }
			case settings_toggle_cursor: {
				setting_show_cursor = !setting_show_cursor;
				break; }
			
			//save menu
			case save_confirm_button: {
				save_confirmed();
				break;}
			case save_mf_button: {
				save_mf_exporting();
				break; }
			case save_png_button: {
				save_png_exporting();
				break; }
			case save_xml_button: {
				save_xml_exporting();
				break; }
			
			//resize ///TO DO: CHECK IF IT WILL BE BIGGER THAN MAX AND DONT MOVE CAM AND SEND MESSAGE
			case resize_neg_up_button: {
				in_menu = false;
				canBuild = true;
				
				if (global.grid_height != max_grid_height) {
					global.grid_height ++;
					ds_grid_resize(global.tile_grid, global.grid_width, global.grid_height);
					shift_grid_y_pos(global.tile_grid);
					set_up_grid();
				} else add_text_message("map cannot be bigger than " + string(max_grid_width) + " x " + string(max_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_pos_up_button: {
				in_menu = false;
				canBuild = true;
				
				if (global.grid_height != min_grid_height) {
					shift_grid_y_neg(global.tile_grid);
					global.grid_height --;
					ds_grid_resize(global.tile_grid, global.grid_width, global.grid_height);
					set_up_grid();
				} else add_text_message("map cannot be smaller than " + string(min_grid_width) + " x " + string(min_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_neg_left_button: {
				in_menu = false;
				canBuild = true;
			
				if (global.grid_width != max_grid_width) {
					global.grid_width ++;
					ds_grid_resize(global.tile_grid, global.grid_width, global.grid_height);
					shift_grid_x_pos(global.tile_grid);
					set_up_grid();
				} else add_text_message("map cannot be bigger than " + string(max_grid_width) + " x " + string(max_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_pos_left_button: {
				in_menu = false;
				canBuild = true;
				
				if (global.grid_width != min_grid_width) {
					shift_grid_x_neg(global.tile_grid);
					global.grid_width --;
					ds_grid_resize(global.tile_grid, global.grid_width, global.grid_height);
					set_up_grid();
				} else add_text_message("map cannot be smaller than " + string(min_grid_width) + " x " + string(min_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_neg_down_button: {
				
				in_menu = false;
				canBuild = true;
				
				if (global.grid_height != max_grid_height) {
					global.grid_height ++;
				
					global.cam_pos_y += tile_size;
				} else add_text_message("map cannot be bigger than " + string(max_grid_width) + " x " + string(max_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_pos_down_button: {
				
				in_menu = false;
				canBuild = true;
				
				if (global.grid_height != min_grid_height) {
					global.grid_height --;
				
					global.cam_pos_y -= tile_size;
				} else add_text_message("map cannot be smaller than " + string(min_grid_width) + " x " + string(min_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_neg_right_button: {
				
				in_menu = false;
				canBuild = true;
				
				if (global.grid_width != max_grid_width) {
					global.grid_width ++;
				
					global.cam_pos_x += tile_size;
				} else add_text_message("map cannot be bigger than " + string(max_grid_width) + " x " + string(max_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			case resize_pos_right_button: {
				
				in_menu = false;
				canBuild = true;
				
				if (global.grid_width != min_grid_width) {
					global.grid_width --;
				
					global.cam_pos_x -= tile_size;
				} else add_text_message("map cannot be smaller than " + string(min_grid_width) + " x " + string(min_grid_height) + "!", 1.5, c_yellow);
				
				break; }
			
			//doors
			case blue_door_button: {
				in_menu = false;
				canBuild = true;
				global.connection_color = make_color_rgb(0,0,255);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case red_door_button: {
				in_menu = false;
				canBuild = true;
				global.connection_color = make_color_rgb(255,0,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case green_door_button: {
				in_menu = false;
				canBuild = true;
				global.connection_color = make_color_rgb(0,255,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
			case yellow_door_button: {
				in_menu = false;
				canBuild = true;
				global.connection_color = make_color_rgb(255,255,0);
				add_text_message("applied color", 1.5, c_lime);
				break; }
				
			default: {
				break;
			}
			
		}
	}
}

#endregion


#region grid resize
//clamping the grid sizes
global.grid_width = clamp(global.grid_width, min_grid_width, max_grid_width);
global.grid_height = clamp(global.grid_height, min_grid_height, max_grid_height);

//resizing the grid if grid dimensions change
if (old_grid_width != global.grid_width || old_grid_height != global.grid_height) {
	old_grid_width = global.grid_width;
	old_grid_height = global.grid_height;
	
	ds_grid_resize(global.tile_grid, global.grid_width, global.grid_height);
	set_up_grid();
}
#endregion


#region debug

if (kF12) debug_on = !debug_on;

if (debug_on) {
}

#endregion