xx = floor (mouse_x/32);
yy = floor(mouse_y/32);


//adding with mouse

//adding markers
if (did_hold && !choosingMarker && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
		
	instance_destroy(obj_cursor);
	cursor_spawned = false;
	did_hold = false;
		
	canBuild = false;
	choosingMarker = true;
	var storeX = xx
	var storeY = yy
		
	var button1 = instance_create_layer(storeX * 32 - 32, storeY * 32 + 16, "Markers", obj_marker_button1);
	var button2 = instance_create_layer(storeX * 32 - 32, storeY * 32 - 16, "Markers", obj_marker_button2);
	var button3 = instance_create_layer(storeX * 32, storeY * 32 - 32, "Markers", obj_marker_button3);
	var button5 = instance_create_layer(storeX * 32 + 32, storeY * 32 + 16, "Markers", obj_marker_button5);
	var button4 = instance_create_layer(storeX * 32 + 32, storeY * 32 - 16, "Markers", obj_marker_button4);
	var button6 = instance_create_layer(storeX * 32, storeY * 32 + 32, "Markers", obj_marker_button6);
	#region //setting x/y coordinates for buttons
	button1.gridX = xx;
	button1.gridY = yy;
	button2.gridX = xx;
	button2.gridY = yy;
	button3.gridX = xx;
	button3.gridY = yy;
	button4.gridX = xx;
	button4.gridY = yy;
	button5.gridX = xx;
	button5.gridY = yy;
	button6.gridX = xx;
	button6.gridY = yy;
	#endregion
}
	
//adding doors
if (canBuild && !did_hold && mLeftReleased && !placed_tile && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
	ds_grid_set(global.DoorGrid, xx, yy, ds_grid_get(global.DoorGrid,xx,yy) + 1);
	if (ds_grid_get(global.DoorGrid,xx,yy) == 5) ds_grid_set(global.DoorGrid, xx, yy ,0);
}
	
//editing rooms
if (!did_hold && ds_grid_get(global.mainGrid, xx, yy) = ID.filled && canBuild) {
	global.roomCount = ds_grid_get(global.RoomGrid,xx,yy);
}
	
//adding tiles
if (mLeft && ds_grid_get(global.mainGrid, xx, yy) = ID.empty && canBuild) {
		
	ds_grid_set(global.mainGrid, xx,yy,ID.filled);
	ds_grid_set(global.RoomGrid, xx,yy,global.roomCount);
	ds_grid_set(global.ColorGrid, xx,yy,global.currentColor);
	ds_grid_set(global.SubimgGrid, xx,yy,autotile(xx,yy));
	ds_grid_set(global.SubimgGrid, xx,yy - 1,autotile(xx,yy - 1));
	ds_grid_set(global.SubimgGrid, xx,yy + 1,autotile(xx,yy + 1));
	ds_grid_set(global.SubimgGrid, xx - 1,yy,autotile(xx - 1,yy));
	ds_grid_set(global.SubimgGrid, xx + 1,yy,autotile(xx + 1,yy));
	cursor_spawned = false;
	instance_destroy(obj_cursor);
	placed_tile = true;
}


//removing with mouse
	
if (mRight && canBuild && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
		
	ds_grid_set(global.mainGrid, xx,yy,ID.empty);
	ds_grid_set(global.RoomGrid, xx,yy, 0);
	ds_grid_set(global.SubimgGrid, xx,yy - 1,autotile(xx,yy - 1));
	ds_grid_set(global.SubimgGrid, xx,yy + 1,autotile(xx,yy + 1));
	ds_grid_set(global.SubimgGrid, xx - 1,yy,autotile(xx - 1,yy));
	ds_grid_set(global.SubimgGrid, xx + 1,yy,autotile(xx + 1,yy));
	cursor_spawned = false;
	instance_destroy(obj_cursor);
	global.roomCount ++;
}



////adding with cursor
//if (cPlace && canBuild && isCursor && instance_exists(obj_cursor)) && (ds_grid_get(global.mainGrid, global.cX, global.cY) = ID.empty) {
//	ds_grid_set(global.mainGrid, global.cX,global.cY,global.currentSelection);
//	ds_grid_set(global.RoomGrid, global.cX,global.cY,global.roomCount);
//	ds_grid_set(global.ColorGrid, global.cX,global.cY,global.currentColor);
//}


////removing with cursor
//if (cRemove && canBuild && isCursor && instance_exists(obj_cursor)) {
//	ds_grid_set(global.mainGrid, global.cX,global.cY,ID.empty);
//	ds_grid_set(global.RoomGrid, global.cX,global.cY, 0);
//	ds_grid_set(global.ColorGrid, global.cX,global.cY,1);
//}

surface_free(map_surface);