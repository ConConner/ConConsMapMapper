//declaring globals
//grid globals
global.grid_width = 60;			//amount of cells horizontally /			in the usable tile grid
global.grid_height = 34;		//							   / vertically	

global.xx = floor(mouse_x/32);			//the x position of the mouse on the grid
global.yy = floor(mouse_y/32);			//the y position of the mouse on the grid

#region tile globals
global.roomCount = 0;
global.selected_color = make_color_rgb(0,105,170);

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

#endregion

//boolean
canBuild = true;
choosing_tile_addition = false;
placed_tile = false;
deleted_tile = false;
selecting_tile = false;
cam_lock = false;
click_moved = false;

right_click_menu_close = false;
left_click_menu_close = false;

debug_on = false;

//var = X
old_roomCount = 0;
colorSelecting = 0;

remove_marker_goal_alpha = 1;
remove_marker_cur_alpha = 1;
selected_edge_goal_alpha = 1;
selected_edge_cur_alpha = 1;

click_xx = 0;
click_yy = 0;

	//selecting tiles
tile_xscale = 1;
tile_xscale_goal = 1;
tile_yscale = 1;
tile_yscale_goal = 1;

tile_xx = -1;
tile_yy = -1;

door_menu_open_timer = 0;
door_menu_close_timer = 0;
selection_open_timer = 0;

		//selecting edge
selected_edge = dir.none;
clicked_selected_edge = dir.none;
old_selected_edge = selected_edge;
edge_size = 10;


	//buttons
	 //color wheel
buttonBlue = 0
buttonAqua = 0
buttonGreen = 0
buttonYellow = 0
buttonOrange = 0
buttonRed = 0
buttonGray = 0
buttonPurple = 0

	 //marker
buttonMarker1 = 0;
buttonMarker2 = 0;
buttonMarker3 = 0;
buttonMarker4 = 0;
buttonMarker5 = 0;
buttonMarker6 = 0;

	 //door
buttonDoorBlue = 0;
buttonDoorRed = 0;
buttonDoorGreen = 0;
buttonDoorYellow = 0;

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
																									
	static clear = function() {																		////////////////////////////////////////////////
		main = ID.empty;																			//											  //
		rm_nmb = 0;																					// This function resets a tiles values to the //
		col = 0;																					// cleared state. Easy way to clear a tile    //
		subimg = 0;																					// completely of all values                   //
		mrk = marker.empty;																			//											  //
		door = [[hatch.empty, 0],[hatch.empty, 90],[hatch.empty, 180],[hatch.empty, 270]]			////////////////////////////////////////////////
	}
	
}


//creating the grid
global.tile_grid = ds_grid_create(global.grid_width, global.grid_height); 
ds_grid_set_region(global.tile_grid, 0, 0, global.grid_width, global.grid_height, 0);
set_up_grid()

//text grid
global.text_grid = ds_grid_create(20,3);
ds_grid_set_region(global.text_grid, 0, 0, 19, 2, 0);


//BUTTONS
//button struct
button_create = function(_x, _y, _spr) constructor {
	
	//button vars
	x = _x;
	y = _y;
	goal_x = _x;
	goal_y = _y;
	goal_alpha = 1;
	sprite_index = _spr;
	image_index = 0;
	image_alpha = goal_alpha;
	button_width = sprite_get_width(sprite_index);
	button_height = sprite_get_height(sprite_index);
	
	active = true;
	
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
	static draw = function() {
		draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, image_alpha);
	}
	static activate = function() {
		active = true;
	}
	static deactivate = function() {
		active = false;
	}
}
	
//button list
global.button_list = ds_list_create();

color_button = make_button(tile_size / 2, (global.view_height - tile_size / 2) - sprite_get_height(spr_color_button), spr_color_button);

#endregion

instance_create_layer(mouse_x,mouse_y,"Cursor",obj_cursor);