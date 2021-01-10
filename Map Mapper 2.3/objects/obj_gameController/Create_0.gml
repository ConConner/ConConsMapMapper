//setting variables
global.grid_size = room_width / tile_size;
global.roomCount = 0;
global.currentColor = c.blue;
global.xx = floor(mouse_x/32);
global.yy = floor(mouse_y/32);
	
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

//boolean
canBuild = true;
choosingColor = false;
choosing_tile_addition = false;
placed_tile = false;
selecting_tile = false;
cam_lock = false;
click_moved = false;

right_click_menu_close = false;
left_click_menu_close = false;

debug_on = false;

//var = X
old_roomCount = 0;
colorSelecting = 0;
storeMouseX = 0;
storeMouseY = 0;

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


#region grids
//creating grids
global.mainGrid = ds_grid_create(global.grid_size,global.grid_size);
global.SubimgGrid = ds_grid_create(global.grid_size,global.grid_size);
global.RoomGrid = ds_grid_create(global.grid_size,global.grid_size);
global.ColorGrid = ds_grid_create(global.grid_size,global.grid_size);
global.MarkerGrid = ds_grid_create(global.grid_size,global.grid_size);
global.DoorGrid = ds_grid_create(global.grid_size * 2,global.grid_size * 2);

//setting grid regions
ds_grid_set_region(global.mainGrid, 0, 0, global.grid_size - 1, global.grid_size - 1, 0);
ds_grid_set_region(global.SubimgGrid, 0, 0, global.grid_size - 1, global.grid_size - 1, 0);
ds_grid_set_region(global.RoomGrid, 0, 0, global.grid_size - 1, global.grid_size - 1, 0);
ds_grid_set_region(global.ColorGrid, 0, 0, global.grid_size - 1, global.grid_size - 1, 1);
ds_grid_set_region(global.MarkerGrid, 0, 0, global.grid_size - 1, global.grid_size - 1, 0);
ds_grid_set_region(global.DoorGrid, 0, 0, global.grid_size * 2 - 1, global.grid_size * 2 - 1, 0);

instance_create_layer(mouse_x,mouse_y,"Cursor",obj_cursor);
#endregion