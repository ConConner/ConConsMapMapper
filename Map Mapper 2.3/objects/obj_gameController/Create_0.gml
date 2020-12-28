//setting variables
global.grid_size = room_width / tile_size;
global.roomCount = 0;
global.currentColor = c.blue;
global.cX = 12;
global.cY = 12;
	
	//wheel variables
	  //color wheel
	  global.max_color_scale = 0.6;
	  global.min_color_scale = 0;
	  global.color_wheel_radius = 400 * global.max_color_scale;
	  global.color_wheel_min_radius = 8 * global.max_color_scale;
	  global.color_wheel_alpha = 0.8

//boolean
cursor_spawned = false;
canBuild = true;
choosingMarker = false;
choosingColor = false;
choosingDoor = false;
did_hold = false;
placed_tile = false;

//XX = 0
mLeftTimer = 0;
old_roomCount = 0;
storeX = 0;
storeY = 0;
subimg = 0;
colorSelecting = 0;
storeMouseX = 0;
storeMouseY = 0;

//buttons
buttonBlue = 0
buttonAqua = 0
buttonGreen = 0
buttonYellow = 0
buttonOrange = 0
buttonRed = 0
buttonGray = 0
buttonPurple = 0

//other
selected_map = "unsaved";

//creating surface
main_surface = noone;
door_surface = noone;


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

instance_create_layer(0,0,"Cursor",obj_cursor);