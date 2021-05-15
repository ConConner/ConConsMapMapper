//mapper information
#macro current_version "1.0"

//declaring globals
//grid globals
global.grid_width = 32;			//amount of cells horizontally /			in the usable tile grid
global.grid_height = 32;		//							   / vertically	

//maximum possible map size without any errors: 1476 x 1476
//stack overflow before 2000 x 2000
//these sizes cant be saved...

global.xx = floor(mouse_x/32);			//the x position of the mouse on the grid
global.yy = floor(mouse_y/32);			//the y position of the mouse on the grid

#region tile globals
global.roomCount = 0;

	//wheel variables
	  //color wheel
	  global.max_color_scale = 0.6;
	  global.min_color_scale = 0;
	  global.color_wheel_radius = 400 * global.max_color_scale;
	  global.color_wheel_min_radius = 8 * global.max_color_scale;
	  global.color_wheel_alpha = 0.8
	  
	  //door/marker wheel
	  global.max_door_scale = 1;
	  global.min_door_scale = 0;
	  global.marker_wheel_radius = 200 * global.max_door_scale;
	  global.marker_wheel_min_radius = 39 * global.max_door_scale;
	  global.door_wheel_radius = 400 * global.max_door_scale;
	  global.door_wheel_min_radius = 224 * global.max_door_scale;
	  global.door_wheel_alpha = 0.8;
#endregion


#region CAMERA SETUP

//display vars
global.display_width = display_get_width();
global.display_height = display_get_height();
#macro display_half_w (global.display_width / 2)
#macro display_half_h (global.display_height / 2)

//window vars
global.window_width = window_get_width();
global.window_height = window_get_height();
old_window_width = global.window_width;
old_window_height = global.window_height;

global.window_scale = 1;

//camera vars
global.view_width = 800;
global.view_height = 800;

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

//boolean
canBuild = true;
choosing_tile_addition = false;
placed_tile = false;
deleted_tile = false;
selecting_tile = false;
cam_lock = false;
click_moved = false;
moving_with_mouse = false;

adjust_cursor = false;
adding_connection = false;


debug_on = false;

//var = X
old_roomCount = 0;

click_xx = 0;
click_yy = 0;

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

//menu vars
current_menu = menu_state.nothing;
current_tool = tool.pen;
old_tool = current_tool;
in_menu = false;

show_tooltips = true;

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

selected_color_hue = color_get_hue(global.selected_color);
selected_color_sat = color_get_saturation(global.selected_color);
selected_color_val = color_get_value(global.selected_color);
selected_rgb_hex = get_hex_rgb(global.selected_color);

//other
selected_map = "unsaved";

//creating surface
door_surface = noone;


#region setting up the data structures

//creating the tile_info
tile_info = function(_main, _rm_nmb, _col, _subimg, _mrk, _door) constructor {
	
	//different tile layers
	main = _main;																					//stores if a tile is set or not
	rm_nmb = _rm_nmb;																				//stores the room number of the tile
	col = _col;																						//stores the tiles color
	subimg = _subimg;																				//stores the main tile subimage
	mrk = _mrk;																						//stores the subimage for the marker on that tile
	door = _door																					//Doors are set up as [Door One[color ,rot] Door Two[color,rot]....
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
	
//button list
global.button_list = ds_list_create();
#endregion


#region buttons

//main Buttons
color_button = make_button(tile_size / 2, (global.view_height - tile_size / 2) - sprite_get_height(spr_color_button), spr_color_button, menu_state.nothing);
igmenu_button = make_button(tile_size / 2, 4, spr_open_igmenu, menu_state.nothing);

//ig menu buttons
pen_tool_button = make_button(16, -10, spr_pen_tool, menu_state.ig_menu);
eyedropper_tool_button = make_button(16 + 72 * 1, -10, spr_eyedropper_tool, menu_state.ig_menu);
color_brush_tool_button = make_button(16 + 72 * 2, -10, spr_color_brush, menu_state.ig_menu);
door_tool_button = make_button(16 + 72 * 3, -10, spr_door_tool, menu_state.ig_menu);
marker_tool_button = make_button(16 + 72 * 4, -10, spr_marker_tool, menu_state.ig_menu);
selection_tool_button = make_button(16 + 72 * 5, -10, spr_selection_tool, menu_state.ig_menu);
save_button = make_button(global.window_width - 80 - 72, -10, spr_save, menu_state.ig_menu);
load_button = make_button(global.window_width - 80, -10, spr_load, menu_state.ig_menu);

tooltip_button = make_button(32, global.window_height - 32, spr_cursor_selector, menu_state.ig_menu);

//door color buttons
blue_door_button = make_button(16, 400, spr_door_colors, menu_state.nothing);
blue_door_button.disable();
red_door_button = make_button(16, 400, spr_door_colors, menu_state.nothing);
red_door_button.disable();
green_door_button = make_button(16, 400, spr_door_colors, menu_state.nothing);
green_door_button.disable();
yellow_door_button = make_button(16, 400, spr_door_colors, menu_state.nothing);
yellow_door_button.disable();


#endregion

//creating the cursor
instance_create_layer(mouse_x,mouse_y,"Cursor",obj_cursor);

cool_sprite = noone;