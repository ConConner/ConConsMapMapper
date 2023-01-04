function add_tiles() {
	var xx = global.xx;
	var yy = global.yy;
	
	var tile = ds_grid_get(global.tile_grid, xx, yy);
	if (is_struct(tile)) {

		if (canBuild) {

			//editing rooms
			if (mLeft && tile.main = ID.filled) {
				global.roomCount = tile.rm_nmb;
			}
	
			//adding
			if (mLeft && tile.main = ID.empty) {
		
				tile.main = ID.filled;
				tile.rm_nmb = global.roomCount;
				tile.col = global.selected_color;
				tile.border_c = c_white;
			
				placed_tile = true;
			}
			
			//removing
			if (mRight && tile.main = ID.filled) {

				clear_cell(tile);
				deleted_tile = true;
			}
		}
	
		autotile(xx, yy);
		
		autotile(xx - 1, yy);
		autotile(xx + 1, yy);
		autotile(xx, yy - 1);
		autotile(xx, yy + 1);
		
		autotile(xx - 1, yy - 1);
		autotile(xx + 1, yy - 1);
		autotile(xx - 1, yy + 1);
		autotile(xx + 1, yy + 1);
	}
}
	
function autotile(xx, yy) { //checks all the surrounding tiles and updates the main tile accordingly
	
	if (xx < 0 || xx >= global.grid_width || yy < 0 || yy >= global.grid_height) return;
	
	var tile = ds_grid_get(global.tile_grid,xx,yy); //main tile

	if (tile.main == ID.filled) {
	
		var _tiles = grab_surrounding_tiles(xx, yy); //surrounding tiles
		var _subimg = 0;
		
		//checking if tile exists and is same room
		if (_tiles[0].rm_nmb != tile.rm_nmb) _subimg |= 128; //top right
		if (_tiles[1].rm_nmb != tile.rm_nmb) _subimg |= 64; //top left
		if (_tiles[2].rm_nmb != tile.rm_nmb) _subimg |= 32; //bottom right
		if (_tiles[3].rm_nmb != tile.rm_nmb) _subimg |= 16; //bottom left
		if (_tiles[4].rm_nmb != tile.rm_nmb) _subimg |= 8; //right
		if (_tiles[5].rm_nmb != tile.rm_nmb) _subimg |= 4; //left
		if (_tiles[6].rm_nmb != tile.rm_nmb) _subimg |= 2; //down
		if (_tiles[7].rm_nmb != tile.rm_nmb) _subimg |= 1; //up
		
		ds_grid_set(global.tile_grid, xx, yy, new tile_info(tile.main, tile.rm_nmb, tile.col, _subimg, tile.mrk, tile.door, tile.mrk_c, tile.mrk_a, tile.border_c));
	}
	else return 0;


}

function grab_surrounding_tiles(xx, yy) { //grabs the surrounding map tiles (sets an empty tile if it doesnt exist)
	
	var _list;
	var _empty = new tile_info(0, 0, 0, 0, 0, [[hatch.empty, 0],[hatch.empty, 0],[hatch.empty, 0],[hatch.empty, 0], c_white, 1, c_white]);
	for (var i = 0; i < 8; i++) {
		_list[i] = _empty;
	}
	
	//adjacent tiles
	if (xx != 0) _list[5] = ds_grid_get(global.tile_grid,xx - 1,yy);
	if (xx != global.grid_width - 1) _list[4] = ds_grid_get(global.tile_grid,xx + 1,yy);
	if (yy != 0) _list[7] = ds_grid_get(global.tile_grid,xx,yy - 1);
	if (yy != global.grid_height - 1) _list[6] = ds_grid_get(global.tile_grid,xx,yy + 1);
	
	//diagonal tiles
	if (xx != 0 && yy != 0) _list[1] = ds_grid_get(global.tile_grid,xx - 1, yy - 1);
	if (xx != global.grid_width - 1 && yy != 0) _list[0] = ds_grid_get(global.tile_grid,xx + 1,yy - 1);
	if (xx != 0 && yy != global.grid_height - 1) _list[3] = ds_grid_get(global.tile_grid,xx - 1,yy + 1);
	if (xx != global.grid_width - 1 && yy != global.grid_height - 1) _list[2] = ds_grid_get(global.tile_grid,xx + 1,yy + 1);
	
	return _list;
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