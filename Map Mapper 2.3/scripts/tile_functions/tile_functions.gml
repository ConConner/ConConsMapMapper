function add_tiles() {
	xx = floor (mouse_x/32);
	yy = floor(mouse_y/32);


	//adding with mouse

	//adding markers
	//if (did_hold && !choosingMarker && ds_grid_get(global.mainGrid, xx, yy) = ID.filled) {
		
	//	did_hold = false;
		
	//	canBuild = false;
	//	choosingMarker = true;
	//	var storeX = xx
	//	var storeY = yy
		
	//	var button1 = instance_create_layer(storeX * 32 - 32, storeY * 32 + 16, "Markers", obj_marker_button1);
	//	var button2 = instance_create_layer(storeX * 32 - 32, storeY * 32 - 16, "Markers", obj_marker_button2);
	//	var button3 = instance_create_layer(storeX * 32, storeY * 32 - 32, "Markers", obj_marker_button3);
	//	var button5 = instance_create_layer(storeX * 32 + 32, storeY * 32 + 16, "Markers", obj_marker_button5);
	//	var button4 = instance_create_layer(storeX * 32 + 32, storeY * 32 - 16, "Markers", obj_marker_button4);
	//	var button6 = instance_create_layer(storeX * 32, storeY * 32 + 32, "Markers", obj_marker_button6);
	//#region //setting x/y coordinates for buttons
	
	//	button1.gridX = xx; button1.gridY = yy;		button2.gridX = xx; button2.gridY = yy;
	//	button3.gridX = xx; button3.gridY = yy;		button4.gridX = xx; button4.gridY = yy;
	//	button5.gridX = xx; button5.gridY = yy;		button6.gridX = xx; button6.gridY = yy;
	//#endregion
	//}
	
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
	
	
	//selecting a tile
	if (canBuild && mLeftReleased && !placed_tile && !selecting_tile && !click_moved) {
		
		var m = ds_grid_get(global.mainGrid, xx, yy);
		
		if (m == 1) {
			//setting up selection
			cam_lock = true;
			canBuild = false;
			selecting_tile = true;
			tile_xscale_goal = 1.5;
			tile_yscale_goal = 1.5;
			
			obj_camera.cam_x_goal = global.xx*tile_size + tile_size/2;
			obj_camera.cam_y_goal = global.yy*tile_size + tile_size/2;
			
			tile_xx = global.xx;
			tile_yy = global.yy;
		}
	}
	
	
	//editing rooms
	if (ds_grid_get(global.mainGrid, xx, yy) = ID.filled && canBuild) {
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
	
		global.roomCount ++;
	}
}
	
function autotile(xx,yy) {

	if (ds_grid_get(global.mainGrid,xx,yy) == ID.filled) {
	
		var up = false;
		var down = false;
		var left = false;
		var right = false;
		var mrDown = false;
		var mrUp = false;
		var mrLeft = false;
		var mrRight = false;

		//Auto tiling
		var myRoom = ds_grid_get(global.RoomGrid,xx,yy);
		var myColor = ds_grid_get(global.ColorGrid,xx,yy);
 
		if (myRoom == ds_grid_get(global.RoomGrid,xx,yy - 1)) mrUp = true;
		else mrUp = false;
		if (myRoom == ds_grid_get(global.RoomGrid,xx,yy + 1)) mrDown = true;
		else mrDown = false;
		if (myRoom == ds_grid_get(global.RoomGrid,xx - 1,yy)) mrLeft = true;
		else mrLeft = false;
		if (myRoom == ds_grid_get(global.RoomGrid,xx + 1,yy)) mrRight = true;
		else mrRight = false;
 
		if (yy !=0) up = ds_grid_get(global.mainGrid,xx,yy - 1) * mrUp;
		if (yy !=global.grid_size-1) down = ds_grid_get(global.mainGrid,xx,yy + 1) * mrDown;
		if (xx !=0) left = ds_grid_get(global.mainGrid,xx - 1,yy) * mrLeft;
		if (xx !=global.grid_size-1) right = ds_grid_get(global.mainGrid,xx + 1,yy) * mrRight;
 
		return myColor * 16 + (8*right + 4*left + 2*down + up);
	
	}
	else return 0;


}