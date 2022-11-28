//mapper information
#macro current_version "B2.2"
#macro save_system_version "1.1" //this version is referencing the version of the save system. NOT the mapper version

//declaring globals
//grid globals
global.grid_width = 20;			//amount of cells horizontally /			in the usable tile grid
global.grid_height = 20;		//							   / vertically	
old_grid_width = global.grid_width;
old_grid_height = global.grid_height;

min_grid_width = 1;
min_grid_height = 1;
max_grid_width = 500;
max_grid_height = 500;

//mouse
global.mouse_pos_x = device_mouse_x_to_gui(0);			//mouse position relative to the GUI
global.mouse_pos_y = device_mouse_y_to_gui(0);			//
global.xx = floor(global.mouse_pos_x/32);			//the x position of the mouse on the grid
global.yy = floor(global.mouse_pos_y/32);			//the y position of the mouse on the grid

//other
global.roomCount = 0;
global.map_dir = "";


#region CAMERA SETUP

//display vars
global.display_width = display_get_width();
global.display_height = display_get_height();

//window vars
global.window_width = window_get_width();
global.window_height = window_get_height();
global.old_window_width = global.window_width;
global.old_window_height = global.window_height;

global.window_scale = 1;

//camera vars
global.view_width = obj_camera.view_width;
global.view_height = obj_camera.view_height;

global.grid_view_width = global.grid_width * tile_size;
global.grid_view_height = global.grid_height * tile_size;

global.cam_pos_x = 0;
global.cam_pos_y = 0;
global.cam_goal_x = 0;
global.cam_goal_y = 0;
	//mouse movement
start_mouse_x = 0;
start_mouse_y = 0;
start_cam_x = 0;
start_cam_y = 0;

#endregion


#region declaring other vars
//user vars
show_grid = true;
show_tooltips = true;
show_cursor = true;

	//settings
setting_show_grid = show_grid;
setting_show_tooltips = show_tooltips;
setting_show_cursor = show_cursor;

//boolean
canBuild = true;
placed_tile = false;
deleted_tile = false;
cam_lock = false;
click_moved = false;
moving_with_mouse = false;
adjust_cursor = false;
adding_connection = false;
debug_on = false;
on_old_tool = false;

//var = X
old_roomCount = 0;
click_xx = 0;
click_yy = 0;

	//marker vars
marker_url = default_markers;
marker_sprite = spr_default_markers;
checking_sprite = noone;
tileset_goal_x = global.view_width + 10;
tileset_x = tileset_goal_x;
tile_amount = default_tile_amount;
tiles_per_page = 0;
max_pages = 0;
tile_page = 0;
selected_marker = 0;

	//connection vars
connection_xx = 0;
connection_yy = 0;
connection_xx2 = 0;
connection_yy2 = 0;

//button = 0;
color_button = 0;
hue_selection = 0;
value_selection = 0;
rgb_code_selection = 0;
color_decline_button = 0;
color_confirm_button = 0;
selection_tool_button = 0;
save_confirm_button = 0;
save_mf_button = 0;
save_png_button = 0;
save_xml_button = 0;
settings_confirm_button = 0;
settings_decline_button = 0;
settings_toggle_grid = 0;
settings_toggle_tooltips = 0;
settings_toggle_cursor = 0;

//menu vars
current_menu = menu_state.nothing;
current_tool = tool.pen;
old_tool = current_tool;
in_menu = false;

close_menu = false;

menu_pos_x = global.view_width / 2;
menu_pos_y = global.view_height / 2;
menu_width = tile_size * 4;
menu_height = tile_size * 4;

menu_goal_pos_x = global.view_width / 2;
menu_goal_pos_y = global.view_height / 2;
menu_goal_width = tile_size * 4;
menu_goal_height = tile_size * 4;

menu_drawing_alpha = 0;
menu_drawing_goal_alpha = 0;
background_alpha = 0;
background_goal_alpha = 0;

//color vars
global.selected_color = make_color_rgb(0,105,170);
global.connection_color = c_blue;
global.marker_color = c_white;

old_color = global.selected_color;
selected_color_hue = 0;
selected_color_sat = 0;
selected_color_val = 0;
selected_rgb_hex = 0;
#endregion


#region setting up the data structures

//creating the tile_info
tile_info = function(_main, _rm_nmb, _col, _subimg, _mrk, _door) constructor {
	
	//different tile layers
	main = _main;												//stores if a tile is set or not
	rm_nmb = _rm_nmb;											//stores the room number of the tile
	col = _col;													//stores the tiles color
	subimg = _subimg;											//stores the main tile subimage
	mrk = _mrk;													//stores the subimage for the marker on that tile
	door = _door												//Doors are set up as: I dont remember, sorry :(
	mrk_c = c_white;											//Color of the placed marker tile
	//Door 0 = up; Door 1 = down; Door 2 = down; Door 3 = left;
	
	
}


//creating the grid
global.tile_grid = ds_grid_create(global.grid_width, global.grid_height); 
ds_grid_set_region(global.tile_grid, 0, 0, global.grid_width, global.grid_height, 0);
set_up_grid()

//text grid
#macro max_text_amount 7
global.text_grid = ds_grid_create(max_text_amount,4);
ds_grid_set_region(global.text_grid, 0, 0, max_text_amount, 4, 0);

//tooltip setup
setup_tool_tips();
	
//button list
global.button_list = ds_list_create();

//BUTTONS
//button struct
button_create = function(_x, _y, _spr, _menu_level) constructor {
	
	//button vars
	x = _x;
	y = _y;
	goal_x = _x;
	goal_y = _y;
	goal_alpha = 1;
	sprite_index = _spr;
	image_index = 0;
	image_alpha = 0;
	button_width = sprite_get_width(sprite_index);
	button_height = sprite_get_height(sprite_index);
	menu_level = _menu_level
	
	active = true;
	button_enabled = true;
	
	//functions
	static setpos = function(newx, newy) {
		x = newx;
		y = newy;
		goal_x = newx;
		goal_y = newy;
	}
	static jmp = function() { //sets the button x/y coordinates to the goal position
		x = goal_x;
		y = goal_y;
	}
	static move = function() {	//moves the button to the goal position by 30% of the distance
		x = lerp(x, goal_x, 0.3);
		y = lerp(y, goal_y, 0.3);
	}
	static check = function(point_x, point_y) {	//checks if a point is on the button
		
		if (point_in_rectangle(point_x, point_y, x, y, x + button_width, y + button_height)) {
			return(true);
		} else return(false);
		
	}
	static fade = function() {	//fades current alpha to goal alpha
		image_alpha = lerp(image_alpha, goal_alpha, 0.3);
	}
	static draw = function() {  //draws the button
		draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, image_alpha);
	}
	static disable = function() {  //shuts off all button processes
		button_enabled = false;
	}
	static enable = function() {  //activates the button process again
		button_enabled = true;
	}
	static activate = function() { //makes the button usable
		active = true;
	}
	static deactivate = function() { //makes the button unuseable
		active = false;
	}
}
#endregion


#region button functions
//general functions
//opening the menu
open_menu = function() {
	current_menu = menu_state.ig_menu;
	menu_goal_pos_x = -32;
	menu_pos_x = -32;
	menu_goal_pos_y = -10;
	menu_pos_y = -10;
	menu_goal_height = 0;
	menu_height = 0;
}

//open settings menu
open_settings_menu = function() {
	
	current_menu = menu_state.settings_menu;
				
	//confirm, decline
	settings_decline_button = make_button(0,0,spr_menu_decline, menu_state.settings_menu);
	settings_decline_button.goal_alpha = 0;
	settings_decline_button.image_alpha = 0;
	settings_confirm_button = make_button(0,0,spr_menu_confirm, menu_state.settings_menu);
	settings_confirm_button.goal_alpha = 0;
	settings_confirm_button.image_alpha = 0;
	
	//settings buttons
	settings_toggle_tooltips = make_button(0, 0, spr_cursor_selector, menu_state.settings_menu);
	settings_toggle_grid = make_button(0, 0, spr_cursor_selector, menu_state.settings_menu);
	settings_toggle_cursor = make_button(0, 0, spr_cursor_selector, menu_state.settings_menu);
	
	//set setting variables
	setting_show_grid = show_grid;
	setting_show_tooltips = show_tooltips;
	setting_show_cursor = show_cursor;
}
settings_confirmed = function() {
	close_menu = true;
	
	//removing buttons
	remove_button(settings_decline_button);
	remove_button(settings_confirm_button);
	remove_button(settings_toggle_tooltips);
	remove_button(settings_toggle_grid);
	
	//applying settings
	show_grid = setting_show_grid;
	show_tooltips = setting_show_tooltips;
	show_cursor = setting_show_cursor;
	
	save_settings();
	add_text_message("saved settings", 1.5, c_lime);
}
settings_declined = function() {
	close_menu = true;
	
	//removing buttons
	remove_button(settings_decline_button);
	remove_button(settings_confirm_button);
	remove_button(settings_toggle_tooltips);
	remove_button(settings_toggle_grid);
	
	add_text_message("settings discarded", 1.5, c_white);
}

//save menu
save_menu = function() {

	current_menu = menu_state.save_menu;
	menu_drawing_goal_alpha = 0;
	menu_drawing_alpha = 0;

	//export buttons
	save_mf_button = make_button(0, 0, spr_cursor_selector, menu_state.save_menu);
	save_png_button = make_button(0, 0, spr_cursor_selector, menu_state.save_menu);
	save_xml_button = make_button(0, 0, spr_cursor_selector, menu_state.save_menu);

	//confirm
	save_confirm_button = make_button(0, 0, spr_menu_decline, menu_state.save_menu);
	save_confirm_button.goal_alpha = 0;
	save_confirm_button.image_alpha = 0;
}
save_confirmed = function() {
	
	close_menu = true;
	//removing all menu buttons
	remove_button(save_confirm_button);
	remove_button(save_mf_button);
	remove_button(save_png_button);
	remove_button(save_xml_button);
}
save_mf_exporting = function() {
	var fname = get_save_filename("Map File (.mf)|*"+".mf","");
	save_map(fname);
}
save_png_exporting = function() {
	var fname = get_save_filename("Image (.png)|*"+".png","");
	take_screenshot(fname);
}
save_xml_exporting = function() {
	var fname = get_save_filename("SMART (.xml)|*"+".xml","");
	save_map_smart(fname);
}

//bring up load dialog and load map
load_room = function() {
	var fname = get_open_filename("Map File (.mf)|*"+".mf","");
	if (load_map(fname)) close_menu = true;
}

//color menu
open_color_menu = function() {
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
	if (current_tool == tool.door_tool) set_color_values(global.connection_color);
	else if (current_tool == tool.marker_tool) set_color_values(global.marker_color);
	else set_color_values(global.selected_color);
}

function set_color_values(color, old=true) {	//sets the selected color values from an input color
	if (old) old_color = color;
	selected_color_hue = color_get_hue(color)
	selected_color_sat = color_get_saturation(color);
	selected_color_val = color_get_value(color);
	selected_rgb_hex = get_hex_rgb(color);
}

color_confirmed = function() {
	
	close_menu = true;
	//removing all the menu buttons
	remove_button(hue_selection);
	remove_button(value_selection);
	remove_button(rgb_code_selection);
	remove_button(color_decline_button);
	remove_button(color_confirm_button);
				
	//setting new colour
	var _color = make_color_hsv(selected_color_hue, selected_color_sat, selected_color_val);
	if (current_tool == tool.door_tool) global.connection_color = _color;
	else if (current_tool == tool.marker_tool) global.marker_color = _color;
	else global.selected_color = _color;
				
	//text message
	add_text_message("applied color", 1.5, c_lime);
}
color_declined = function() {
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
}
#endregion


#region buttons

//main Buttons
color_button = make_button(tile_size / 2, global.view_height - tile_size / 2 - sprite_get_height(spr_color_button), spr_color_button, menu_state.nothing);
igmenu_button = make_button(tile_size / 2, 4, spr_open_igmenu, menu_state.nothing);

//ig menu buttons
pen_tool_button = make_button(16, -10, spr_pen_tool, menu_state.ig_menu);
eyedropper_tool_button = make_button(16 + 72 * 1, -10, spr_eyedropper_tool, menu_state.ig_menu);
color_brush_tool_button = make_button(16 + 72 * 2, -10, spr_color_brush, menu_state.ig_menu);
door_tool_button = make_button(16 + 72 * 3, -10, spr_door_tool, menu_state.ig_menu);
marker_tool_button = make_button(16 + 72 * 4, -10, spr_marker_tool, menu_state.ig_menu);
//selection_tool_button = make_button(16 + 72 * 6, -10, spr_selection_tool, menu_state.ig_menu);
hammer_tool_button = make_button(16 + 72 * 5, -10, spr_hammer_tool, menu_state.ig_menu);
settings_button = make_button(global.view_width - 80 - 72 * 2, -10, spr_settings, menu_state.ig_menu);
save_button = make_button(global.view_width - 80 - 72, -10, spr_save, menu_state.ig_menu);
load_button = make_button(global.view_width - 80, -10, spr_load, menu_state.ig_menu);

discord_button = make_button(global.view_width - 80, global.view_height - 80, spr_discord_button, menu_state.ig_menu);
github_button = make_button(global.view_width - 80 - 72, global.view_height - 80, spr_github_button, menu_state.ig_menu);

#region resize buttons
resize_neg_up_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_neg_up_button.button_width = 32;
resize_neg_up_button.button_height = 32;

resize_pos_up_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_pos_up_button.button_width = 32;
resize_pos_up_button.button_height = 32;

resize_neg_left_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_neg_left_button.button_width = 32;
resize_neg_left_button.button_height = 32;

resize_pos_left_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_pos_left_button.button_width = 32;
resize_pos_left_button.button_height = 32;

resize_neg_right_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_neg_right_button.button_width = 32;
resize_neg_right_button.button_height = 32;

resize_pos_right_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_pos_right_button.button_width = 32;
resize_pos_right_button.button_height = 32;

resize_neg_down_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_neg_down_button.button_width = 32;
resize_neg_down_button.button_height = 32;

resize_pos_down_button = make_button(0, 0, spr_cursor_selector, menu_state.nothing);
resize_pos_down_button.button_width = 32;
resize_pos_down_button.button_height = 32;
#endregion


//door color buttons
blue_door_button = make_button(16, global.view_height / 2 - 130, spr_door_colors, menu_state.nothing);
blue_door_button.disable();
red_door_button = make_button(16, global.view_height / 2 - 65, spr_door_colors, menu_state.nothing);
red_door_button.disable();
green_door_button = make_button(16, global.view_height / 2, spr_door_colors, menu_state.nothing);
green_door_button.disable();
yellow_door_button = make_button(16, global.view_height / 2 + 65, spr_door_colors, menu_state.nothing);
yellow_door_button.disable();

#endregion


//creating the cursor
instance_create_layer(global.mouse_pos_x,global.mouse_pos_y,"Cursor",obj_cursor);

//loading settings
load_settings();