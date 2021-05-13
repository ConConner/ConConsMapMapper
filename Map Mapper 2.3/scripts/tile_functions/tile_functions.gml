function add_tiles() {
	var xx = global.xx;
	var yy = global.yy;
	
	var tile = ds_grid_get(global.tile_grid, xx, yy);
	
	//setting _up variables for the rooms next to the existing one
	if (xx != 0) var tile_left = ds_grid_get(global.tile_grid, xx - 1, yy);
	if (xx != global.grid_width - 1) var tile_right = ds_grid_get(global.tile_grid, xx + 1, yy);
	if (yy != 0) var tile_up = ds_grid_get(global.tile_grid, xx, yy - 1);
	if (yy != global.grid_height - 1) var tile_down = ds_grid_get(global.tile_grid, xx, yy + 1);

	if (canBuild) {
		//selecting a tile
		//if (mLeftReleased && !placed_tile && !selecting_tile && !click_moved && door_menu_close_timer >= 6) {
		
		//	var m = ds_grid_get(global.tile_grid, xx, yy);
		
		//	if (m == 1) {
		//		//setting _up selection
		//		cam_lock = true;
		//		canBuild = false;
		//		selecting_tile = true;
		//		tile_xscale_goal = 1.5;
		//		tile_yscale_goal = 1.5;
		//		selection_open_timer = 0;
			
		//		obj_camera.cam_x_goal = global.xx*tile_size + tile_size/2;
		//		obj_camera.cam_y_goal = global.yy*tile_size + tile_size/2;
			
		//		tile_xx = global.xx;
		//		tile_yy = global.yy;
			
		//	}
		//}
	
	
		//editing rooms
		if (tile.main = ID.filled) {
			global.roomCount = tile.rm_nmb;
		}
	
		//adding tiles
		if (mLeft && tile.main = ID.empty) {
		
			tile.main = ID.filled;
			tile.rm_nmb = global.roomCount;
			tile.col = global.selected_color;
						
			//autotiling
			tile.subimg = autotile(xx,yy);
			
			if (xx != 0) tile_left.subimg = autotile(xx - 1,yy);
			if (xx != global.grid_width - 1) tile_right.subimg = autotile(xx + 1,yy);
			if (yy != 0) tile_up.subimg = autotile(xx,yy - 1);
			if (yy != global.grid_height - 1) tile_down.subimg = autotile(xx,yy + 1);
	
			placed_tile = true;
		}


		//removing with mouse
	
		if (mRight && tile.main = ID.filled) {
		
			clear_cell(tile);
	
			if (xx != 0) tile_left.subimg = autotile(xx - 1,yy);
			if (xx != global.grid_width - 1) tile_right.subimg = autotile(xx + 1,yy);
			if (yy != 0) tile_up.subimg = autotile(xx,yy - 1);
			if (yy != global.grid_height - 1) tile_down.subimg = autotile(xx,yy + 1);
	
			global.roomCount ++;
			deleted_tile = true;
		}
	}
	
	//setting the new tile
	ds_grid_set(global.tile_grid, xx, yy, new tile_info(tile.main, tile.rm_nmb, tile.col, tile.subimg, tile.mrk, tile.door));
	
	if (xx != 0) ds_grid_set(global.tile_grid, xx - 1, yy, new tile_info(tile_left.main, tile_left.rm_nmb, tile_left.col, tile_left.subimg, tile_left.mrk, tile_left.door));
	if (xx != global.grid_width - 1) ds_grid_set(global.tile_grid, xx + 1, yy, new tile_info(tile_right.main, tile_right.rm_nmb, tile_right.col, tile_right.subimg, tile_right.mrk, tile_right.door));
	if (yy != 0) ds_grid_set(global.tile_grid, xx, yy - 1, new tile_info(tile_up.main, tile_up.rm_nmb, tile_up.col, tile_up.subimg, tile_up.mrk, tile_up.door));
	if (yy != global.grid_height - 1) ds_grid_set(global.tile_grid, xx, yy + 1, new tile_info(tile_down.main, tile_down.rm_nmb, tile_down.col, tile_down.subimg, tile_down.mrk, tile_down.door));
	
}
	
function autotile(xx,yy) {

	var tile = ds_grid_get(global.tile_grid,xx,yy);
	if (xx != 0) var tile_left = ds_grid_get(global.tile_grid,xx - 1,yy);
	if (xx != global.grid_width - 1) var tile_right = ds_grid_get(global.tile_grid,xx + 1,yy);
	if (yy != 0) var tile_up = ds_grid_get(global.tile_grid,xx,yy - 1);
	if (yy != global.grid_height - 1) var tile_down = ds_grid_get(global.tile_grid,xx,yy + 1);

	if (tile.main == ID.filled) {
	
		var _up = false;
		var _down = false;
		var _left = false;
		var _right = false;
		
		var mrDown = false;
		var mrUp = false;
		var mrLeft = false;
		var mrRight = false;

		//Auto tiling

		if (yy != 0) { if (tile.rm_nmb == tile_up.rm_nmb) mrUp = true; }
		else mrUp = false;
		
		if (yy != global.grid_height - 1) { if (tile.rm_nmb == tile_down.rm_nmb) mrDown = true; }
		else mrDown = false;
		
		if (xx != 0) { if (tile.rm_nmb == tile_left.rm_nmb) mrLeft = true; }
		else mrLeft = false;
		
		if (xx != global.grid_width - 1) { if (tile.rm_nmb == tile_right.rm_nmb) mrRight = true; }
		else mrRight = false;
		
 
		if (yy !=0) _up = tile_up.main * mrUp;
		if (yy !=global.grid_height-1) _down = tile_down.main * mrDown;
		if (xx !=0) _left = tile_left.main * mrLeft;
		if (xx !=global.grid_width-1) _right = tile_right.main * mrRight;
 
		return (8*_right + 4*_left + 2*_down + _up);
	
	}
	else return 0;


}