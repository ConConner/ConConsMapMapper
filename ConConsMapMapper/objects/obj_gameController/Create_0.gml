//setting variables
global.grid_size = room_width / 32;
global.roomCount = 0;
global.currentColor = c.blue;
global.cX = 12;
global.cY = 12;

cursor_spawned = false;
canBuild = true;
choosingMarker = false;
choosingColor = false;
choosingDoor = false;
did_hold = false;
placed_tile = false;
cUpTimer = 0;
cDownTimer = 0;
cLeftTimer = 0;
cRightTimer = 0;
cNextRoomTimer = 0;
mLeftTimer = 0;
old_roomCount = 0;
storeX = 0;
storeY = 0;
subimg = 0;

//creating surface
main_surface = noone;
door_surface = noone;

view_width = camera_get_view_width(view_camera[0]);
view_height = camera_get_view_height(view_camera[0]);


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