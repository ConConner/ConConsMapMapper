function add_tiles() {
	var xx = global.xx;
	var yy = global.yy;
	
	var tile = ds_grid_get(global.tile_grid, xx, yy);
	if (is_struct(tile)) {
	
		//setting _up variables for the rooms next to the existing one
		if (xx != 0) var tile_left = ds_grid_get(global.tile_grid, xx - 1, yy);
		if (xx != global.grid_width - 1) var tile_right = ds_grid_get(global.tile_grid, xx + 1, yy);
		if (yy != 0) var tile_up = ds_grid_get(global.tile_grid, xx, yy - 1);
		if (yy != global.grid_height - 1) var tile_down = ds_grid_get(global.tile_grid, xx, yy + 1);

		if (canBuild) {

			//editing rooms
			if (mLeft && tile.main = ID.filled) {
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
}
	
function autotile(xx, yy) {

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
	
function get_pixel_color(_x, _y) {
	
	var _c = draw_getpixel(_x, _y)
	if (obj_gameController.old_tool == tool.door_tool && old_tool != current_tool) global.connection_color = _c;
	else if (obj_gameController.old_tool == tool.marker_tool && old_tool != current_tool) global.marker_color = _c;
	else global.selected_color = _c;
	
}
	
function replace_room_color(_room_number, _col) {
	
	for (var i = 0; i < global.grid_width; i++) {
		for (var j = 0; j < global.grid_height; j++) {
			
			//looping through the grid and checking if the tiles have the same room
			var _tile = ds_grid_get(global.tile_grid, i, j);
			
			if (_tile.rm_nmb == _room_number) _tile.col = _col;
			
		}
	}
	
}

function replace_same_color(_col, _col2) {
	
	for (var i = 0; i < global.grid_width; i++) {
		for (var j = 0; j < global.grid_height; j++) {
			
			//looping through the grid and checking if the tiles have the same col1
			var _tile = ds_grid_get(global.tile_grid, i, j);
			
			if (_tile.col == _col) _tile.col = _col2;
			
		}
	}
	
}
	
	
//Markers
function reload_markers() {
	checking_sprite = sprite_add(marker_url, 1, false, false, 0, 0);
}

function draw_marker_set(_x, _y) {
	
	for (var i = 0; i < tile_amount; i++) {
		
		if (selected_marker == i) {
			draw_nine_slice(spr_edge_nineslice, _x - 2, _y + 40 * i - (40 * tiles_per_page * tile_page) - 2, _x + 34, _y + 40 * i - (40 * tiles_per_page * tile_page) + 34);
		}
		
		draw_sprite_ext(marker_sprite, i, _x, _y + 40 * i - (40 * tiles_per_page * tile_page), 1, 1, 0, global.marker_color, 1);
		
	}
	
}

function get_selected_marker(_x, _y) {
	
	var _return = noone;
	
	for (var i = 0; i < obj_gameController.tile_amount; i++) {
		
		var _x1 = _x
		var _y1 = _y + 40 * i - (40 * obj_gameController.tiles_per_page * obj_gameController.tile_page)
		
		if (point_in_rectangle(global.mouse_pos_x, global.mouse_pos_y, _x1, _y1, _x1 + 32, _y1 + 32)) {
			_return = i;
		}
		
	}
	
	return(_return);
	
}