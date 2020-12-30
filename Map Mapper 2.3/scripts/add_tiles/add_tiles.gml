function add_tiles() {
	xx = floor (mouse_x/32);
	yy = floor(mouse_y/32);


	//adding with mouse

	//adding markers
	if (did_hold && !choosingMarker && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
		
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
	
		button1.gridX = xx; button1.gridY = yy;		button2.gridX = xx; button2.gridY = yy;
		button3.gridX = xx; button3.gridY = yy;		button4.gridX = xx; button4.gridY = yy;
		button5.gridX = xx; button5.gridY = yy;		button6.gridX = xx; button6.gridY = yy;
	#endregion
	}
	
	//adding doors
	//if (canBuild && !did_hold && mLeftReleased && !placed_tile && !choosingDoor && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
	//	var mouseTileX = mouse_x - xx * 32;
	//	var mouseTileY = mouse_y - yy * 32;
	//	if !(mouseTileX > 7 && mouseTileX < 25 && mouseTileY > 7 && mouseTileY < 25) {
		
	//		canBuild = false;
	//		choosingDoor = true;
	
	//		var button1 = instance_create_layer(xx * 32 - 32, yy * 32 + 16, "Markers", obj_doorButton_blue);
	//		var button2 = instance_create_layer(xx * 32 - 32, yy * 32 - 16, "Markers", obj_doorButton_red);
	//		var button3 = instance_create_layer(xx * 32, yy * 32 - 32, "Markers", obj_doorButton_green);
	//		var button5 = instance_create_layer(xx * 32 + 32, yy * 32 + 16, "Markers", obj_doorButton_yellow);
	//		var button4 = instance_create_layer(xx * 32 + 32, yy * 32 - 16, "Markers", obj_doorButton_empty);
	//		var button6 = instance_create_layer(xx * 32, yy * 32 + 32, "Markers", obj_doorButton_destroy);	
	//	#region //giving values to the buttons
	
	//		button1.mouseTileX = mouseTileX; button1.mouseTileY = mouseTileY;	button2.mouseTileX = mouseTileX; button2.mouseTileY = mouseTileY;
	//		button3.mouseTileX = mouseTileX; button3.mouseTileY = mouseTileY;	button4.mouseTileX = mouseTileX; button4.mouseTileY = mouseTileY;
	//		button5.mouseTileX = mouseTileX; button5.mouseTileY = mouseTileY;	button6.mouseTileX = mouseTileX; button6.mouseTileY = mouseTileY;
	
	//	#endregion
	//	}
	//}
	
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
	
		//cursor_spawned = false;
		placed_tile = true;
	}


	//removing with mouse
	
	if (mRight && canBuild && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
		
		ds_grid_set(global.mainGrid, xx,yy,ID.empty);
		ds_grid_set(global.RoomGrid, xx,yy, 0);
		ds_grid_set(global.MarkerGrid, xx,yy, 0);
		if (ds_grid_get_max(global.DoorGrid,xx*2,yy*2,xx*2+1,yy*2+1) > 0) {
			ds_grid_set_region(global.DoorGrid,xx*2,yy*2,xx*2+1,yy*2+1,0);
			surface_free(door_surface);
		}
	
		ds_grid_set(global.SubimgGrid, xx,yy - 1,autotile(xx,yy - 1));
		ds_grid_set(global.SubimgGrid, xx,yy + 1,autotile(xx,yy + 1));
		ds_grid_set(global.SubimgGrid, xx - 1,yy,autotile(xx - 1,yy));
		ds_grid_set(global.SubimgGrid, xx + 1,yy,autotile(xx + 1,yy));
	
		//cursor_spawned = false
		global.roomCount ++;
	}
}
